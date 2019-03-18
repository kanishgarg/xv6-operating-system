#include "types.h"
#include "stat.h"
#include "user.h"
// #include "signal.h"

void handler(int sender,int data) {
  printf(1, "handler called!.sender=%d data=%d\n", sender,data);
  // exit();
  // return;
}

int
main(int argc, char **argv)
{
  // int sum=5;
  int ppid=getpid();
  // * data=kanish";
  sigset(&handler);
  printf(1, "signal registered successfully\n");
  int child = fork();
  if (child == 0) {
    int i = 0;
    while(1){
      i++; 
      printf(1,"%d  ",i);
    }
  } 
  else {
    printf(1, "%d is sending signal to %d\n",ppid,child);
    int recids[1];
    recids[0]=child;
    int msgarr[2];
    msgarr[0]=ppid;
    msgarr[1]=5962;
    int r=send_multi(5,recids,(void*)msgarr,1);
    printf(1, "signal sent and returned %d\n",r);
    sleep(5);
    r=send_multi(5,recids,(void*)msgarr,1);
    printf(1, "signal sent and returned %d\n",r);
        r=send_multi(5,recids,(void*)msgarr,1);
    printf(1, "signal sent and returned %d\n",r);
        r=send_multi(5,recids,(void*)msgarr,1);
    printf(1, "signal sent and returned %d\n",r);
        r=send_multi(5,recids,(void*)msgarr,1);
    printf(1, "signal sent and returned %d\n",r);
  }
  //printf(1, "Handled the signal and continued the program!\n");

  wait();
  exit();
}