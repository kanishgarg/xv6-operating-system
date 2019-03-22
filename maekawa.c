#include "types.h"
#include "stat.h"
#include "user.h"
int P;
int P1;
int P2;
int P3;

#define REQUEST 1
#define LOCKED 2
#define RELEASE 3
#define FAILED 4
#define RELINQUISH 5
#define INQUIRE 6

int ppid;

int deque_min(int* waitingQ,int* sizeadd)
{
    int size=*sizeadd;
    int count=0;
    int min_id=10000;
    int idx=0;
    if(size==0)
        printf(1,"waitingQ size is zero\n");
    for(int i=0;i<30;i++)
    {
        if(waitingQ[i]!=0)
        {
            count++;
            if(waitingQ[i]<min_id)
            {
                min_id=waitingQ[i];
                idx=i;
            }
            if(count==size)
            break;
        }
    }
    waitingQ[idx]=0;
    size--;
    *sizeadd=size;
    return min_id;
}
struct msg{
    int senderid;
    int val;
};
int sqrt(int n)
{
    int i;
    for(i=1;i<=n;i++)
    {
        if(i*i==n)
        break;
    }
    return i;
}
void acquirelock(int* peers,int num_peers,int* waitingQ,int* sizeadd,int* tadd,int pid)
{
    int locked=0;
    int locked_by=0;
    int inquired_someone=0;
    int count=0;
    int size=*sizeadd;
    int t=*tadd;
    int inquireQ[30];
    int failedQ[30];
    int failedQ_size=0;
    int inquireQ_size=0;
    int failedQ_tail=0;
    int inquireQ_tail=0;
    int locked_count=0;

    for(int i=0;i<num_peers;i++)
    {
        struct msg message3;
        message3.senderid=pid;
        message3.val=REQUEST;
        send(pid,peers[i],(void*)&message3);
    }
    if(size!=0)
    {
        int min_id=deque_min(waitingQ,&size);
        struct msg message2;
        message2.val=LOCKED;
        message2.senderid=pid;
        send(pid,min_id,(void*)&message2);
        locked=1;
        locked_by=min_id;
        if(size!=0)
        {
            struct msg message4;
            message4.val=FAILED;
            message4.senderid=pid;
            int count=0;
            for(int j=0;j<30;j++)
            {
                if(waitingQ[j]!=0)
                {
                    count++;
                    send(pid,waitingQ[j],(void*)&message4);
                }
                if(count==size)
                break;
            }
        }
        // printf(1,"%d is locked by %d\n",pid,locked_by);
    }
    while(1)
    {
        count++;
        if(t>=30)
        printf(1,"kanish blunder kar diya tune\n");
        struct msg message;
        recv((void*)&message);
        int sender_id=message.senderid;
        if(message.val==REQUEST)
        {
            if(!locked)
            {
                struct msg message2;
                message2.val=LOCKED;
                message2.senderid=pid;
                send(pid,message.senderid,(void*)&message2);
                locked=1;
                locked_by=sender_id;
                // printf(1,"%d is locked by %d\n",pid,locked_by);
            }
            else
            {
                if(t>=30)
                    printf(1,"waiting Q is full error\n");
                int min_id=10000;
                if(size>0)
                {
                    int count=0;
                    for(int i=0;i<30;i++)
                    {
                        if(waitingQ[i]!=0)
                        {
                            count++;
                            if(waitingQ[i]<min_id)
                            min_id=waitingQ[i];
                        }
                        if(count==size)
                        break;
                    }
                }
                waitingQ[t++]=sender_id;
                size++;
                if(min_id<sender_id||sender_id>locked_by)
                {
                    struct msg message2;
                    message2.val=FAILED;
                    message2.senderid=pid;
                    send(pid,sender_id,(void*)&message2);
                }
                else if(min_id>sender_id&&sender_id<locked_by)
                {
                    if(min_id<locked_by)
                    {
                        struct msg message2;
                        message2.val=FAILED;
                        message2.senderid=pid;
                        send(pid,min_id,(void*)&message2);   
                    }
                    if(!inquired_someone)
                    {
                        struct msg message2;
                        message2.val=INQUIRE;
                        message2.senderid=pid;
                        send(pid,locked_by,(void*)&message2);
                        inquired_someone=1;
                    }
                }
                
            }    
        }
        else if(message.val==RELEASE)
        {
            locked=0;
            if(inquired_someone)
                inquired_someone=0;

            if(size!=0)
            {
                int min_id=deque_min(waitingQ,&size);
                struct msg message2;
                message2.val=LOCKED;
                message2.senderid=pid;
                send(pid,min_id,(void*)&message2);
                locked=1;
                locked_by=min_id;
                // printf(1,"%d is locked by %d\n",pid,locked_by);
            }
        }
        else if(message.val==RELINQUISH)
        {
            //relinquish
            inquired_someone=0;
            int min_id=deque_min(waitingQ,&size);
            if(min_id>sender_id)
                printf(1,"error with min_id=%d and sender id=%d\n",min_id,sender_id);
            struct msg message2;
            message2.val=LOCKED;
            message2.senderid=pid;
            send(pid,min_id,(void*)&message2);
            locked=1;
            locked_by=min_id;
            // printf(1,"%d is locked by %d\n",pid,locked_by);
            waitingQ[t++]=sender_id;
            size++;

        }
        else if(message.val==LOCKED)
        {
            locked_count++;
            if(locked_count==num_peers)
            {
                *sizeadd=size;
                *tadd=t;
                return;
            }
            if(failedQ_size!=0)
            {
                int count=0;
                for(int i=0;i<30;i++)
                {
                    if(failedQ[i]!=0)
                    count++;
                    if(failedQ[i]==sender_id)
                    {
                        failedQ[i]=0;
                        failedQ_size--;
                        break;
                    }
                    if(count==failedQ_size)
                    break;
                }
            }
        }
        else if(message.val==FAILED)
        {
            int count=0;
            int failed=1;
            for(int i=0;i<30;i++)
            {
                if(failedQ[i]!=0)
                {
                    count++;
                    if(failedQ[i]==sender_id)
                    {
                        failed=0;
                        // printf(1,"failed\n");
                        break;
                    }
                }
                if(count==failedQ_size)
                break;
            }
            if(failed)
            {
                failedQ[failedQ_tail++]=sender_id;
                failedQ_size++;
                int j=0;
                while(inquireQ_size!=0)
                {
                    struct msg message2;
                    message2.senderid=pid;
                    message2.val=RELINQUISH;
                    failedQ[failedQ_tail++]=inquireQ[j];
                    failedQ_size++;
                    send(pid,inquireQ[j++],(void*)&message2);
                    inquireQ_size--;
                    locked_count--;    
                }
                inquireQ_tail=0;
            }
        }
        else if(message.val==INQUIRE)
        {
            //inquire
            if(failedQ_size!=0)
            {
                locked_count--;
                struct msg message2;
                message2.senderid=pid;
                message2.val=RELINQUISH;
                send(pid,sender_id,(void*)&message2);
                failedQ[failedQ_tail++]=sender_id;
                failedQ_size++;
            }
            else
            {
                inquireQ[inquireQ_tail++]=sender_id;
                inquireQ_size++;
            }
            
        }
        else
        {
            if(message.val!=INQUIRE)
            printf(1,"message value=%d by %d in %d at count=%d\n",message.val,sender_id,pid,count);
        }
        
    }
}
void releaselock(int* peers,int num_peers,int* waitingQ,int size,int t,int pid)
{
    struct msg message3;
    message3.senderid=pid;
    message3.val=RELEASE;
    send(pid,ppid,(void*)&message3);
    for(int i=0;i<num_peers;i++)
    {
        if(peers[i]!=pid)
        send(pid,peers[i],(void*)&message3);
    }
    // printf(1,"entered releaselock\n");
    int locked=0;
    int locked_by=0;
    int inquired_someone=0;

    struct msg message;
    if(size!=0)
    {
        int min_id=deque_min(waitingQ,&size);
        struct msg message2;
        message2.val=LOCKED;
        message2.senderid=pid;
        send(pid,min_id,(void*)&message2);
        locked=1;
        locked_by=min_id;
        if(size!=0)
        {
            struct msg message4;
            message4.val=FAILED;
            message4.senderid=pid;
            int count=0;
            for(int j=0;j<30;j++)
            {
                if(waitingQ[j]!=0)
                {
                    count++;
                    send(pid,waitingQ[j],(void*)&message4);
                }
                if(count==size)
                break;
            }
        }
        // printf(1,"%d is locked by %d\n",pid,locked_by);
    }
    while(1)
    {
        if(t>=30)
        printf(1,"kanish blunder kar diya tune\n");
        recv((void*)&message);
        int sender_id=message.senderid;
        if(message.val==REQUEST)
        {
            if(!locked)
            {
                struct msg message2;
                message2.val=LOCKED;
                message2.senderid=pid;
                send(pid,message.senderid,(void*)&message2);
                locked=1;
                locked_by=sender_id;
                // printf(1,"%d is locked by %d\n",pid,locked_by);
            }
            else
            {
                if(t==30)
                    t=0;
                int min_id=10000;
                if(size>0)
                {
                    int count=0;
                    for(int i=0;i<30;i++)
                    {
                        if(waitingQ[i]!=0)
                        {
                            count++;
                            if(waitingQ[i]<min_id)
                            min_id=waitingQ[i];
                        }
                        if(count==size)
                        break;
                    }
                }
                waitingQ[t++]=sender_id;
                size++;
                if(min_id<sender_id||sender_id>locked_by)
                {
                    struct msg message2;
                    message2.val=FAILED;
                    message2.senderid=pid;
                    send(pid,sender_id,(void*)&message2);
                }
                else if(min_id>sender_id&&sender_id<locked_by)
                {
                    if(min_id<locked_by)
                    {
                        struct msg message2;
                        message2.val=FAILED;
                        message2.senderid=pid;
                        send(pid,min_id,(void*)&message2);   
                    }
                    if(!inquired_someone)
                    {
                        struct msg message2;
                        message2.val=INQUIRE;
                        message2.senderid=pid;
                        send(pid,locked_by,(void*)&message2);
                        inquired_someone=1;
                    }
                }
                
            }
            
            
        }
        else if(message.val==RELEASE)
        {
            locked=0;
            if(inquired_someone)
                inquired_someone=0;

            if(size!=0)
            {
                int min_id=deque_min(waitingQ,&size);
                struct msg message2;
                message2.val=LOCKED;
                message2.senderid=pid;
                send(pid,min_id,(void*)&message2);
                locked=1;
                locked_by=min_id;
                // printf(1,"%d is locked by %d\n",pid,locked_by);
            }
        }
        else if(message.val==RELINQUISH)
        {
            //relinquish
            inquired_someone=0;
            int min_id=deque_min(waitingQ,&size);
            struct msg message2;
            message2.val=LOCKED;
            message2.senderid=pid;
            send(pid,min_id,(void*)&message2);
            locked=1;
            locked_by=min_id;
            // printf(1,"%d is locked by %d\n",pid,locked_by);
            waitingQ[t++]=sender_id;
            size++;
        }
        else if(sender_id==ppid)
        {
            // printf(1,"exiting");
            exit();
        }
    }
}

