#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "syscall.h"
#define MSG_SIZE 8


char sys_names[33][20] = {
        [SYS_fork] "sys_fork",
        [SYS_exit] "sys_exit",
        [SYS_wait] "sys_wait",
        [SYS_pipe] "sys_pipe",
        [SYS_read] "sys_read",
        [SYS_kill] "sys_kill",
        [SYS_exec] "sys_exec",
        [SYS_fstat] "sys_fstat",
        [SYS_chdir] "sys_chdir",
        [SYS_dup] "sys_dup",
        [SYS_getpid] "sys_getpid",
        [SYS_sbrk] "sys_sbrk",
        [SYS_sleep] "sys_sleep",
        [SYS_uptime] "sys_uptime",
        [SYS_open] "sys_open",
        [SYS_write] "sys_write",
        [SYS_mknod] "sys_mknod",
        [SYS_unlink] "sys_unlink",
        [SYS_link] "sys_link",
        [SYS_mkdir] "sys_mkdir",
        [SYS_close] "sys_close",
        [SYS_toggle] "sys_toggle",
        [SYS_add] "sys_add",
        [SYS_ps] "sys_ps",
        [SYS_print_count] "sys_print_count",
        [SYS_send] "sys_send",
        [SYS_recv] "sys_recv",
        [SYS_sigset]   "sys_sigset",
        [SYS_sigsend]   "sys_sigsend",
        [SYS_sigret]   "sys_sigret",
        [SYS_sigpause]   "sys_sigpause",
        [SYS_send_multi]   "sys_send_multi",
      };

int sys_count[33];
enum state {TRACE_OFF,TRACE_ON};
enum state state1=TRACE_OFF;


struct msg_q {
  int mq[50][MSG_SIZE];
  int h,t;
  int size;
};

struct msg_q process_Qs[NPROC];

void setzero(struct msg_q process_Qs[NPROC]){
  for(int j=0;j<NPROC;j++){
    process_Qs[j].h=0;
    process_Qs[j].t=0;
    process_Qs[j].size=0;
  }
}
struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

int send(void)
{
  acquire(&ptable.lock);
  int sender_pid, rec_pid;
  char* msg;
  argint(0,&sender_pid);
  argint(1,&rec_pid);
  if(argstr(2,&msg) < 0) {return -1;}
  argstr(2,&msg);
  struct proc *p;
  int idx=0;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++,idx++)
  {
    if(p->pid ==rec_pid)
      break;
  }
  if(idx==NPROC)
    cprintf("idx==NPROC\n");
  p = &ptable.proc[idx];
  if(process_Qs[idx].size >= (50)){
    cprintf("processQ is full\n");
    release(&ptable.lock);
    return -1;
  }
  int i = 0;
  int tail = process_Qs[idx].t;
  if(tail==50)
    tail=0;
  while(i<MSG_SIZE)
  {
    process_Qs[idx].mq[tail][i] = *(msg + i);
    i++;
  }
  process_Qs[idx].t=tail+1;
  process_Qs[idx].size += 1;
  if(p->state == SLEEPING){
    p->state=RUNNABLE;
  }
  release(&ptable.lock);
  return 0;
}

int recv(void)
{
  acquire(&ptable.lock);
  char* msg;
  int rec_pid = myproc()->pid;
  if(argstr(0,&msg) < 0) {return -1;}
  argstr(0,&msg);
  struct proc *p;
  int idx=0;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++,idx++)
  {
    if(p->pid ==rec_pid)
      break;
  }
  p = &ptable.proc[idx];
  if(process_Qs[idx].size <= 0){
    p->state=SLEEPING;
    sched();
  }
  int h = process_Qs[idx].h;
  if(h==50)
    h=0;
  for(int i = 0;i < MSG_SIZE; i++){
    *(msg + i) =  process_Qs[idx].mq[h][i]; 
  }
  process_Qs[idx].h=h+1;
  process_Qs[idx].size =process_Qs[idx].size- 1;
  release(&ptable.lock);
  return 0;
}

void toggle(void){
  if(state1==TRACE_OFF){
    state1=TRACE_ON;
    for(int i=0;i<33;i++)
      sys_count[i]=0;
  }
  else{
    state1=TRACE_OFF;
  }
}

void print_count(void){
  if(state1==TRACE_ON){
    for(int i=0;i<33;i++){
      if(sys_count[i]!=0)
        cprintf("%s %d\n",sys_names[i],sys_count[i]);
    }
  }
}

int add(void){
  int arg1,arg2;
  argint(0,&arg1);
  argint(1,&arg2);
  int sum=arg1+arg2;
  return sum;
}

