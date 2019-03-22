#include <stdio.h> 
#include <stdlib.h>
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/types.h> 
#include <unistd.h> 
#include <sys/wait.h> 

int N;
float E;
float T;
int P;
int L;
int* idarr;

float fabsm(float a){
	if(a<0)
	return -1*a;
return a;
}
struct msg{
    int senderid;
    float val;
};
void send(int sender_k,int receiver_k,void* msg1)
{
    if(write(idarr[receiver_k],msg1,8*sizeof(char))!=8)
    {
        struct msg* msg2=msg1;
        printf("error in write\n");
    }
    // close(id);
}
void recv(int receiver_k,void* msg1)
{
    while(read(idarr[receiver_k],msg1,8*sizeof(char))<8); 
}
int nWorkers;
void scheduler(int works[][2]) {
    nWorkers = P;
    int slice = (N-2)/nWorkers;
    int residual = N-2 - (nWorkers * slice);
    for (int i = 0; i < nWorkers; ++i) {
        works[i][0]=i*slice+1;
        works[i][1]=(i+1)*slice+1;
    }
    if (residual != 0) {
        for (int i = 0; i < nWorkers; ++i) {
            if (i != 0) works[i][0] = works[i - 1][1];
            if (residual-- > 0) works[i][1] = works[i][0] + slice + 1;
            else works[i][1] = works[i][0] + slice;
        }
    }

}
int main(int argc, char *argv[])
{
    if(argc< 2){
        printf("Need input filename\n");
        exit(0);
    }
    char *filename;
    filename = argv[1];
    int fd = open(filename, 0);
    char c;
    float parameters[5];

    for (int i = 0; i < 5; i++)
    {
        float figure = 0.0;
        read(fd, &c, 1);
        float tens = 10.0;
        int decimal = 0;
        while (c != '\n'&&c>0)
        {
            // printf(1, "%c\n", c);
            if (c == '.')
            {
                decimal = 1;
            }
            else if (!decimal)
            {
                figure = 10*figure + (c - '0');
            }
            else
            {
                figure = figure + (c - '0')/tens;
                tens = tens*10;
            }
            if(read(fd, &c, 1)==0)
                break;
        }
        parameters[i] = figure;
        // printf(1, "%d\n", (int)parameters[i]);
    }

    N = (int)parameters[0];
    E = parameters[1];
    T = parameters[2];
    P = (int)parameters[3];
    L = (int)parameters[4];
    close(fd);
    char pipearr[P+1][10];
    int works[P][2];
    idarr=(int*)malloc((P+1)*sizeof(int));
    int i,j,k;
    for(i=0;i<=P;i++)
    {
        sprintf(pipearr[i],"pipearr%d",i);
        mkfifo(pipearr[i], 0666);  
        // printf("id=%s\n",pipearr[i]);
    }
    if(N==1)
    {
        printf("%d\n",0);
        exit(0);
    }
	float diff;
	float mean;
	float u[N][N];
	float w[N][N];
    scheduler(works);
	int count=0;
	mean = 0.0;
	for (i = 0; i < N; i++){
		u[i][0] = T;
        u[i][N-1] = T;
        u[0][i] = T;
		u[N-1][i] = 0.0;
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
	}
	mean /= (4.0 * N);
	for (i = 1; i < N-1; i++ )
		for ( j= 1; j < N-1; j++) u[i][j] = mean;
    
    if(N==2)
    {
        for(i =0; i <N; i++){
            for(j = 0; j<N; j++)
                printf("%d ",((int)u[i][j]));
            printf("\n");
        }
        exit(0);
    }
    int ppid=P;
    int recids[P];
    int original_ppid=getpid();
    for(k=0;k<P;k++)
    {
        int child=fork();
        for(i=0;i<=P;i++)
        {
            idarr[i]=open(pipearr[i],O_RDWR);
        }
        if(child==0)
        {
            int s=works[k][0];
            int e=works[k][1];
            int original_pid=getpid();
            int pid=k;
            while(1)
            {
                diff = 0.0;
                for(i =s; i < e; i++){
                    for(j =1 ; j < N-1; j++){
                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
                                u[i][j-1] + u[i][j+1])/4.0;
                        if( fabsm(w[i][j] - u[i][j]) > diff )
                            diff = fabsm(w[i][j]- u[i][j]);	
                    }
                }
                
                count++;
                struct msg msg2;
                msg2.val=diff;
                msg2.senderid=pid;
                send(pid,ppid,(void*)&msg2);
                recv(pid,(void*)&msg2);
                if((int)msg2.val==0)
                {
                    int ns=s;
                    int ne=e;
                    if(k==0)
                        ns=ns-1;
                    if(k==P-1)
                        ne=ne+1;
                    for(i =ns; i <ne; i++){
                        for(j = 0; j<N; j++)
                            printf("%d ",((int)u[i][j]));
                        printf("\n");
                    }
                    // printf("process exiting\n");
                    exit(0);
                }

                for (i =s; i< e; i++)	
                    for (j =1; j< N-1; j++) u[i][j] = w[i][j];

                if(P>1) 
                {
                    int other_id=-1;
                    if(k==0){
                        for(j=1;j<N-1;j++)
                        {
                            struct msg msg1;
                            recv(pid,(void*)&msg1);
                            if(other_id==-1)
                                other_id=msg1.senderid;
                            u[e][j]=msg1.val;
                        }
                        for(j=1;j<N-1;j++)
                        {
                            struct msg msg1;
                            msg1.senderid=pid;
                            msg1.val=u[e-1][j];
                            send(pid,other_id,(void*)&msg1);
                        }
                    }
                    else if(k==P-1){
                        for(j=1;j<N-1;j++)
                        {
                            struct msg msg1;
                            msg1.senderid=pid;
                            msg1.val=u[s][j];
                            send(pid,recids[k-1],(void*)&msg1);
                        }
                        for(j=1;j<N-1;j++)
                        {
                            struct msg msg1;
                            recv(pid,(void*)&msg1);
                            u[s-1][j]=msg1.val;
                        }
                    }
                    else
                    {
                        for(j=1;j<N-1;j++)
                        {
                            struct msg msg1;
                            msg1.senderid=pid;
                            msg1.val=u[s][j];
                            send(pid,recids[k-1],(void*)&msg1);
                        }
                        int t=0;
                        for(j=0;j<2*N-4;j++)
                        {
                            struct msg msg1;
                            recv(pid,(void*)&msg1);
                            if(other_id==-1&&msg1.senderid!=recids[k-1])
                                other_id=msg1.senderid;

                            if(msg1.senderid==recids[k-1])
                            {
                                u[s-1][t+1]=msg1.val;
                                t++;
                            }
                            else
                                u[e][j-t+1]=msg1.val;
                        }
                        for(j=1;j<N-1;j++)
                        {
                            struct msg msg1;
                            msg1.senderid=pid;
                            msg1.val=u[e-1][j];
                            send(pid,other_id,(void*)&msg1);
                        }
                    }
                }   
            }
        }
        else
        {
            recids[k]=k;
        }
    }
    while(1)
    {
        int cmd=1;
        float maxdiff=0.0;
        count++;
        for (i=0;i<P;i++)
        {
            struct msg msg1;
            recv(ppid,(void*)&msg1);
            if(msg1.val>maxdiff)
                maxdiff=msg1.val;
        }
        // printf("all msgs received and maxdiff=%f\n",maxdiff);
        if(maxdiff<= E || count > L){ 
            cmd=0;
            int status;
            struct msg msg1;
            msg1.senderid=ppid;
            msg1.val=cmd;
            for(i=0;i<P;i++)
            {
                send(ppid,recids[i],(void*)&msg1);
                wait(&status);
            }
            for(int i=0;i<P+1;i++)
                unlink(pipearr[i]);
            exit(0);
        }
        else
        {
            struct msg msg1;
            msg1.senderid=ppid;
            msg1.val=cmd;
            for(i=0;i<P;i++)
            {
                send(ppid,recids[i],(void*)&msg1);
            }
        }
    }
}