int main(int argc, char *argv[])
{
    if(argc< 2){
        printf(1,"Need input filename\n");
        exit();
    }
    char *filename;
    filename = argv[1];
    int fd = open(filename, 0);
    char c;
    int parameters[4];

    for (int i = 0; i < 4; i++)
    {
        int figure = 0;
        read(fd, &c, 1);
        while (c != '\n'&&c>0)
        {
            figure = 10*figure + (c - '0');
            if(read(fd, &c, 1)==0)
                break;
        }
        parameters[i] = figure;
        // printf(1, "%d\n", parameters[i]);
    }

    P =  parameters[0];
    P1 = parameters[1];
    P2 = parameters[2];
    P3 = parameters[3];
    close(fd);
    ppid=getpid();
    int root_P=sqrt(P);
    int process_ids[P];
    for(int k=0;k<P;k++)
    {
        int child=fork();
        if(child==0)
        {
            int waitingQ[30];
            for(int i=0;i<30;i++)
                waitingQ[i]=0;
            int size=0;
            int t=0;
            int num_peers=2*root_P-1;
            int peers[num_peers];
            int locked=0;
            int locked_by=0;
            int inquired_someone=0;
            int pid=getpid();
            if(k>=P1)
            {
                int i=0;
                while(i<num_peers)
                {
                    struct msg peerid;
                    recv((void*)&peerid);
                    if(peerid.senderid==ppid)
                    {
                        peers[i]=peerid.val;
                        i++;
                    }
                    else
                    {
                        waitingQ[t++]=peerid.senderid;
                        size++;
                    }
                }
            }
            
            if(k<P1){
                while(1)
                {
                    struct msg message;
                    recv((void*)&message);
                    int sender_id=message.senderid;
                    if(message.val==REQUEST)
                    {
                        if(!locked)
                        {
                            struct msg message2;
                            message2.val=LOCKED;
                            message2.senderid=pid;
                            send(pid,message.senderid,(void*)&message2);
                            locked=1;
                            locked_by=sender_id;
                            // printf(1,"%d is locked by %d\n",pid,locked_by);
                        }
                        else
                        {
                            if(t==30)
                                printf(1,"waiting Q full\n");
                            int min_id=10000;
                            if(size>0)
                            {
                                int count=0;
                                for(int i=0;i<30;i++)
                                {
                                    if(waitingQ[i]!=0)
                                    {
                                        count++;
                                        if(waitingQ[i]<min_id)
                                        min_id=waitingQ[i];
                                    }
                                    if(count==size)
                                    break;
                                }
                            }
                            waitingQ[t++]=sender_id;
                            size++;
                            if(min_id<sender_id||sender_id>locked_by)
                            {
                                struct msg message2;
                                message2.val=FAILED;
                                message2.senderid=pid;
                                send(pid,sender_id,(void*)&message2);
                            }
                            else if(min_id>sender_id&&sender_id<locked_by)
                            {
                                if(min_id<locked_by)
                                {
                                    struct msg message2;
                                    message2.val=FAILED;
                                    message2.senderid=pid;
                                    send(pid,min_id,(void*)&message2);   
                                }
                                if(!inquired_someone)
                                {
                                    struct msg message2;
                                    message2.val=INQUIRE;
                                    message2.senderid=pid;
                                    send(pid,locked_by,(void*)&message2);
                                    inquired_someone=1;
                                }
                            }
                            
                        }
                        
                        
                    }
                    else if(message.val==RELEASE)
                    {
                        locked=0;
                        if(inquired_someone)
                            inquired_someone=0;

                        if(size!=0)
                        {
                            int min_id=deque_min(waitingQ,&size);
                            struct msg message2;
                            message2.val=LOCKED;
                            message2.senderid=pid;
                            send(pid,min_id,(void*)&message2);
                            locked=1;
                            locked_by=min_id;
                            // printf(1,"%d is locked by %d\n",pid,locked_by);
                        }
                    }
                    else if(message.val==RELINQUISH)
                    {
                        //relinquish
                        inquired_someone=0;
                        int min_id=deque_min(waitingQ,&size);
                        if(min_id>sender_id)
                            printf(1,"error with min_id=%d and sender id=%d\n",min_id,sender_id);
                        struct msg message2;
                        message2.val=LOCKED;
                        message2.senderid=pid;
                        send(pid,min_id,(void*)&message2);
                        locked=1;
                        locked_by=min_id;
                        // printf(1,"%d is locked by %d\n",pid,locked_by);
                        waitingQ[t++]=sender_id;
                        size++;

                    }
                    else if(sender_id==ppid)
                    {
                        // printf(1,"exiting process\n");
                        exit();
                    }
                }

            }
            else if(k>=P1&&k<P1+P2)
            {
                acquirelock(peers,num_peers,waitingQ, &size,&t,pid);
                printf(1,"%d acquired the lock at time %d\n",pid,uptime());
                printf(1,"%d released the lock at time %d\n",pid,uptime());
                releaselock(peers,num_peers,waitingQ,size,t,pid);
            }
            else
            {
                acquirelock(peers,num_peers,waitingQ,&size,&t,pid);
                printf(1,"%d acquired the lock at time %d\n",pid,uptime());
                sleep(200);
                printf(1,"%d released the lock at time %d\n",pid,uptime());
                releaselock(peers,num_peers,waitingQ,size,t,pid);
            }
        }
        else
        {
            process_ids[k]=child;
        }
    }
    for(int i=P1;i<P;i++)
    {
        int row_s=(i/root_P)*root_P;
        // printf(1,"peers of process %d\n",process_ids[i]);
        struct msg pmsg;
        pmsg.senderid=ppid;
        for(int j=0;j<root_P;j++)
        {
            pmsg.val=process_ids[row_s+j];
            if(row_s+j!=i)
            {
                send(ppid,process_ids[i], (void*)&pmsg);
                // printf(1,"peer_id=%d\n",pmsg.val);
            }
        }
        int col_s=(i%root_P);
        for(int j=0;j<root_P;j++)
        {
            pmsg.val=process_ids[col_s+j*root_P];
            send(ppid,process_ids[i], (void*)&pmsg);
            // printf(1,"peer_id=%d\n",pmsg.val);
        }
    }
    for(int i=0;i<P2+P3;i++)
    {
        struct msg message;
        recv((void*)&message);
    }
    // printf(1,"ppid=%d\n",ppid);
    struct msg message;
    message.senderid=ppid;
    message.val=0;
    for(int i=0;i<P;i++)
        send(ppid,process_ids[i],(void*)&message);
    for(int i=0;i<P;i++)
    {
        wait();
    }
    exit();
}