void ps(void){
  struct proc* process;
  for(process=ptable.proc;process<&ptable.proc[NPROC];process++)
  {
    if((process->state==SLEEPING)||(process->state==RUNNABLE)||(process->state==RUNNING))
    {
      cprintf("pid:%d name:%s\n",process->pid,process->name);
    }
  }
}

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
  setzero(process_Qs);
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  int idx=0;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++,idx++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  p->t=0;
  p->h=0;
  p->size=0;
  process_Qs[idx].h=0;
  process_Qs[idx].t=0;
  process_Qs[idx].size=0;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;
  // p->oldTf = (struct trapframe*)sp;
  // memmove(p->oldTf, p->tf, sizeof(struct trapframe));

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
  p->sighandler = (sig_handler)-1; // default signal handler value
  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
  np->sighandler = curproc->sighandler; // copy the parent's signal handler
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
  
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
          // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);

  }
}

void checkSignals(struct trapframe *tf){
  struct proc* proc=myproc();
  if (proc == 0)
    return; // no proc is defined for this CPU
  if ((tf->cs & 3) != DPL_USER)
    return; // CPU isn't at privilege level 3, hence in user mode
  if(proc->size==0)
    return; // no pending signals
  if(proc->sighandler == (sig_handler)-1)
    return; // default signal handler, ignore the signal
  memmove(&proc->oldTf, proc->tf, sizeof(struct trapframe));//backing up trap frame
          proc->tf->esp -= (uint)&invoke_sigret_end - (uint)&invoke_sigret_start;
          memmove((void*)proc->tf->esp, invoke_sigret_start, (uint)&invoke_sigret_end - (uint)&invoke_sigret_start);
          int h=proc->h;
          if(h==20)
            h=0;

          *((int*)(proc->tf->esp - 4)) = (int)proc->signal_arr[h][1];
          *((int*)(proc->tf->esp - 8)) = (int)proc->signal_arr[h][0];
          *((int*)(proc->tf->esp - 12)) = proc->tf->esp; // sigret system call code address
          proc->tf->esp -= 12;
          proc->tf->eip = (uint)proc->sighandler; // trapret will resume into signal handler
          proc->size=proc->size-1; // free the cstackframe
          proc->h=h+1;
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

sig_handler sigset(sig_handler new_sig_handler) {
  struct proc *curproc = myproc();
  sig_handler old_sig_handler = curproc->sighandler;
  curproc->sighandler = new_sig_handler;
  return old_sig_handler;
}

int sigsend(int dest_pid, int msg) {
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if (p->pid == dest_pid)
      goto sigsend_dest_pid_found;
  }
  return -1; // dest_pid wan't found, meaning it's not a valid pid. return error
sigsend_dest_pid_found:
  acquire(&ptable.lock);
  if(p->size==20)
    return -1; // pending signal stack is full. return error
  int t=p->t;
  if(t==20)
    t=0;
  int* message=(int*) msg;
  p->signal_arr[t][0]=*message;
  p->signal_arr[t][1]=*(message+1);
  p->size=p->size+1;
  p->t=t+1;
  release(&ptable.lock);
  // cprintf("p->size=%d\n",p->size);
  return 0; // successful execution
}

void sigret(void) {
  struct proc *proc = myproc();
  memmove(proc->tf, &proc->oldTf, sizeof(struct trapframe));
  // cprintf("return called");
}

void sigpause(void) {
  acquire(&ptable.lock);
  int rec_pid = myproc()->pid;
  struct proc *p;
  int idx=0;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++,idx++)
  {
    if(p->pid ==rec_pid)
      break;
  }
  cprintf("Qsize=%d and head=%d and tail=%d\n",process_Qs[idx].size,process_Qs[idx].h,process_Qs[idx].t);
  // //acquire(&ptable.lock);
  // pushcli();
  // struct proc* proc=myproc();
  // if(proc->state==RUNNING)
  //   proc->state=SLEEPING;
  // // else
  // // {
  // //   proc->state=RUNNING;
  // // }
  // sched();
  
  // // if(!cas(&proc->state, RUNNING, SLEEPING))
  // //   panic("sigpause: cas #1 failed");
  // // if (proc->cstack.head == 0){
  // //   proc->chan = 0;
  // //   proc->sigPauseInvoked = 1;
  // //   // acquire(&ptable.lock);
  // //   sched();
  // //   // release(&ptable.lock);
  // // }
  // // else{
  // //   if(!cas(&proc->state, SLEEPING, RUNNING))
  // //     panic("sigpause: cas #2 failed");
  // // }
  release(&ptable.lock);
  // popcli();
}
