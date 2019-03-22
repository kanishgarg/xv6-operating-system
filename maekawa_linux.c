#include <stdio.h> 
#include <stdlib.h>
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/types.h> 
#include <unistd.h> 
#include <sys/wait.h> 

#define P 9
#define P1 2
#define P2 6
#define P3 1

#define REQUEST 1
#define LOCKED 2
#define RELEASE 3
#define FAILED 4
#define RELINQUISH 5
#define INQUIRE 6
char pipearr[P+1][11];
int idarr[P+1];
int ppid;

int deque_min(int* waitingQ,int* sizeadd)
{
    int size=*sizeadd;
    int count=0;
    int min_id=10000;
    int idx=0;
    if(size==0)
        printf("waitingQ size is zero\n");
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
    // if(min_id>19)
    // printf(1,"min_id=%d\n",min_id);
    return min_id;
}
struct msg{
    int senderid;
    int val;
};
int sqroot(int n)
{
    int i;
    for(i=1;i<=n;i++)
    {
        if(i*i==n)
        break;
    }
    return i;
}
void send(int sender_k,int receiver_k,void* msg1)
{
    if(write(idarr[receiver_k-1],msg1,8*sizeof(char))!=8)
    {
        struct msg* msg2=msg1;
        printf("error in write\n");
        printf("id=%d and msg1.val=%d and receiverk=%s\n",idarr[receiver_k-1],msg2->val,pipearr[receiver_k-1]);
    }
    // close(id);
}
void recv(int receiver_k,void* msg1)
{
    while(read(idarr[receiver_k-1],msg1,8*sizeof(char))<8); 
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
        printf("kanish blunder kar diya tune\n");
        struct msg message;
        recv(pid,(void*)&message);
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
                    printf("waiting Q is full error\n");
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
                printf("error with min_id=%d and sender id=%d\n",min_id,sender_id);
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
            printf("message value=%d by %d in %d at count=%d\n",message.val,sender_id,pid,count);
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
        printf("kanish blunder kar diya tune\n");
        recv(pid,(void*)&message);
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
            exit(0);
        }
    }
}

int main(int argc, char *argv[])
{
    ppid=P+1;
    for(int i=0;i<=P;i++)
    {
        sprintf(pipearr[i],"pipearr%d",i);
        mkfifo(pipearr[i], 0666);  
        // printf("id=%s\n",pipearr[i]);
    }
    int root_P=sqroot(P);
    int process_ids[P];
    for(int k=0;k<P;k++)
    {
        int child=fork();
        for(int i=0;i<=P;i++)
        {
            idarr[i]=open(pipearr[i],O_RDWR);
        }
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
            int pid=k+1;
            if(k>=P1)
            {
                int i=0;
                while(i<num_peers)
                {
                    struct msg peerid;
                    recv(pid,(void*)&peerid);
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
                    
                    // if(i==num_peers)
                    // sigpause();
                    //printf(1,"process %d received peerid=%d\n",pid,peerid.val);
                }
            }
            
            if(k<P1){
                while(1)
                {
                    // if(locked)
                    //     printf(1,"%d is locked by %d\n",pid,locked_by);
                    struct msg message;
                    recv(pid,(void*)&message);
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
                                printf("waiting Q full\n");
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
                            printf("error with min_id=%d and sender id=%d\n",min_id,sender_id);
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
                        exit(0);
                    }
                }

            }
            else if(k>=P1&&k<P1+P2)
            {
                acquirelock(peers,num_peers,waitingQ, &size,&t,pid);
                printf("lock acquired by category 2 process with id=%d\n",pid);
                printf("lock released by category 2 process with id=%d\n",pid);
                releaselock(peers,num_peers,waitingQ,size,t,pid);
            }
            else
            {
                acquirelock(peers,num_peers,waitingQ,&size,&t,pid);
                printf("lock acquired by category 3 process with id=%d\n",pid);
                sleep(2);
                printf("lock released by category 3 process with id=%d\n",pid);
                releaselock(peers,num_peers,waitingQ,size,t,pid);
            }
        }
        else
        {
            process_ids[k]=k+1;
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
        recv(ppid,(void*)&message);
    }
    // printf(1,"ppid=%d\n",ppid);
    struct msg message;
    message.senderid=ppid;
    message.val=0;
    for(int i=0;i<P;i++)
        send(ppid,process_ids[i],(void*)&message);
    for(int i=0;i<P;i++)
    {
        int status;
        wait(&status);
    }
    exit(0);
}