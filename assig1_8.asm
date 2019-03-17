
_assig1_8:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    }
    return sum;
}

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 38             	sub    $0x38,%esp
    if(argc< 2){
  14:	83 39 01             	cmpl   $0x1,(%ecx)
{
  17:	8b 41 04             	mov    0x4(%ecx),%eax
    if(argc< 2){
  1a:	0f 8e f7 00 00 00    	jle    117 <main+0x117>
        printf(1,"Need type and input filename\n");
        exit();
    }
    char *filename;
    filename=argv[2];
  20:	8b 70 08             	mov    0x8(%eax),%esi
    int type = atoi(argv[1]);
  23:	83 ec 0c             	sub    $0xc,%esp
  26:	ff 70 04             	pushl  0x4(%eax)
    filename=argv[2];
  29:	89 75 d0             	mov    %esi,-0x30(%ebp)
    int type = atoi(argv[1]);
  2c:	e8 7f 03 00 00       	call   3b0 <atoi>

    int tot_sum = 0;    
    float variance = 0.0;

    int size=1000;
    short arr[size];
  31:	81 ec d0 07 00 00    	sub    $0x7d0,%esp
    int type = atoi(argv[1]);
  37:	89 45 cc             	mov    %eax,-0x34(%ebp)
    short arr[size];
  3a:	89 e7                	mov    %esp,%edi
    char c;
    int fd = open(filename, 0);
  3c:	51                   	push   %ecx
  3d:	51                   	push   %ecx
  3e:	6a 00                	push   $0x0
  40:	56                   	push   %esi
  41:	89 fb                	mov    %edi,%ebx
    short arr[size];
  43:	89 7d c4             	mov    %edi,-0x3c(%ebp)
    int fd = open(filename, 0);
  46:	e8 17 04 00 00       	call   462 <open>
  4b:	89 c6                	mov    %eax,%esi
  4d:	8d 87 d0 07 00 00    	lea    0x7d0(%edi),%eax
  53:	8d 7d e3             	lea    -0x1d(%ebp),%edi
  56:	83 c4 10             	add    $0x10,%esp
  59:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(int i=0; i<size; i++){
        read(fd, &c, 1);
  60:	83 ec 04             	sub    $0x4,%esp
  63:	83 c3 02             	add    $0x2,%ebx
  66:	6a 01                	push   $0x1
  68:	57                   	push   %edi
  69:	56                   	push   %esi
  6a:	e8 cb 03 00 00       	call   43a <read>
        arr[i]=c-'0';
  6f:	66 0f be 45 e3       	movsbw -0x1d(%ebp),%ax
        read(fd, &c, 1);
  74:	83 c4 0c             	add    $0xc,%esp
        arr[i]=c-'0';
  77:	83 e8 30             	sub    $0x30,%eax
  7a:	66 89 43 fe          	mov    %ax,-0x2(%ebx)
        read(fd, &c, 1);
  7e:	6a 01                	push   $0x1
  80:	57                   	push   %edi
  81:	56                   	push   %esi
  82:	e8 b3 03 00 00       	call   43a <read>
    for(int i=0; i<size; i++){
  87:	83 c4 10             	add    $0x10,%esp
  8a:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
  8d:	75 d1                	jne    60 <main+0x60>
    }   
    close(fd);
  8f:	83 ec 0c             	sub    $0xc,%esp
  92:	8d 7d e4             	lea    -0x1c(%ebp),%edi
    //----FILL THE CODE HERE for unicast sum and multicast variance
    int process_count = 8;
    int sub_size = size/process_count;
    int ppid = getpid();
    int pid = -1;
    for(int i = 0; i < process_count; i++){
  95:	31 db                	xor    %ebx,%ebx
    close(fd);
  97:	56                   	push   %esi
    int tot_sum = 0;    
  98:	31 f6                	xor    %esi,%esi
    close(fd);
  9a:	e8 ab 03 00 00       	call   44a <close>
    int ppid = getpid();
  9f:	e8 fe 03 00 00       	call   4a2 <getpid>
  a4:	83 c4 10             	add    $0x10,%esp
  a7:	89 45 c8             	mov    %eax,-0x38(%ebp)
    	pid = fork();
  aa:	e8 6b 03 00 00       	call   41a <fork>
    	if(pid == 0){
  af:	85 c0                	test   %eax,%eax
  b1:	74 77                	je     12a <main+0x12a>
            exit();
            // sleep(3);
        }
        else {
            int sub_sum = 0;
            recv((char*)&sub_sum);
  b3:	83 ec 0c             	sub    $0xc,%esp
    for(int i = 0; i < process_count; i++){
  b6:	83 c3 01             	add    $0x1,%ebx
            int sub_sum = 0;
  b9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
            recv((char*)&sub_sum);
  c0:	57                   	push   %edi
  c1:	e8 24 04 00 00       	call   4ea <recv>
            tot_sum+=sub_sum;
  c6:	03 75 e4             	add    -0x1c(%ebp),%esi
    for(int i = 0; i < process_count; i++){
  c9:	83 c4 10             	add    $0x10,%esp
  cc:	83 fb 08             	cmp    $0x8,%ebx
  cf:	75 d9                	jne    aa <main+0xaa>
        }
    }
    for (int i = 0; i < process_count; i++) {
        wait();
  d1:	e8 54 03 00 00       	call   42a <wait>
  d6:	e8 4f 03 00 00       	call   42a <wait>
  db:	e8 4a 03 00 00       	call   42a <wait>
  e0:	e8 45 03 00 00       	call   42a <wait>
  e5:	e8 40 03 00 00       	call   42a <wait>
  ea:	e8 3b 03 00 00       	call   42a <wait>
  ef:	e8 36 03 00 00       	call   42a <wait>
  f4:	e8 31 03 00 00       	call   42a <wait>
    }
    //------------------


    if(type==0){ //unicast sum
  f9:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  fd:	75 65                	jne    164 <main+0x164>
        printf(1,"Sum of array for file %s is %d\n", filename,tot_sum);
  ff:	56                   	push   %esi
 100:	ff 75 d0             	pushl  -0x30(%ebp)
 103:	68 38 09 00 00       	push   $0x938
 108:	6a 01                	push   $0x1
 10a:	e8 b1 04 00 00       	call   5c0 <printf>
 10f:	83 c4 10             	add    $0x10,%esp
    }
    else{ //mulicast variance
        printf(1,"Variance of array for file %s is %d\n", filename,(int)variance);
    }
    
    exit();
 112:	e8 0b 03 00 00       	call   422 <exit>
        printf(1,"Need type and input filename\n");
 117:	53                   	push   %ebx
 118:	53                   	push   %ebx
 119:	68 18 09 00 00       	push   $0x918
 11e:	6a 01                	push   $0x1
 120:	e8 9b 04 00 00       	call   5c0 <printf>
        exit();
 125:	e8 f8 02 00 00       	call   422 <exit>
    		if(i==process_count-1)
 12a:	83 fb 07             	cmp    $0x7,%ebx
 12d:	74 4b                	je     17a <main+0x17a>
            int sub_sum = sum(arr+sub_size*i,sub_size);
 12f:	69 d3 fa 00 00 00    	imul   $0xfa,%ebx,%edx
 135:	03 55 c4             	add    -0x3c(%ebp),%edx
    for(short int* i = arr; i < arr+n ;i++){
 138:	8d 9a fa 00 00 00    	lea    0xfa(%edx),%ebx
 13e:	66 90                	xchg   %ax,%ax
        sum += *(i); 
 140:	0f bf 0a             	movswl (%edx),%ecx
    for(short int* i = arr; i < arr+n ;i++){
 143:	83 c2 02             	add    $0x2,%edx
        sum += *(i); 
 146:	01 c8                	add    %ecx,%eax
    for(short int* i = arr; i < arr+n ;i++){
 148:	39 da                	cmp    %ebx,%edx
 14a:	75 f4                	jne    140 <main+0x140>
            int sub_sum = sum(arr+sub_size*i,sub_size);
 14c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            send(getpid(),ppid,(char*)&sub_sum);
 14f:	e8 4e 03 00 00       	call   4a2 <getpid>
 154:	52                   	push   %edx
 155:	57                   	push   %edi
 156:	ff 75 c8             	pushl  -0x38(%ebp)
 159:	50                   	push   %eax
 15a:	e8 83 03 00 00       	call   4e2 <send>
            exit();
 15f:	e8 be 02 00 00       	call   422 <exit>
        printf(1,"Variance of array for file %s is %d\n", filename,(int)variance);
 164:	6a 00                	push   $0x0
 166:	ff 75 d0             	pushl  -0x30(%ebp)
 169:	68 58 09 00 00       	push   $0x958
 16e:	6a 01                	push   $0x1
 170:	e8 4b 04 00 00       	call   5c0 <printf>
 175:	83 c4 10             	add    $0x10,%esp
 178:	eb 98                	jmp    112 <main+0x112>
    			int sub_sum = sum(arr+sub_size*i,size-sub_size*i);
 17a:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 17d:	8d 91 d6 06 00 00    	lea    0x6d6(%ecx),%edx
    for(short int* i = arr; i < arr+n ;i++){
 183:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
 186:	73 c4                	jae    14c <main+0x14c>
 188:	81 c1 d0 07 00 00    	add    $0x7d0,%ecx
 18e:	89 cb                	mov    %ecx,%ebx
        sum += *(i); 
 190:	0f bf 0a             	movswl (%edx),%ecx
    for(short int* i = arr; i < arr+n ;i++){
 193:	83 c2 02             	add    $0x2,%edx
        sum += *(i); 
 196:	01 c8                	add    %ecx,%eax
    for(short int* i = arr; i < arr+n ;i++){
 198:	39 da                	cmp    %ebx,%edx
 19a:	75 f4                	jne    190 <main+0x190>
 19c:	eb ae                	jmp    14c <main+0x14c>
 19e:	66 90                	xchg   %ax,%ax

000001a0 <sum>:
int sum(short int *arr,int n){
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	53                   	push   %ebx
 1a4:	8b 55 08             	mov    0x8(%ebp),%edx
    for(short int* i = arr; i < arr+n ;i++){
 1a7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1aa:	8d 1c 42             	lea    (%edx,%eax,2),%ebx
    int sum = 0;
 1ad:	31 c0                	xor    %eax,%eax
    for(short int* i = arr; i < arr+n ;i++){
 1af:	39 da                	cmp    %ebx,%edx
 1b1:	73 11                	jae    1c4 <sum+0x24>
 1b3:	90                   	nop
 1b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += *(i); 
 1b8:	0f bf 0a             	movswl (%edx),%ecx
    for(short int* i = arr; i < arr+n ;i++){
 1bb:	83 c2 02             	add    $0x2,%edx
        sum += *(i); 
 1be:	01 c8                	add    %ecx,%eax
    for(short int* i = arr; i < arr+n ;i++){
 1c0:	39 da                	cmp    %ebx,%edx
 1c2:	72 f4                	jb     1b8 <sum+0x18>
}
 1c4:	5b                   	pop    %ebx
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	66 90                	xchg   %ax,%ax
 1c9:	66 90                	xchg   %ax,%ax
 1cb:	66 90                	xchg   %ax,%ax
 1cd:	66 90                	xchg   %ax,%ax
 1cf:	90                   	nop

000001d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 45 08             	mov    0x8(%ebp),%eax
 1d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1da:	89 c2                	mov    %eax,%edx
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e0:	83 c1 01             	add    $0x1,%ecx
 1e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1e7:	83 c2 01             	add    $0x1,%edx
 1ea:	84 db                	test   %bl,%bl
 1ec:	88 5a ff             	mov    %bl,-0x1(%edx)
 1ef:	75 ef                	jne    1e0 <strcpy+0x10>
    ;
  return os;
}
 1f1:	5b                   	pop    %ebx
 1f2:	5d                   	pop    %ebp
 1f3:	c3                   	ret    
 1f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000200 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 55 08             	mov    0x8(%ebp),%edx
 207:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 20a:	0f b6 02             	movzbl (%edx),%eax
 20d:	0f b6 19             	movzbl (%ecx),%ebx
 210:	84 c0                	test   %al,%al
 212:	75 1c                	jne    230 <strcmp+0x30>
 214:	eb 2a                	jmp    240 <strcmp+0x40>
 216:	8d 76 00             	lea    0x0(%esi),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 220:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 223:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 226:	83 c1 01             	add    $0x1,%ecx
 229:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 22c:	84 c0                	test   %al,%al
 22e:	74 10                	je     240 <strcmp+0x40>
 230:	38 d8                	cmp    %bl,%al
 232:	74 ec                	je     220 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 234:	29 d8                	sub    %ebx,%eax
}
 236:	5b                   	pop    %ebx
 237:	5d                   	pop    %ebp
 238:	c3                   	ret    
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 240:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 242:	29 d8                	sub    %ebx,%eax
}
 244:	5b                   	pop    %ebx
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strlen>:

uint
strlen(const char *s)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 256:	80 39 00             	cmpb   $0x0,(%ecx)
 259:	74 15                	je     270 <strlen+0x20>
 25b:	31 d2                	xor    %edx,%edx
 25d:	8d 76 00             	lea    0x0(%esi),%esi
 260:	83 c2 01             	add    $0x1,%edx
 263:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 267:	89 d0                	mov    %edx,%eax
 269:	75 f5                	jne    260 <strlen+0x10>
    ;
  return n;
}
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    
 26d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 270:	31 c0                	xor    %eax,%eax
}
 272:	5d                   	pop    %ebp
 273:	c3                   	ret    
 274:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 27a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000280 <memset>:

void*
memset(void *dst, int c, uint n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 287:	8b 4d 10             	mov    0x10(%ebp),%ecx
 28a:	8b 45 0c             	mov    0xc(%ebp),%eax
 28d:	89 d7                	mov    %edx,%edi
 28f:	fc                   	cld    
 290:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 292:	89 d0                	mov    %edx,%eax
 294:	5f                   	pop    %edi
 295:	5d                   	pop    %ebp
 296:	c3                   	ret    
 297:	89 f6                	mov    %esi,%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <strchr>:

char*
strchr(const char *s, char c)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	53                   	push   %ebx
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 2aa:	0f b6 10             	movzbl (%eax),%edx
 2ad:	84 d2                	test   %dl,%dl
 2af:	74 1d                	je     2ce <strchr+0x2e>
    if(*s == c)
 2b1:	38 d3                	cmp    %dl,%bl
 2b3:	89 d9                	mov    %ebx,%ecx
 2b5:	75 0d                	jne    2c4 <strchr+0x24>
 2b7:	eb 17                	jmp    2d0 <strchr+0x30>
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2c0:	38 ca                	cmp    %cl,%dl
 2c2:	74 0c                	je     2d0 <strchr+0x30>
  for(; *s; s++)
 2c4:	83 c0 01             	add    $0x1,%eax
 2c7:	0f b6 10             	movzbl (%eax),%edx
 2ca:	84 d2                	test   %dl,%dl
 2cc:	75 f2                	jne    2c0 <strchr+0x20>
      return (char*)s;
  return 0;
 2ce:	31 c0                	xor    %eax,%eax
}
 2d0:	5b                   	pop    %ebx
 2d1:	5d                   	pop    %ebp
 2d2:	c3                   	ret    
 2d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002e0 <gets>:

char*
gets(char *buf, int max)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	57                   	push   %edi
 2e4:	56                   	push   %esi
 2e5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e6:	31 f6                	xor    %esi,%esi
 2e8:	89 f3                	mov    %esi,%ebx
{
 2ea:	83 ec 1c             	sub    $0x1c,%esp
 2ed:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2f0:	eb 2f                	jmp    321 <gets+0x41>
 2f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2fb:	83 ec 04             	sub    $0x4,%esp
 2fe:	6a 01                	push   $0x1
 300:	50                   	push   %eax
 301:	6a 00                	push   $0x0
 303:	e8 32 01 00 00       	call   43a <read>
    if(cc < 1)
 308:	83 c4 10             	add    $0x10,%esp
 30b:	85 c0                	test   %eax,%eax
 30d:	7e 1c                	jle    32b <gets+0x4b>
      break;
    buf[i++] = c;
 30f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 313:	83 c7 01             	add    $0x1,%edi
 316:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 319:	3c 0a                	cmp    $0xa,%al
 31b:	74 23                	je     340 <gets+0x60>
 31d:	3c 0d                	cmp    $0xd,%al
 31f:	74 1f                	je     340 <gets+0x60>
  for(i=0; i+1 < max; ){
 321:	83 c3 01             	add    $0x1,%ebx
 324:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 327:	89 fe                	mov    %edi,%esi
 329:	7c cd                	jl     2f8 <gets+0x18>
 32b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 32d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 330:	c6 03 00             	movb   $0x0,(%ebx)
}
 333:	8d 65 f4             	lea    -0xc(%ebp),%esp
 336:	5b                   	pop    %ebx
 337:	5e                   	pop    %esi
 338:	5f                   	pop    %edi
 339:	5d                   	pop    %ebp
 33a:	c3                   	ret    
 33b:	90                   	nop
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 340:	8b 75 08             	mov    0x8(%ebp),%esi
 343:	8b 45 08             	mov    0x8(%ebp),%eax
 346:	01 de                	add    %ebx,%esi
 348:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 34a:	c6 03 00             	movb   $0x0,(%ebx)
}
 34d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 350:	5b                   	pop    %ebx
 351:	5e                   	pop    %esi
 352:	5f                   	pop    %edi
 353:	5d                   	pop    %ebp
 354:	c3                   	ret    
 355:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <stat>:

int
stat(const char *n, struct stat *st)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 365:	83 ec 08             	sub    $0x8,%esp
 368:	6a 00                	push   $0x0
 36a:	ff 75 08             	pushl  0x8(%ebp)
 36d:	e8 f0 00 00 00       	call   462 <open>
  if(fd < 0)
 372:	83 c4 10             	add    $0x10,%esp
 375:	85 c0                	test   %eax,%eax
 377:	78 27                	js     3a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 379:	83 ec 08             	sub    $0x8,%esp
 37c:	ff 75 0c             	pushl  0xc(%ebp)
 37f:	89 c3                	mov    %eax,%ebx
 381:	50                   	push   %eax
 382:	e8 f3 00 00 00       	call   47a <fstat>
  close(fd);
 387:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 38a:	89 c6                	mov    %eax,%esi
  close(fd);
 38c:	e8 b9 00 00 00       	call   44a <close>
  return r;
 391:	83 c4 10             	add    $0x10,%esp
}
 394:	8d 65 f8             	lea    -0x8(%ebp),%esp
 397:	89 f0                	mov    %esi,%eax
 399:	5b                   	pop    %ebx
 39a:	5e                   	pop    %esi
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret    
 39d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3a5:	eb ed                	jmp    394 <stat+0x34>
 3a7:	89 f6                	mov    %esi,%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <atoi>:

int
atoi(const char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b7:	0f be 11             	movsbl (%ecx),%edx
 3ba:	8d 42 d0             	lea    -0x30(%edx),%eax
 3bd:	3c 09                	cmp    $0x9,%al
  n = 0;
 3bf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 3c4:	77 1f                	ja     3e5 <atoi+0x35>
 3c6:	8d 76 00             	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 3d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3d3:	83 c1 01             	add    $0x1,%ecx
 3d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 3da:	0f be 11             	movsbl (%ecx),%edx
 3dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3e0:	80 fb 09             	cmp    $0x9,%bl
 3e3:	76 eb                	jbe    3d0 <atoi+0x20>
  return n;
}
 3e5:	5b                   	pop    %ebx
 3e6:	5d                   	pop    %ebp
 3e7:	c3                   	ret    
 3e8:	90                   	nop
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	56                   	push   %esi
 3f4:	53                   	push   %ebx
 3f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f8:	8b 45 08             	mov    0x8(%ebp),%eax
 3fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3fe:	85 db                	test   %ebx,%ebx
 400:	7e 14                	jle    416 <memmove+0x26>
 402:	31 d2                	xor    %edx,%edx
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 408:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 40c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 40f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 412:	39 d3                	cmp    %edx,%ebx
 414:	75 f2                	jne    408 <memmove+0x18>
  return vdst;
}
 416:	5b                   	pop    %ebx
 417:	5e                   	pop    %esi
 418:	5d                   	pop    %ebp
 419:	c3                   	ret    

0000041a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 41a:	b8 01 00 00 00       	mov    $0x1,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <exit>:
SYSCALL(exit)
 422:	b8 02 00 00 00       	mov    $0x2,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <wait>:
SYSCALL(wait)
 42a:	b8 03 00 00 00       	mov    $0x3,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <pipe>:
SYSCALL(pipe)
 432:	b8 04 00 00 00       	mov    $0x4,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <read>:
SYSCALL(read)
 43a:	b8 05 00 00 00       	mov    $0x5,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <write>:
SYSCALL(write)
 442:	b8 10 00 00 00       	mov    $0x10,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <close>:
SYSCALL(close)
 44a:	b8 15 00 00 00       	mov    $0x15,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <kill>:
SYSCALL(kill)
 452:	b8 06 00 00 00       	mov    $0x6,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <exec>:
SYSCALL(exec)
 45a:	b8 07 00 00 00       	mov    $0x7,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <open>:
SYSCALL(open)
 462:	b8 0f 00 00 00       	mov    $0xf,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <mknod>:
SYSCALL(mknod)
 46a:	b8 11 00 00 00       	mov    $0x11,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <unlink>:
SYSCALL(unlink)
 472:	b8 12 00 00 00       	mov    $0x12,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <fstat>:
SYSCALL(fstat)
 47a:	b8 08 00 00 00       	mov    $0x8,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <link>:
SYSCALL(link)
 482:	b8 13 00 00 00       	mov    $0x13,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <mkdir>:
SYSCALL(mkdir)
 48a:	b8 14 00 00 00       	mov    $0x14,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <chdir>:
SYSCALL(chdir)
 492:	b8 09 00 00 00       	mov    $0x9,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <dup>:
SYSCALL(dup)
 49a:	b8 0a 00 00 00       	mov    $0xa,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <getpid>:
SYSCALL(getpid)
 4a2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <sbrk>:
SYSCALL(sbrk)
 4aa:	b8 0c 00 00 00       	mov    $0xc,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <sleep>:
SYSCALL(sleep)
 4b2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <uptime>:
SYSCALL(uptime)
 4ba:	b8 0e 00 00 00       	mov    $0xe,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <toggle>:
SYSCALL(toggle)
 4c2:	b8 16 00 00 00       	mov    $0x16,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <print_count>:
SYSCALL(print_count)
 4ca:	b8 17 00 00 00       	mov    $0x17,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <add>:
SYSCALL(add)
 4d2:	b8 18 00 00 00       	mov    $0x18,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <ps>:
SYSCALL(ps)
 4da:	b8 19 00 00 00       	mov    $0x19,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <send>:
SYSCALL(send)
 4e2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <recv>:
SYSCALL(recv)
 4ea:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <sigset>:
SYSCALL(sigset)
 4f2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <sigsend>:
SYSCALL(sigsend)
 4fa:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <sigret>:
SYSCALL(sigret)
 502:	b8 1e 00 00 00       	mov    $0x1e,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <sigpause>:
SYSCALL(sigpause)
 50a:	b8 1f 00 00 00       	mov    $0x1f,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <send_multi>:
SYSCALL(send_multi)
 512:	b8 20 00 00 00       	mov    $0x20,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    
 51a:	66 90                	xchg   %ax,%ax
 51c:	66 90                	xchg   %ax,%ax
 51e:	66 90                	xchg   %ax,%ax

00000520 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 529:	85 d2                	test   %edx,%edx
{
 52b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 52e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 530:	79 76                	jns    5a8 <printint+0x88>
 532:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 536:	74 70                	je     5a8 <printint+0x88>
    x = -xx;
 538:	f7 d8                	neg    %eax
    neg = 1;
 53a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 541:	31 f6                	xor    %esi,%esi
 543:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 546:	eb 0a                	jmp    552 <printint+0x32>
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 550:	89 fe                	mov    %edi,%esi
 552:	31 d2                	xor    %edx,%edx
 554:	8d 7e 01             	lea    0x1(%esi),%edi
 557:	f7 f1                	div    %ecx
 559:	0f b6 92 88 09 00 00 	movzbl 0x988(%edx),%edx
  }while((x /= base) != 0);
 560:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 562:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 565:	75 e9                	jne    550 <printint+0x30>
  if(neg)
 567:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 56a:	85 c0                	test   %eax,%eax
 56c:	74 08                	je     576 <printint+0x56>
    buf[i++] = '-';
 56e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 573:	8d 7e 02             	lea    0x2(%esi),%edi
 576:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 57a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 57d:	8d 76 00             	lea    0x0(%esi),%esi
 580:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 583:	83 ec 04             	sub    $0x4,%esp
 586:	83 ee 01             	sub    $0x1,%esi
 589:	6a 01                	push   $0x1
 58b:	53                   	push   %ebx
 58c:	57                   	push   %edi
 58d:	88 45 d7             	mov    %al,-0x29(%ebp)
 590:	e8 ad fe ff ff       	call   442 <write>

  while(--i >= 0)
 595:	83 c4 10             	add    $0x10,%esp
 598:	39 de                	cmp    %ebx,%esi
 59a:	75 e4                	jne    580 <printint+0x60>
    putc(fd, buf[i]);
}
 59c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 59f:	5b                   	pop    %ebx
 5a0:	5e                   	pop    %esi
 5a1:	5f                   	pop    %edi
 5a2:	5d                   	pop    %ebp
 5a3:	c3                   	ret    
 5a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5a8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 5af:	eb 90                	jmp    541 <printint+0x21>
 5b1:	eb 0d                	jmp    5c0 <printf>
 5b3:	90                   	nop
 5b4:	90                   	nop
 5b5:	90                   	nop
 5b6:	90                   	nop
 5b7:	90                   	nop
 5b8:	90                   	nop
 5b9:	90                   	nop
 5ba:	90                   	nop
 5bb:	90                   	nop
 5bc:	90                   	nop
 5bd:	90                   	nop
 5be:	90                   	nop
 5bf:	90                   	nop

000005c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	56                   	push   %esi
 5c5:	53                   	push   %ebx
 5c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c9:	8b 75 0c             	mov    0xc(%ebp),%esi
 5cc:	0f b6 1e             	movzbl (%esi),%ebx
 5cf:	84 db                	test   %bl,%bl
 5d1:	0f 84 b3 00 00 00    	je     68a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 5d7:	8d 45 10             	lea    0x10(%ebp),%eax
 5da:	83 c6 01             	add    $0x1,%esi
  state = 0;
 5dd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 5df:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5e2:	eb 2f                	jmp    613 <printf+0x53>
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5e8:	83 f8 25             	cmp    $0x25,%eax
 5eb:	0f 84 a7 00 00 00    	je     698 <printf+0xd8>
  write(fd, &c, 1);
 5f1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5f4:	83 ec 04             	sub    $0x4,%esp
 5f7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5fa:	6a 01                	push   $0x1
 5fc:	50                   	push   %eax
 5fd:	ff 75 08             	pushl  0x8(%ebp)
 600:	e8 3d fe ff ff       	call   442 <write>
 605:	83 c4 10             	add    $0x10,%esp
 608:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 60b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 60f:	84 db                	test   %bl,%bl
 611:	74 77                	je     68a <printf+0xca>
    if(state == 0){
 613:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 615:	0f be cb             	movsbl %bl,%ecx
 618:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 61b:	74 cb                	je     5e8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 61d:	83 ff 25             	cmp    $0x25,%edi
 620:	75 e6                	jne    608 <printf+0x48>
      if(c == 'd'){
 622:	83 f8 64             	cmp    $0x64,%eax
 625:	0f 84 05 01 00 00    	je     730 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 62b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 631:	83 f9 70             	cmp    $0x70,%ecx
 634:	74 72                	je     6a8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 636:	83 f8 73             	cmp    $0x73,%eax
 639:	0f 84 99 00 00 00    	je     6d8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 63f:	83 f8 63             	cmp    $0x63,%eax
 642:	0f 84 08 01 00 00    	je     750 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 648:	83 f8 25             	cmp    $0x25,%eax
 64b:	0f 84 ef 00 00 00    	je     740 <printf+0x180>
  write(fd, &c, 1);
 651:	8d 45 e7             	lea    -0x19(%ebp),%eax
 654:	83 ec 04             	sub    $0x4,%esp
 657:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 65b:	6a 01                	push   $0x1
 65d:	50                   	push   %eax
 65e:	ff 75 08             	pushl  0x8(%ebp)
 661:	e8 dc fd ff ff       	call   442 <write>
 666:	83 c4 0c             	add    $0xc,%esp
 669:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 66c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 66f:	6a 01                	push   $0x1
 671:	50                   	push   %eax
 672:	ff 75 08             	pushl  0x8(%ebp)
 675:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 678:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 67a:	e8 c3 fd ff ff       	call   442 <write>
  for(i = 0; fmt[i]; i++){
 67f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 683:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 686:	84 db                	test   %bl,%bl
 688:	75 89                	jne    613 <printf+0x53>
    }
  }
}
 68a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 68d:	5b                   	pop    %ebx
 68e:	5e                   	pop    %esi
 68f:	5f                   	pop    %edi
 690:	5d                   	pop    %ebp
 691:	c3                   	ret    
 692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 698:	bf 25 00 00 00       	mov    $0x25,%edi
 69d:	e9 66 ff ff ff       	jmp    608 <printf+0x48>
 6a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 6a8:	83 ec 0c             	sub    $0xc,%esp
 6ab:	b9 10 00 00 00       	mov    $0x10,%ecx
 6b0:	6a 00                	push   $0x0
 6b2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6b5:	8b 45 08             	mov    0x8(%ebp),%eax
 6b8:	8b 17                	mov    (%edi),%edx
 6ba:	e8 61 fe ff ff       	call   520 <printint>
        ap++;
 6bf:	89 f8                	mov    %edi,%eax
 6c1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6c4:	31 ff                	xor    %edi,%edi
        ap++;
 6c6:	83 c0 04             	add    $0x4,%eax
 6c9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6cc:	e9 37 ff ff ff       	jmp    608 <printf+0x48>
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6db:	8b 08                	mov    (%eax),%ecx
        ap++;
 6dd:	83 c0 04             	add    $0x4,%eax
 6e0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 6e3:	85 c9                	test   %ecx,%ecx
 6e5:	0f 84 8e 00 00 00    	je     779 <printf+0x1b9>
        while(*s != 0){
 6eb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 6ee:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 6f0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 6f2:	84 c0                	test   %al,%al
 6f4:	0f 84 0e ff ff ff    	je     608 <printf+0x48>
 6fa:	89 75 d0             	mov    %esi,-0x30(%ebp)
 6fd:	89 de                	mov    %ebx,%esi
 6ff:	8b 5d 08             	mov    0x8(%ebp),%ebx
 702:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 705:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 708:	83 ec 04             	sub    $0x4,%esp
          s++;
 70b:	83 c6 01             	add    $0x1,%esi
 70e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 711:	6a 01                	push   $0x1
 713:	57                   	push   %edi
 714:	53                   	push   %ebx
 715:	e8 28 fd ff ff       	call   442 <write>
        while(*s != 0){
 71a:	0f b6 06             	movzbl (%esi),%eax
 71d:	83 c4 10             	add    $0x10,%esp
 720:	84 c0                	test   %al,%al
 722:	75 e4                	jne    708 <printf+0x148>
 724:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 727:	31 ff                	xor    %edi,%edi
 729:	e9 da fe ff ff       	jmp    608 <printf+0x48>
 72e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 730:	83 ec 0c             	sub    $0xc,%esp
 733:	b9 0a 00 00 00       	mov    $0xa,%ecx
 738:	6a 01                	push   $0x1
 73a:	e9 73 ff ff ff       	jmp    6b2 <printf+0xf2>
 73f:	90                   	nop
  write(fd, &c, 1);
 740:	83 ec 04             	sub    $0x4,%esp
 743:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 746:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 749:	6a 01                	push   $0x1
 74b:	e9 21 ff ff ff       	jmp    671 <printf+0xb1>
        putc(fd, *ap);
 750:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 753:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 756:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 758:	6a 01                	push   $0x1
        ap++;
 75a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 75d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 760:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 763:	50                   	push   %eax
 764:	ff 75 08             	pushl  0x8(%ebp)
 767:	e8 d6 fc ff ff       	call   442 <write>
        ap++;
 76c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 76f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 772:	31 ff                	xor    %edi,%edi
 774:	e9 8f fe ff ff       	jmp    608 <printf+0x48>
          s = "(null)";
 779:	bb 80 09 00 00       	mov    $0x980,%ebx
        while(*s != 0){
 77e:	b8 28 00 00 00       	mov    $0x28,%eax
 783:	e9 72 ff ff ff       	jmp    6fa <printf+0x13a>
 788:	66 90                	xchg   %ax,%ax
 78a:	66 90                	xchg   %ax,%ax
 78c:	66 90                	xchg   %ax,%ax
 78e:	66 90                	xchg   %ax,%ax

00000790 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 790:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 791:	a1 5c 0c 00 00       	mov    0xc5c,%eax
{
 796:	89 e5                	mov    %esp,%ebp
 798:	57                   	push   %edi
 799:	56                   	push   %esi
 79a:	53                   	push   %ebx
 79b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 79e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 7a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a8:	39 c8                	cmp    %ecx,%eax
 7aa:	8b 10                	mov    (%eax),%edx
 7ac:	73 32                	jae    7e0 <free+0x50>
 7ae:	39 d1                	cmp    %edx,%ecx
 7b0:	72 04                	jb     7b6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b2:	39 d0                	cmp    %edx,%eax
 7b4:	72 32                	jb     7e8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7b9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7bc:	39 fa                	cmp    %edi,%edx
 7be:	74 30                	je     7f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7c0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7c3:	8b 50 04             	mov    0x4(%eax),%edx
 7c6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7c9:	39 f1                	cmp    %esi,%ecx
 7cb:	74 3a                	je     807 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7cd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7cf:	a3 5c 0c 00 00       	mov    %eax,0xc5c
}
 7d4:	5b                   	pop    %ebx
 7d5:	5e                   	pop    %esi
 7d6:	5f                   	pop    %edi
 7d7:	5d                   	pop    %ebp
 7d8:	c3                   	ret    
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e0:	39 d0                	cmp    %edx,%eax
 7e2:	72 04                	jb     7e8 <free+0x58>
 7e4:	39 d1                	cmp    %edx,%ecx
 7e6:	72 ce                	jb     7b6 <free+0x26>
{
 7e8:	89 d0                	mov    %edx,%eax
 7ea:	eb bc                	jmp    7a8 <free+0x18>
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7f0:	03 72 04             	add    0x4(%edx),%esi
 7f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f6:	8b 10                	mov    (%eax),%edx
 7f8:	8b 12                	mov    (%edx),%edx
 7fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7fd:	8b 50 04             	mov    0x4(%eax),%edx
 800:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 803:	39 f1                	cmp    %esi,%ecx
 805:	75 c6                	jne    7cd <free+0x3d>
    p->s.size += bp->s.size;
 807:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 80a:	a3 5c 0c 00 00       	mov    %eax,0xc5c
    p->s.size += bp->s.size;
 80f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 812:	8b 53 f8             	mov    -0x8(%ebx),%edx
 815:	89 10                	mov    %edx,(%eax)
}
 817:	5b                   	pop    %ebx
 818:	5e                   	pop    %esi
 819:	5f                   	pop    %edi
 81a:	5d                   	pop    %ebp
 81b:	c3                   	ret    
 81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000820 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	57                   	push   %edi
 824:	56                   	push   %esi
 825:	53                   	push   %ebx
 826:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 829:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 82c:	8b 15 5c 0c 00 00    	mov    0xc5c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 832:	8d 78 07             	lea    0x7(%eax),%edi
 835:	c1 ef 03             	shr    $0x3,%edi
 838:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 83b:	85 d2                	test   %edx,%edx
 83d:	0f 84 9d 00 00 00    	je     8e0 <malloc+0xc0>
 843:	8b 02                	mov    (%edx),%eax
 845:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 848:	39 cf                	cmp    %ecx,%edi
 84a:	76 6c                	jbe    8b8 <malloc+0x98>
 84c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 852:	bb 00 10 00 00       	mov    $0x1000,%ebx
 857:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 85a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 861:	eb 0e                	jmp    871 <malloc+0x51>
 863:	90                   	nop
 864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 868:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 86a:	8b 48 04             	mov    0x4(%eax),%ecx
 86d:	39 f9                	cmp    %edi,%ecx
 86f:	73 47                	jae    8b8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 871:	39 05 5c 0c 00 00    	cmp    %eax,0xc5c
 877:	89 c2                	mov    %eax,%edx
 879:	75 ed                	jne    868 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 87b:	83 ec 0c             	sub    $0xc,%esp
 87e:	56                   	push   %esi
 87f:	e8 26 fc ff ff       	call   4aa <sbrk>
  if(p == (char*)-1)
 884:	83 c4 10             	add    $0x10,%esp
 887:	83 f8 ff             	cmp    $0xffffffff,%eax
 88a:	74 1c                	je     8a8 <malloc+0x88>
  hp->s.size = nu;
 88c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 88f:	83 ec 0c             	sub    $0xc,%esp
 892:	83 c0 08             	add    $0x8,%eax
 895:	50                   	push   %eax
 896:	e8 f5 fe ff ff       	call   790 <free>
  return freep;
 89b:	8b 15 5c 0c 00 00    	mov    0xc5c,%edx
      if((p = morecore(nunits)) == 0)
 8a1:	83 c4 10             	add    $0x10,%esp
 8a4:	85 d2                	test   %edx,%edx
 8a6:	75 c0                	jne    868 <malloc+0x48>
        return 0;
  }
}
 8a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8ab:	31 c0                	xor    %eax,%eax
}
 8ad:	5b                   	pop    %ebx
 8ae:	5e                   	pop    %esi
 8af:	5f                   	pop    %edi
 8b0:	5d                   	pop    %ebp
 8b1:	c3                   	ret    
 8b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8b8:	39 cf                	cmp    %ecx,%edi
 8ba:	74 54                	je     910 <malloc+0xf0>
        p->s.size -= nunits;
 8bc:	29 f9                	sub    %edi,%ecx
 8be:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8c1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8c4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 8c7:	89 15 5c 0c 00 00    	mov    %edx,0xc5c
}
 8cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8d0:	83 c0 08             	add    $0x8,%eax
}
 8d3:	5b                   	pop    %ebx
 8d4:	5e                   	pop    %esi
 8d5:	5f                   	pop    %edi
 8d6:	5d                   	pop    %ebp
 8d7:	c3                   	ret    
 8d8:	90                   	nop
 8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 8e0:	c7 05 5c 0c 00 00 60 	movl   $0xc60,0xc5c
 8e7:	0c 00 00 
 8ea:	c7 05 60 0c 00 00 60 	movl   $0xc60,0xc60
 8f1:	0c 00 00 
    base.s.size = 0;
 8f4:	b8 60 0c 00 00       	mov    $0xc60,%eax
 8f9:	c7 05 64 0c 00 00 00 	movl   $0x0,0xc64
 900:	00 00 00 
 903:	e9 44 ff ff ff       	jmp    84c <malloc+0x2c>
 908:	90                   	nop
 909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 910:	8b 08                	mov    (%eax),%ecx
 912:	89 0a                	mov    %ecx,(%edx)
 914:	eb b1                	jmp    8c7 <malloc+0xa7>
