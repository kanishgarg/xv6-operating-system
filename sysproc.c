#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int sys_sigset(void) {
  int sighandler;
  argint(0, &sighandler);
  return (int) sigset((sig_handler)sighandler);
}

int sys_sigsend(int dest_pid,int msg) {
  argint(0, &dest_pid);
  argint(1, &msg);
  return sigsend(dest_pid, msg);
}

int sys_send_multi(void) {
  // pushcli();
  // int sender_pid,length;
  // int arg3=0;
  // int* rec_pids;
  // int* msg;
  // argint(0, &sender_pid);
  // argint(1, &arg3);
  // rec_pids=(int*)arg3;
  // argint(2,&arg3);
  // msg=(int*)arg3;
  // argint(3,&length);
  // for(int i=0;i<length;i++)
  //   sys_sigsend(rec_pids[i],(int)msg);
  // popcli();
  return 0;
}

int sys_sigret(void) {
  sigret();
  return 1;
}

int sys_sigpause(void) {
  sigpause();
  return 1;
}

int sys_toggle(void){
   toggle();
   return 0;
}

int sys_print_count(void){
    print_count();
    return 0;
}

int sys_add(void){
   return add();
}

int sys_ps(void){
   ps();
   return 0;
}

int sys_send(void){
  return send();
}

int sys_recv(void){
  return recv();
}

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}
