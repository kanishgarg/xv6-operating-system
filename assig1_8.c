#include "types.h"
#include "stat.h"
#include "user.h"

int sum(short int *arr,int n){
    int sum = 0;
    for(short int* i = arr; i < arr+n ;i++){
        sum += *(i); 
    }
    return sum;
}

int main(int argc, char *argv[])
{
    if(argc< 2){
        printf(1,"Need type and input filename\n");
        exit();
    }
    char *filename;
    filename=argv[2];
    int type = atoi(argv[1]);
    // printf(1,"Type is %d and filename is %s\n",type, filename);

    int tot_sum = 0;    
    float variance = 0.0;

    int size=1000;
    short arr[size];
    char c;
    int fd = open(filename, 0);
    for(int i=0; i<size; i++){
        read(fd, &c, 1);
        arr[i]=c-'0';
        read(fd, &c, 1);
    }   
    close(fd);
    // this is to supress warning
    // printf(1,"first elem %d\n", arr[0]);
  
    //----FILL THE CODE HERE for unicast sum and multicast variance
    int process_count = 8;
    int sub_size = size/process_count;
    int ppid = getpid();
    int pid = -1;
    for(int i = 0; i < process_count; i++){
    	pid = fork();
    	if(pid == 0){
    		if(i==process_count-1)
    		{
    			int sub_sum = sum(arr+sub_size*i,size-sub_size*i);
            	send(getpid(),ppid,(char*)&sub_sum);
            	exit();
    		}
            int sub_sum = sum(arr+sub_size*i,sub_size);
            send(getpid(),ppid,(char*)&sub_sum);
            exit();
            // sleep(3);
        }
        else {
            int sub_sum = 0;
            recv((char*)&sub_sum);
            tot_sum+=sub_sum;
        }
    }
    for (int i = 0; i < process_count; i++) {
        wait();
    }
    //------------------


    if(type==0){ //unicast sum
        printf(1,"Sum of array for file %s is %d\n", filename,tot_sum);
    }
    else{ //mulicast variance
        printf(1,"Variance of array for file %s is %d\n", filename,(int)variance);
    }
    
    exit();
}