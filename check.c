// #include <stdio.h> 
// #include <stdlib.h>
// #include <sys/stat.h> 
// #include <fcntl.h>
// #include <sys/types.h> 
// #include <unistd.h> 
// #include <sys/wait.h> 
// char pipearr[2][10];
// struct msg{
//     int senderid;
//     float val;
// };
// int
// main(int argc, char **argv)
// {
//   int i;
//   for(i=0;i<2;i++)
//   {
//       sprintf(pipearr[i],"pipearr%d",i);
//       mkfifo(pipearr[i], 0666); 
      
//       printf("id=%s\n",pipearr[i]);
//   }
//   int ppid=getpid();
//   for(int j=0;j<2;j++)
//   {
//     int child = fork();
//     if (child == 0) {
//       if(j==0)
//       {
//         struct msg msg1;
//         msg1.val=4.895;
//         msg1.senderid=3;
//         int id=open(pipearr[1],O_WRONLY);
//         id=open(pipearr[1],O_WRONLY);
//         printf("id=%d\n",id);
//         write(id,(void*)&msg1,8*sizeof(char));
//         printf("written\n");
//         // send(0,1,(void*)&a);
//         exit(0);
//       }
//       else
//       {
//         struct msg msg1;
//         int id=open(pipearr[1],O_RDONLY);
//         printf("id=%d\n",id);
//         while(read(id,(void*)&msg1,8*sizeof(char))!=8);
//         // printf("received=%d\n",z);
//         printf("%f %d\n",msg1.val,msg1.senderid);
//         exit(0);
//       }
      
        
//     }
//     else {
//     }
//   }
//   //printf(1, "Handled the signal and continued the program!\n");
//   int status;
//   wait(&status);
//   wait(&status);

//   exit(0);
// }