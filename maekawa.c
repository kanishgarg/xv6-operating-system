#include "types.h"
#include "stat.h"
#include "user.h"


#define P 16
#define P1 5
#define P2 5
#define P3 6

#define REQUEST 1
#define LOCKED 2
#define RELEASE 3
#define FAILED 4
#define RELINQUISH 5
#define INQUIRE 6

int waitingQ[30];
int size;
int t;
int locked;
int locked_by;
int inquired_someone;
int pid;
int ppid;
int locked_count;
int failedQ[30];
int inquireQ[10];
int failedQ_size;
int inquireQ_size;
int failedQ_tail;
int inquireQ_tail;

int deque_min()
{
    int count=0;
    int min_id=100;
    int idx=0;
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
void acquirelock(int* peers,int num_peers)
{
    struct msg message;
    message.senderid=pid;
    message.val=REQUEST;
    for(int i=0;i<num_peers;i++)
    send(pid,peers[i],(void*)&message);
    while(1)
    {
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
            }
            else
            {
                if(t==30)
                    t=0;
                waitingQ[t++]=sender_id;
                size++;
                if(sender_id>locked_by)
                {
                    struct msg message2;
                    message2.val=FAILED;
                    message2.senderid=pid;
                    send(pid,sender_id,(void*)&message2);
                }
                else
                {
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
                int min_id=deque_min();
                struct msg message2;
                message2.val=LOCKED;
                message2.senderid=pid;
                send(pid,min_id,(void*)&message2);
                locked=1;
                locked_by=min_id;
            }
        }
        else if(message.val==RELINQUISH)
        {
            //relinquish
            inquired_someone=0;
            int min_id=deque_min();
            struct msg message2;
            message2.val=LOCKED;
            message2.senderid=pid;
            send(pid,min_id,(void*)&message2);
            locked=1;
            locked_by=min_id;
            waitingQ[t++]=sender_id;
            size++;

        }
        else if(message.val==LOCKED)
        {
            locked_count++;
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
            
            if(locked_count==num_peers)
                return;
        }
        else if(message.val==FAILED)
        {
            failedQ[failedQ_tail++]=sender_id;
            failedQ_size++;
            int j=0;
            while(inquireQ_size!=0)
            {
                struct msg message2;
                message2.senderid=pid;
                message2.val=RELINQUISH;
                send(pid,inquireQ[j++],(void*)&message2);
                inquireQ_size--;
            }
            inquireQ_tail=0;
        }
        else
        {
            //inquire
            if(failedQ_size!=0)
            {
                struct msg message2;
                message2.senderid=pid;
                message2.val=RELINQUISH;
                send(pid,sender_id,(void*)&message2);
            }
            else
            {
                inquireQ[inquireQ_tail++]=sender_id;
                inquireQ_size++;
            }
            
        }
    }
}
void releaselock(int* peers,int num_peers)
{
    struct msg message;
    message.senderid=pid;
    message.val=RELEASE;
    for(int i=0;i<num_peers;i++)
    send(pid,peers[i],(void*)&message);
    int temp=0;
    send(pid,ppid,(void*)&temp);
    while(1)
    {
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
            }
            else
            {
                if(t==30)
                    t=0;
                waitingQ[t++]=sender_id;
                size++;
                if(sender_id>locked_by)
                {
                    struct msg message2;
                    message2.val=FAILED;
                    message2.senderid=pid;
                    send(pid,sender_id,(void*)&message2);
                }
                else
                {
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
                int min_id=deque_min();
                struct msg message2;
                message2.val=LOCKED;
                message2.senderid=pid;
                send(pid,min_id,(void*)&message2);
                locked=1;
                locked_by=min_id;
            }
        }
        else if(message.val==RELINQUISH)
        {
            //relinquish
            inquired_someone=0;
            int min_id=deque_min();
            struct msg message2;
            message2.val=LOCKED;
            message2.senderid=pid;
            send(pid,min_id,(void*)&message2);
            locked=1;
            locked_by=min_id;
            waitingQ[t++]=sender_id;
            size++;
        }
        else if(sender_id==ppid)
        {
            exit();
        }
    }
}

int main(int argc, char *argv[])
{
    //Ignore it
    waitingQ[0]=0;
    size=0;
    t=0;
    //
    ppid=getpid();
    int root_P=sqrt(P);
    int process_ids[P];
    for(int k=0;k<P;k++)
    {
        int child=fork();
        if(child==0)
        {
            int num_peers=2*root_P-1;
            int peers[num_peers];
            locked=0;
            failedQ_size=0;
            inquireQ_size=0;
            failedQ_tail=0;
            inquireQ_tail=0;
            peers[0]=0;
            locked_by=peers[0];
            inquired_someone=0;
            pid=getpid();
            for(int i=0;i<num_peers;i++)
            {
                int id;
                recv((void*)&id);
                peers[i]=id;
                // printf(1,"process %d received peerid=%d\n",pid,id);
            }
            if(k<P1){
                struct msg message;
                while(1)
                {
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
                        }
                        else
                        {
                            if(t==30)
                                t=0;
                            waitingQ[t++]=sender_id;
                            size++;
                            if(sender_id>locked_by)
                            {
                                struct msg message2;
                                message2.val=FAILED;
                                message2.senderid=pid;
                                send(pid,sender_id,(void*)&message2);
                            }
                            else
                            {
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
                            int min_id=deque_min();
                            struct msg message2;
                            message2.val=LOCKED;
                            message2.senderid=pid;
                            send(pid,min_id,(void*)&message2);
                            locked=1;
                            locked_by=min_id;
                        }
                    }
                    else if(message.val==RELINQUISH)
                    {
                        //relinquish
                        inquired_someone=0;
                        int min_id=deque_min();
                        struct msg message2;
                        message2.val=LOCKED;
                        message2.senderid=pid;
                        send(pid,min_id,(void*)&message2);
                        locked=1;
                        locked_by=min_id;
                        waitingQ[t++]=sender_id;
                        size++;

                    }
                    else if(sender_id==ppid)
                    {
                        exit();
                    }
                }

            }
            else if(k>=P1&&k<P1+P2)
            {
                acquirelock(peers,num_peers);
                printf(1,"lock acquired by category 2 process with id=%d\n",pid);
                printf(1,"lock released by category 2 process with id=%d\n",pid);
                releaselock(peers,num_peers);
            }
            else
            {
                acquirelock(peers,num_peers);
                printf(1,"lock acquired by category 3 process with id=%d\n",pid);
                sleep(2);
                printf(1,"lock released by category 3 process with id=%d\n",pid);
                releaselock(peers,num_peers);
            }
            int cmd;
            recv((void*)&cmd);
            exit();
        }
        else
        {
            process_ids[k]=child;
        }
    }
    for(int i=0;i<P;i++)
    {
        int row_s=(i/root_P)*root_P;
        for(int j=0;j<root_P;j++)
        {
            if(row_s+j!=i)
            send(ppid,process_ids[i], (void*)&process_ids[row_s+j]);
        }
        int col_s=(i%root_P);
        for(int j=0;j<root_P;j++)
        send(ppid,process_ids[i], (void*)&process_ids[col_s+j*root_P]);
    }
    for(int i=0;i<P2+P3;i++)
    {
        int exit_msg;
        recv((void*)&exit_msg);
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