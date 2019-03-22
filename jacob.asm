
_jacob:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        }
    }

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
      11:	81 ec 98 00 00 00    	sub    $0x98,%esp
    if(argc< 2){
      17:	83 39 01             	cmpl   $0x1,(%ecx)
{
      1a:	8b 41 04             	mov    0x4(%ecx),%eax
    if(argc< 2){
      1d:	0f 8e b9 02 00 00    	jle    2dc <main+0x2dc>
        printf(1,"Need input filename\n");
        exit();
    }
    char *filename;
    filename = argv[1];
    int fd = open(filename, 0);
      23:	56                   	push   %esi
      24:	56                   	push   %esi
      25:	8d 75 bf             	lea    -0x41(%ebp),%esi
      28:	6a 00                	push   $0x0
      2a:	ff 70 04             	pushl  0x4(%eax)
      2d:	e8 60 0c 00 00       	call   c92 <open>
      32:	83 c4 10             	add    $0x10,%esp
      35:	89 c3                	mov    %eax,%ebx
    char c;
    float parameters[5];

    for (int i = 0; i < 5; i++)
      37:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%ebp)
      3e:	66 90                	xchg   %ax,%ax
    {
        float figure = 0.0;
        read(fd, &c, 1);
      40:	83 ec 04             	sub    $0x4,%esp
      43:	6a 01                	push   $0x1
      45:	56                   	push   %esi
      46:	53                   	push   %ebx
      47:	e8 1e 0c 00 00       	call   c6a <read>
        float tens = 10.0;
        int decimal = 0;
        while (c != '\n'&&c>0)
      4c:	0f be 45 bf          	movsbl -0x41(%ebp),%eax
      50:	83 c4 10             	add    $0x10,%esp
      53:	3c 0a                	cmp    $0xa,%al
      55:	74 79                	je     d0 <main+0xd0>
      57:	84 c0                	test   %al,%al
      59:	7e 75                	jle    d0 <main+0xd0>
        float figure = 0.0;
      5b:	d9 ee                	fldz   
        int decimal = 0;
      5d:	31 ff                	xor    %edi,%edi
        float figure = 0.0;
      5f:	d9 5d a8             	fstps  -0x58(%ebp)
        float tens = 10.0;
      62:	d9 05 68 11 00 00    	flds   0x1168
      68:	d9 5d a0             	fstps  -0x60(%ebp)
      6b:	eb 39                	jmp    a6 <main+0xa6>
      6d:	8d 76 00             	lea    0x0(%esi),%esi
      70:	83 e8 30             	sub    $0x30,%eax
            // printf(1, "%c\n", c);
            if (c == '.')
            {
                decimal = 1;
            }
            else if (!decimal)
      73:	85 ff                	test   %edi,%edi
      75:	89 45 a4             	mov    %eax,-0x5c(%ebp)
      78:	db 45 a4             	fildl  -0x5c(%ebp)
      7b:	75 3b                	jne    b8 <main+0xb8>
            {
                figure = 10*figure + (c - '0');
      7d:	d9 45 a8             	flds   -0x58(%ebp)
      80:	d8 0d 68 11 00 00    	fmuls  0x1168
      86:	de c1                	faddp  %st,%st(1)
      88:	d9 5d a8             	fstps  -0x58(%ebp)
            else
            {
                figure = figure + (c - '0')/tens;
                tens = tens*10;
            }
            read(fd, &c, 1);
      8b:	83 ec 04             	sub    $0x4,%esp
      8e:	6a 01                	push   $0x1
      90:	56                   	push   %esi
      91:	53                   	push   %ebx
      92:	e8 d3 0b 00 00       	call   c6a <read>
        while (c != '\n'&&c>0)
      97:	0f be 45 bf          	movsbl -0x41(%ebp),%eax
      9b:	83 c4 10             	add    $0x10,%esp
      9e:	3c 0a                	cmp    $0xa,%al
      a0:	74 36                	je     d8 <main+0xd8>
      a2:	84 c0                	test   %al,%al
      a4:	7e 32                	jle    d8 <main+0xd8>
            if (c == '.')
      a6:	3c 2e                	cmp    $0x2e,%al
      a8:	75 c6                	jne    70 <main+0x70>
                decimal = 1;
      aa:	bf 01 00 00 00       	mov    $0x1,%edi
      af:	eb da                	jmp    8b <main+0x8b>
      b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                figure = figure + (c - '0')/tens;
      b8:	d9 45 a0             	flds   -0x60(%ebp)
      bb:	dc f9                	fdivr  %st,%st(1)
      bd:	d9 c9                	fxch   %st(1)
      bf:	d8 45 a8             	fadds  -0x58(%ebp)
      c2:	d9 5d a8             	fstps  -0x58(%ebp)
                tens = tens*10;
      c5:	d8 0d 68 11 00 00    	fmuls  0x1168
      cb:	d9 5d a0             	fstps  -0x60(%ebp)
      ce:	eb bb                	jmp    8b <main+0x8b>
        float figure = 0.0;
      d0:	d9 ee                	fldz   
      d2:	d9 5d a8             	fstps  -0x58(%ebp)
      d5:	8d 76 00             	lea    0x0(%esi),%esi
        }
        parameters[i] = figure;
      d8:	8b 45 9c             	mov    -0x64(%ebp),%eax
      db:	d9 45 a8             	flds   -0x58(%ebp)
      de:	d9 5c 85 d4          	fstps  -0x2c(%ebp,%eax,4)
    for (int i = 0; i < 5; i++)
      e2:	83 c0 01             	add    $0x1,%eax
      e5:	83 f8 05             	cmp    $0x5,%eax
      e8:	89 45 9c             	mov    %eax,-0x64(%ebp)
      eb:	0f 85 4f ff ff ff    	jne    40 <main+0x40>
        // printf(1, "%d\n", (int)parameters[i]);
    }

    N = (int)parameters[0];
      f1:	d9 7d b2             	fnstcw -0x4e(%ebp)
      f4:	0f b7 45 b2          	movzwl -0x4e(%ebp),%eax
      f8:	d9 45 d4             	flds   -0x2c(%ebp)
    E = parameters[1];
    T = parameters[2];
    P = (int)parameters[3];
    L = (int)parameters[4];
    close(fd);
      fb:	83 ec 0c             	sub    $0xc,%esp
      fe:	53                   	push   %ebx
    N = (int)parameters[0];
      ff:	80 cc 0c             	or     $0xc,%ah
     102:	66 89 45 b0          	mov    %ax,-0x50(%ebp)
     106:	d9 6d b0             	fldcw  -0x50(%ebp)
     109:	db 1d 8c 14 00 00    	fistpl 0x148c
     10f:	d9 6d b2             	fldcw  -0x4e(%ebp)
    E = parameters[1];
     112:	d9 45 d8             	flds   -0x28(%ebp)
     115:	d9 1d 9c 14 00 00    	fstps  0x149c
    T = parameters[2];
     11b:	d9 45 dc             	flds   -0x24(%ebp)
     11e:	d9 1d 90 14 00 00    	fstps  0x1490
    P = (int)parameters[3];
     124:	d9 45 e0             	flds   -0x20(%ebp)
     127:	d9 6d b0             	fldcw  -0x50(%ebp)
     12a:	db 1d a0 14 00 00    	fistpl 0x14a0
     130:	d9 6d b2             	fldcw  -0x4e(%ebp)
    L = (int)parameters[4];
     133:	d9 45 e4             	flds   -0x1c(%ebp)
     136:	d9 6d b0             	fldcw  -0x50(%ebp)
     139:	db 1d 98 14 00 00    	fistpl 0x1498
     13f:	d9 6d b2             	fldcw  -0x4e(%ebp)
    close(fd);
     142:	e8 33 0b 00 00       	call   c7a <close>
    int works[P][2];
     147:	a1 a0 14 00 00       	mov    0x14a0,%eax
     14c:	83 c4 10             	add    $0x10,%esp
     14f:	8d 04 c5 12 00 00 00 	lea    0x12(,%eax,8),%eax
     156:	83 e0 f0             	and    $0xfffffff0,%eax
     159:	29 c4                	sub    %eax,%esp

    int i,j,k;
    if(N==1)
     15b:	a1 8c 14 00 00       	mov    0x148c,%eax
    int works[P][2];
     160:	89 65 a0             	mov    %esp,-0x60(%ebp)
    if(N==1)
     163:	83 f8 01             	cmp    $0x1,%eax
     166:	0f 84 5c 01 00 00    	je     2c8 <main+0x2c8>
        printf(1,"%d\n",0);
        exit();
    }
	float diff;
	float mean;
	float u[N][N];
     16c:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
     173:	0f af c0             	imul   %eax,%eax
     176:	89 5d 9c             	mov    %ebx,-0x64(%ebp)
     179:	8d 04 85 12 00 00 00 	lea    0x12(,%eax,4),%eax
     180:	83 e0 f0             	and    $0xfffffff0,%eax
     183:	29 c4                	sub    %eax,%esp
     185:	89 65 88             	mov    %esp,-0x78(%ebp)
	float w[N][N];
     188:	29 c4                	sub    %eax,%esp
     18a:	89 a5 78 ff ff ff    	mov    %esp,-0x88(%ebp)
    scheduler(works);
     190:	83 ec 0c             	sub    $0xc,%esp
     193:	ff 75 a0             	pushl  -0x60(%ebp)
     196:	e8 c5 07 00 00       	call   960 <scheduler>
	int count=0;
	mean = 0.0;
	for (i = 0; i < N; i++){
     19b:	8b 35 8c 14 00 00    	mov    0x148c,%esi
     1a1:	83 c4 10             	add    $0x10,%esp
     1a4:	85 f6                	test   %esi,%esi
     1a6:	0f 8e 83 07 00 00    	jle    92f <main+0x92f>
     1ac:	8d 7e ff             	lea    -0x1(%esi),%edi
		u[i][0] = T;
     1af:	c1 eb 02             	shr    $0x2,%ebx
	mean = 0.0;
     1b2:	d9 ee                	fldz   
		u[i][0] = T;
     1b4:	d9 05 90 14 00 00    	flds   0x1490
     1ba:	89 d8                	mov    %ebx,%eax
     1bc:	89 5d a8             	mov    %ebx,-0x58(%ebp)
     1bf:	8b 4d 88             	mov    -0x78(%ebp),%ecx
     1c2:	8d 1c bd 00 00 00 00 	lea    0x0(,%edi,4),%ebx
	for (i = 0; i < N; i++){
     1c9:	89 7d a4             	mov    %edi,-0x5c(%ebp)
     1cc:	0f af d8             	imul   %eax,%ebx
     1cf:	31 c0                	xor    %eax,%eax
     1d1:	01 cb                	add    %ecx,%ebx
     1d3:	90                   	nop
     1d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     1d8:	8b 55 a8             	mov    -0x58(%ebp),%edx
     1db:	0f af d0             	imul   %eax,%edx
     1de:	8d 3c 91             	lea    (%ecx,%edx,4),%edi
        u[i][N-1] = T;
     1e1:	03 55 a4             	add    -0x5c(%ebp),%edx
		u[i][0] = T;
     1e4:	d9 17                	fsts   (%edi)
        u[i][N-1] = T;
     1e6:	d9 14 91             	fsts   (%ecx,%edx,4)
        u[0][i] = T;
     1e9:	d9 14 81             	fsts   (%ecx,%eax,4)
		u[N-1][i] = 0.0;
     1ec:	d9 ee                	fldz   
     1ee:	d9 14 83             	fsts   (%ebx,%eax,4)
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
     1f1:	d9 07                	flds   (%edi)
     1f3:	d8 04 91             	fadds  (%ecx,%edx,4)
     1f6:	d8 04 81             	fadds  (%ecx,%eax,4)
	for (i = 0; i < N; i++){
     1f9:	83 c0 01             	add    $0x1,%eax
     1fc:	39 f0                	cmp    %esi,%eax
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
     1fe:	de c1                	faddp  %st,%st(1)
     200:	de c2                	faddp  %st,%st(2)
	for (i = 0; i < N; i++){
     202:	75 d4                	jne    1d8 <main+0x1d8>
     204:	dd d8                	fstp   %st(0)
	}
	mean /= (4.0 * N);
     206:	89 75 a8             	mov    %esi,-0x58(%ebp)
	for (i = 1; i < N-1; i++ )
     209:	83 fe 02             	cmp    $0x2,%esi
	mean /= (4.0 * N);
     20c:	db 45 a8             	fildl  -0x58(%ebp)
     20f:	d8 0d 6c 11 00 00    	fmuls  0x116c
     215:	de f9                	fdivrp %st,%st(1)
     217:	d9 5d b4             	fstps  -0x4c(%ebp)
     21a:	d9 45 b4             	flds   -0x4c(%ebp)
	for (i = 1; i < N-1; i++ )
     21d:	7e 30                	jle    24f <main+0x24f>
     21f:	8b 55 88             	mov    -0x78(%ebp),%edx
     222:	8b 7d 9c             	mov    -0x64(%ebp),%edi
     225:	8d 4e ff             	lea    -0x1(%esi),%ecx
     228:	bb 01 00 00 00       	mov    $0x1,%ebx
     22d:	01 fa                	add    %edi,%edx
     22f:	90                   	nop
		for ( j= 1; j < N-1; j++) u[i][j] = mean;
     230:	b8 01 00 00 00       	mov    $0x1,%eax
     235:	8d 76 00             	lea    0x0(%esi),%esi
     238:	d9 14 82             	fsts   (%edx,%eax,4)
     23b:	83 c0 01             	add    $0x1,%eax
     23e:	39 c8                	cmp    %ecx,%eax
     240:	75 f6                	jne    238 <main+0x238>
	for (i = 1; i < N-1; i++ )
     242:	83 c3 01             	add    $0x1,%ebx
     245:	01 fa                	add    %edi,%edx
     247:	39 cb                	cmp    %ecx,%ebx
     249:	75 e5                	jne    230 <main+0x230>
     24b:	dd d8                	fstp   %st(0)
     24d:	eb 02                	jmp    251 <main+0x251>
     24f:	dd d8                	fstp   %st(0)
    
    if(N==2)
     251:	83 fe 02             	cmp    $0x2,%esi
     254:	0f 85 95 00 00 00    	jne    2ef <main+0x2ef>
     25a:	8b 5d 88             	mov    -0x78(%ebp),%ebx
    {
        for(i =0; i <N; i++){
     25d:	31 f6                	xor    %esi,%esi
     25f:	90                   	nop
            for(j = 0; j<N; j++)
     260:	31 ff                	xor    %edi,%edi
     262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                printf(1,"%d ",((int)u[i][j]));
     268:	d9 04 bb             	flds   (%ebx,%edi,4)
     26b:	d9 7d b2             	fnstcw -0x4e(%ebp)
     26e:	0f b7 55 b2          	movzwl -0x4e(%ebp),%edx
     272:	83 ec 04             	sub    $0x4,%esp
            for(j = 0; j<N; j++)
     275:	83 c7 01             	add    $0x1,%edi
                printf(1,"%d ",((int)u[i][j]));
     278:	80 ce 0c             	or     $0xc,%dh
     27b:	66 89 55 b0          	mov    %dx,-0x50(%ebp)
     27f:	d9 6d b0             	fldcw  -0x50(%ebp)
     282:	db 5d ac             	fistpl -0x54(%ebp)
     285:	d9 6d b2             	fldcw  -0x4e(%ebp)
     288:	8b 55 ac             	mov    -0x54(%ebp),%edx
     28b:	52                   	push   %edx
     28c:	68 61 11 00 00       	push   $0x1161
     291:	6a 01                	push   $0x1
     293:	e8 58 0b 00 00       	call   df0 <printf>
            for(j = 0; j<N; j++)
     298:	83 c4 10             	add    $0x10,%esp
     29b:	39 3d 8c 14 00 00    	cmp    %edi,0x148c
     2a1:	7f c5                	jg     268 <main+0x268>
            printf(1,"\n");
     2a3:	83 ec 08             	sub    $0x8,%esp
        for(i =0; i <N; i++){
     2a6:	83 c6 01             	add    $0x1,%esi
            printf(1,"\n");
     2a9:	68 5f 11 00 00       	push   $0x115f
     2ae:	6a 01                	push   $0x1
     2b0:	e8 3b 0b 00 00       	call   df0 <printf>
     2b5:	03 5d 9c             	add    -0x64(%ebp),%ebx
        for(i =0; i <N; i++){
     2b8:	83 c4 10             	add    $0x10,%esp
     2bb:	39 35 8c 14 00 00    	cmp    %esi,0x148c
     2c1:	7f 9d                	jg     260 <main+0x260>
        }
        exit();
     2c3:	e8 8a 09 00 00       	call   c52 <exit>
        printf(1,"%d\n",0);
     2c8:	53                   	push   %ebx
     2c9:	6a 00                	push   $0x0
     2cb:	68 5d 11 00 00       	push   $0x115d
     2d0:	6a 01                	push   $0x1
     2d2:	e8 19 0b 00 00       	call   df0 <printf>
        exit();
     2d7:	e8 76 09 00 00       	call   c52 <exit>
        printf(1,"Need input filename\n");
     2dc:	57                   	push   %edi
     2dd:	57                   	push   %edi
     2de:	68 48 11 00 00       	push   $0x1148
     2e3:	6a 01                	push   $0x1
     2e5:	e8 06 0b 00 00       	call   df0 <printf>
        exit();
     2ea:	e8 63 09 00 00       	call   c52 <exit>
    }
    int ppid=getpid();
     2ef:	e8 de 09 00 00       	call   cd2 <getpid>
    int recids[P];
     2f4:	8b 15 a0 14 00 00    	mov    0x14a0,%edx
    int ppid=getpid();
     2fa:	89 45 8c             	mov    %eax,-0x74(%ebp)
    int recids[P];
     2fd:	8d 04 95 12 00 00 00 	lea    0x12(,%edx,4),%eax
     304:	83 e0 f0             	and    $0xfffffff0,%eax
     307:	29 c4                	sub    %eax,%esp

    for(k=0;k<P;k++)
     309:	85 d2                	test   %edx,%edx
    int recids[P];
     30b:	89 e6                	mov    %esp,%esi
     30d:	89 75 94             	mov    %esi,-0x6c(%ebp)
    for(k=0;k<P;k++)
     310:	0f 8e d5 02 00 00    	jle    5eb <main+0x5eb>
     316:	31 db                	xor    %ebx,%ebx
     318:	eb 18                	jmp    332 <main+0x332>
     31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                }   
            }
        }
        else
        {
            recids[k]=child;
     320:	89 04 9e             	mov    %eax,(%esi,%ebx,4)
    for(k=0;k<P;k++)
     323:	83 c3 01             	add    $0x1,%ebx
     326:	39 1d a0 14 00 00    	cmp    %ebx,0x14a0
     32c:	0f 8e b9 02 00 00    	jle    5eb <main+0x5eb>
        int child=fork();
     332:	e8 13 09 00 00       	call   c4a <fork>
        if(child==0)
     337:	85 c0                	test   %eax,%eax
     339:	75 e5                	jne    320 <main+0x320>
            int s=works[k][0];
     33b:	8b 75 a0             	mov    -0x60(%ebp),%esi
     33e:	89 9d 74 ff ff ff    	mov    %ebx,-0x8c(%ebp)
     344:	8b 3c de             	mov    (%esi,%ebx,8),%edi
            int e=works[k][1];
     347:	8b 4c de 04          	mov    0x4(%esi,%ebx,8),%ecx
            int s=works[k][0];
     34b:	89 7d 80             	mov    %edi,-0x80(%ebp)
            int e=works[k][1];
     34e:	89 4d 98             	mov    %ecx,-0x68(%ebp)
            int pid=getpid();
     351:	e8 7c 09 00 00       	call   cd2 <getpid>
                    for (j =1; j< N-1; j++) u[i][j] = w[i][j];
     356:	8b 5d 9c             	mov    -0x64(%ebp),%ebx
            int pid=getpid();
     359:	89 45 84             	mov    %eax,-0x7c(%ebp)
     35c:	89 f8                	mov    %edi,%eax
     35e:	8b 55 88             	mov    -0x78(%ebp),%edx
     361:	0f af c3             	imul   %ebx,%eax
                    for (j =1; j< N-1; j++) u[i][j] = w[i][j];
     364:	89 de                	mov    %ebx,%esi
     366:	c1 ee 02             	shr    $0x2,%esi
     369:	89 75 90             	mov    %esi,-0x70(%ebp)
     36c:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
     36f:	03 85 78 ff ff ff    	add    -0x88(%ebp),%eax
     375:	89 8d 7c ff ff ff    	mov    %ecx,-0x84(%ebp)
     37b:	8b 4d 98             	mov    -0x68(%ebp),%ecx
     37e:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
     384:	8d 41 ff             	lea    -0x1(%ecx),%eax
                                u[e][j-t+1]=msg1.val;
     387:	0f af f1             	imul   %ecx,%esi
     38a:	0f af c3             	imul   %ebx,%eax
     38d:	89 b5 6c ff ff ff    	mov    %esi,-0x94(%ebp)
     393:	01 d0                	add    %edx,%eax
     395:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
     39b:	8d 47 ff             	lea    -0x1(%edi),%eax
     39e:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
     3a4:	0f af c3             	imul   %ebx,%eax
     3a7:	0f af d9             	imul   %ecx,%ebx
     3aa:	01 d0                	add    %edx,%eax
     3ac:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
     3b2:	89 d8                	mov    %ebx,%eax
     3b4:	01 d0                	add    %edx,%eax
     3b6:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
                for(i =s; i < e; i++){
     3bc:	8b 45 80             	mov    -0x80(%ebp),%eax
     3bf:	8b 75 98             	mov    -0x68(%ebp),%esi
     3c2:	39 f0                	cmp    %esi,%eax
     3c4:	0f 8d 1a 04 00 00    	jge    7e4 <main+0x7e4>
                    for(j =1 ; j < N-1; j++){
     3ca:	8b 35 8c 14 00 00    	mov    0x148c,%esi
     3d0:	8b 8d 7c ff ff ff    	mov    -0x84(%ebp),%ecx
                diff = 0.0;
     3d6:	d9 ee                	fldz   
                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
     3d8:	8b 7d 90             	mov    -0x70(%ebp),%edi
                    for(j =1 ; j < N-1; j++){
     3db:	8b 9d 78 ff ff ff    	mov    -0x88(%ebp),%ebx
     3e1:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     3e4:	89 45 a8             	mov    %eax,-0x58(%ebp)
     3e7:	83 ee 01             	sub    $0x1,%esi
     3ea:	89 4d a0             	mov    %ecx,-0x60(%ebp)
                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
     3ed:	f7 df                	neg    %edi
     3ef:	90                   	nop
     3f0:	83 45 a8 01          	addl   $0x1,-0x58(%ebp)
                    for(j =1 ; j < N-1; j++){
     3f4:	ba 01 00 00 00       	mov    $0x1,%edx
     3f9:	8b 45 a8             	mov    -0x58(%ebp),%eax
     3fc:	89 c1                	mov    %eax,%ecx
     3fe:	2b 4d a4             	sub    -0x5c(%ebp),%ecx
     401:	0f af 4d 90          	imul   -0x70(%ebp),%ecx
                            diff = fabsm(w[i][j]- u[i][j]);	
     405:	8b 45 a0             	mov    -0x60(%ebp),%eax
     408:	eb 34                	jmp    43e <main+0x43e>
     40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
     410:	d9 44 b8 04          	flds   0x4(%eax,%edi,4)
                                u[i][j-1] + u[i][j+1])/4.0;
     414:	83 c2 01             	add    $0x1,%edx
                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
     417:	d8 44 88 04          	fadds  0x4(%eax,%ecx,4)
     41b:	d8 00                	fadds  (%eax)
                                u[i][j-1] + u[i][j+1])/4.0;
     41d:	d8 40 08             	fadds  0x8(%eax)
                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
     420:	d8 0d 70 11 00 00    	fmuls  0x1170
     426:	d9 54 93 fc          	fsts   -0x4(%ebx,%edx,4)
                        if( fabsm(w[i][j] - u[i][j]) > diff )
     42a:	d8 60 04             	fsubs  0x4(%eax)
	if(a<0)
     42d:	d9 ee                	fldz   
     42f:	df e9                	fucomip %st(1),%st
     431:	76 02                	jbe    435 <main+0x435>
	return -1*a;
     433:	d9 e0                	fchs   
                            diff = fabsm(w[i][j]- u[i][j]);	
     435:	db e9                	fucomi %st(1),%st
     437:	da d1                	fcmovbe %st(1),%st
     439:	dd d9                	fstp   %st(1)
     43b:	83 c0 04             	add    $0x4,%eax
                    for(j =1 ; j < N-1; j++){
     43e:	39 f2                	cmp    %esi,%edx
     440:	7c ce                	jl     410 <main+0x410>
     442:	8b 4d 9c             	mov    -0x64(%ebp),%ecx
     445:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
     449:	01 4d a0             	add    %ecx,-0x60(%ebp)
     44c:	01 cb                	add    %ecx,%ebx
                for(i =s; i < e; i++){
     44e:	8b 4d 98             	mov    -0x68(%ebp),%ecx
     451:	39 4d a8             	cmp    %ecx,-0x58(%ebp)
     454:	75 9a                	jne    3f0 <main+0x3f0>
                send(pid,ppid,(void*)&val);
     456:	8d 45 c0             	lea    -0x40(%ebp),%eax
     459:	52                   	push   %edx
                float val=diff;
     45a:	d9 5d c0             	fstps  -0x40(%ebp)
                send(pid,ppid,(void*)&val);
     45d:	50                   	push   %eax
     45e:	ff 75 8c             	pushl  -0x74(%ebp)
     461:	ff 75 84             	pushl  -0x7c(%ebp)
     464:	e8 a9 08 00 00       	call   d12 <send>
                recv((void*)&cmd);
     469:	8d 45 c4             	lea    -0x3c(%ebp),%eax
     46c:	89 04 24             	mov    %eax,(%esp)
     46f:	e8 a6 08 00 00       	call   d1a <recv>
                if((int)cmd==0)
     474:	83 c4 10             	add    $0x10,%esp
     477:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
     47b:	0f 84 92 03 00 00    	je     813 <main+0x813>
                    for (j =1; j< N-1; j++) u[i][j] = w[i][j];
     481:	8b 3d 8c 14 00 00    	mov    0x148c,%edi
     487:	8b 8d 7c ff ff ff    	mov    -0x84(%ebp),%ecx
     48d:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
     493:	8b 75 80             	mov    -0x80(%ebp),%esi
     496:	8d 5f ff             	lea    -0x1(%edi),%ebx
     499:	89 7d a4             	mov    %edi,-0x5c(%ebp)
     49c:	8b 7d 9c             	mov    -0x64(%ebp),%edi
     49f:	90                   	nop
     4a0:	83 7d a4 02          	cmpl   $0x2,-0x5c(%ebp)
     4a4:	b8 01 00 00 00       	mov    $0x1,%eax
     4a9:	7e 12                	jle    4bd <main+0x4bd>
     4ab:	90                   	nop
     4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     4b0:	d9 04 82             	flds   (%edx,%eax,4)
     4b3:	d9 1c 81             	fstps  (%ecx,%eax,4)
     4b6:	83 c0 01             	add    $0x1,%eax
     4b9:	39 c3                	cmp    %eax,%ebx
     4bb:	75 f3                	jne    4b0 <main+0x4b0>
                for (i =s; i< e; i++)	
     4bd:	83 c6 01             	add    $0x1,%esi
     4c0:	01 fa                	add    %edi,%edx
     4c2:	01 f9                	add    %edi,%ecx
     4c4:	39 75 a8             	cmp    %esi,-0x58(%ebp)
     4c7:	75 d7                	jne    4a0 <main+0x4a0>
                if(P>1) 
     4c9:	8b 1d a0 14 00 00    	mov    0x14a0,%ebx
     4cf:	83 fb 01             	cmp    $0x1,%ebx
     4d2:	0f 8e e4 fe ff ff    	jle    3bc <main+0x3bc>
                    if(k==0){
     4d8:	83 bd 74 ff ff ff 00 	cmpl   $0x0,-0x8c(%ebp)
     4df:	a1 8c 14 00 00       	mov    0x148c,%eax
     4e4:	0f 84 15 02 00 00    	je     6ff <main+0x6ff>
                    else if(k==P-1){
     4ea:	8d 53 ff             	lea    -0x1(%ebx),%edx
     4ed:	3b 95 74 ff ff ff    	cmp    -0x8c(%ebp),%edx
     4f3:	0f 84 bb 03 00 00    	je     8b4 <main+0x8b4>
                    int other_id=-1;
     4f9:	83 ce ff             	or     $0xffffffff,%esi
                        for(j=1;j<N-1;j++)
     4fc:	83 f8 02             	cmp    $0x2,%eax
     4ff:	0f 8e a6 01 00 00    	jle    6ab <main+0x6ab>
     505:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     50b:	8b 75 94             	mov    -0x6c(%ebp),%esi
     50e:	8d 5d cc             	lea    -0x34(%ebp),%ebx
     511:	bf 01 00 00 00       	mov    $0x1,%edi
     516:	89 5d a8             	mov    %ebx,-0x58(%ebp)
     519:	89 fb                	mov    %edi,%ebx
     51b:	8b bd 7c ff ff ff    	mov    -0x84(%ebp),%edi
     521:	83 e8 01             	sub    $0x1,%eax
     524:	8b 34 86             	mov    (%esi,%eax,4),%esi
     527:	89 45 a0             	mov    %eax,-0x60(%ebp)
     52a:	89 75 a4             	mov    %esi,-0x5c(%ebp)
     52d:	8b 75 84             	mov    -0x7c(%ebp),%esi
                            send(pid,recids[k-1],(void*)&msg1);
     530:	83 ec 04             	sub    $0x4,%esp
                            msg1.senderid=pid;
     533:	89 75 cc             	mov    %esi,-0x34(%ebp)
                            msg1.val=u[s][j];
     536:	d9 04 9f             	flds   (%edi,%ebx,4)
                            send(pid,recids[k-1],(void*)&msg1);
     539:	ff 75 a8             	pushl  -0x58(%ebp)
                        for(j=1;j<N-1;j++)
     53c:	83 c3 01             	add    $0x1,%ebx
                            send(pid,recids[k-1],(void*)&msg1);
     53f:	ff 75 a4             	pushl  -0x5c(%ebp)
     542:	56                   	push   %esi
                            msg1.val=u[s][j];
     543:	d9 5d d0             	fstps  -0x30(%ebp)
                            send(pid,recids[k-1],(void*)&msg1);
     546:	e8 c7 07 00 00       	call   d12 <send>
                        for(j=1;j<N-1;j++)
     54b:	a1 8c 14 00 00       	mov    0x148c,%eax
     550:	83 c4 10             	add    $0x10,%esp
     553:	83 e8 01             	sub    $0x1,%eax
     556:	39 d8                	cmp    %ebx,%eax
     558:	7f d6                	jg     530 <main+0x530>
                        for(j=0;j<2*N-4;j++)
     55a:	83 3d 8c 14 00 00 02 	cmpl   $0x2,0x148c
     561:	8b 5d a8             	mov    -0x58(%ebp),%ebx
     564:	0f 8e 52 fe ff ff    	jle    3bc <main+0x3bc>
     56a:	8b 75 a0             	mov    -0x60(%ebp),%esi
     56d:	8b 45 94             	mov    -0x6c(%ebp),%eax
                        int t=0;
     570:	31 d2                	xor    %edx,%edx
                                u[s-1][t+1]=msg1.val;
     572:	89 5d a4             	mov    %ebx,-0x5c(%ebp)
                        for(j=0;j<2*N-4;j++)
     575:	31 ff                	xor    %edi,%edi
                                u[s-1][t+1]=msg1.val;
     577:	89 d3                	mov    %edx,%ebx
     579:	8b 04 b0             	mov    (%eax,%esi,4),%eax
                    int other_id=-1;
     57c:	83 ce ff             	or     $0xffffffff,%esi
     57f:	89 45 a8             	mov    %eax,-0x58(%ebp)
                                u[s-1][t+1]=msg1.val;
     582:	8b 45 90             	mov    -0x70(%ebp),%eax
     585:	0f af 85 64 ff ff ff 	imul   -0x9c(%ebp),%eax
     58c:	89 45 a0             	mov    %eax,-0x60(%ebp)
     58f:	eb 37                	jmp    5c8 <main+0x5c8>
                            if(msg1.senderid==recids[k-1])
     591:	8b 45 a8             	mov    -0x58(%ebp),%eax
     594:	39 45 cc             	cmp    %eax,-0x34(%ebp)
     597:	0f 84 f8 00 00 00    	je     695 <main+0x695>
                                u[e][j-t+1]=msg1.val;
     59d:	8b 8d 6c ff ff ff    	mov    -0x94(%ebp),%ecx
     5a3:	89 f8                	mov    %edi,%eax
     5a5:	d9 45 d0             	flds   -0x30(%ebp)
     5a8:	29 d8                	sub    %ebx,%eax
     5aa:	8d 44 08 01          	lea    0x1(%eax,%ecx,1),%eax
     5ae:	8b 4d 88             	mov    -0x78(%ebp),%ecx
     5b1:	d9 1c 81             	fstps  (%ecx,%eax,4)
                        for(j=0;j<2*N-4;j++)
     5b4:	a1 8c 14 00 00       	mov    0x148c,%eax
     5b9:	83 c7 01             	add    $0x1,%edi
     5bc:	8d 44 00 fc          	lea    -0x4(%eax,%eax,1),%eax
     5c0:	39 f8                	cmp    %edi,%eax
     5c2:	0f 8e e3 00 00 00    	jle    6ab <main+0x6ab>
                            recv((void*)&msg1);
     5c8:	83 ec 0c             	sub    $0xc,%esp
     5cb:	ff 75 a4             	pushl  -0x5c(%ebp)
     5ce:	e8 47 07 00 00       	call   d1a <recv>
                            if(other_id==-1&&msg1.senderid!=recids[k-1])
     5d3:	83 c4 10             	add    $0x10,%esp
     5d6:	83 fe ff             	cmp    $0xffffffff,%esi
     5d9:	75 b6                	jne    591 <main+0x591>
     5db:	8b 45 cc             	mov    -0x34(%ebp),%eax
     5de:	3b 45 a8             	cmp    -0x58(%ebp),%eax
     5e1:	0f 84 ae 00 00 00    	je     695 <main+0x695>
     5e7:	89 c6                	mov    %eax,%esi
     5e9:	eb b2                	jmp    59d <main+0x59d>
     5eb:	8d 5d cc             	lea    -0x34(%ebp),%ebx
     5ee:	8d 75 c8             	lea    -0x38(%ebp),%esi
	int count=0;
     5f1:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     5f8:	90                   	nop
     5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(1)
    {
        int cmd=1;
        float maxdiff=0.0;
        count++;
        for (i=0;i<P;i++)
     600:	8b 3d a0 14 00 00    	mov    0x14a0,%edi
        count++;
     606:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
        float maxdiff=0.0;
     60a:	d9 ee                	fldz   
        int cmd=1;
     60c:	c7 45 c8 01 00 00 00 	movl   $0x1,-0x38(%ebp)
        for (i=0;i<P;i++)
     613:	85 ff                	test   %edi,%edi
     615:	7e 2f                	jle    646 <main+0x646>
     617:	31 ff                	xor    %edi,%edi
     619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        {
            float value;
            recv((void*)&value);
     620:	83 ec 0c             	sub    $0xc,%esp
     623:	d9 5d a8             	fstps  -0x58(%ebp)
     626:	53                   	push   %ebx
     627:	e8 ee 06 00 00       	call   d1a <recv>
            if(value>maxdiff)
                maxdiff=value;
     62c:	d9 45 a8             	flds   -0x58(%ebp)
            if(value>maxdiff)
     62f:	d9 45 cc             	flds   -0x34(%ebp)
     632:	83 c4 10             	add    $0x10,%esp
                maxdiff=value;
     635:	db e9                	fucomi %st(1),%st
     637:	da d1                	fcmovbe %st(1),%st
     639:	dd d9                	fstp   %st(1)
        for (i=0;i<P;i++)
     63b:	83 c7 01             	add    $0x1,%edi
     63e:	39 3d a0 14 00 00    	cmp    %edi,0x14a0
     644:	7f da                	jg     620 <main+0x620>
        }
        if(maxdiff<= E || count > L){ 
     646:	d9 05 9c 14 00 00    	flds   0x149c
     64c:	a1 a0 14 00 00       	mov    0x14a0,%eax
     651:	df e9                	fucomip %st(1),%st
     653:	dd d8                	fstp   %st(0)
     655:	0f 83 4c 01 00 00    	jae    7a7 <main+0x7a7>
     65b:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
     65e:	39 0d 98 14 00 00    	cmp    %ecx,0x1498
     664:	0f 8c 3d 01 00 00    	jl     7a7 <main+0x7a7>
            }
            exit();
        }
        else
        {
            for(i=0;i<P;i++)
     66a:	31 ff                	xor    %edi,%edi
     66c:	85 c0                	test   %eax,%eax
     66e:	7e 90                	jle    600 <main+0x600>
            {
                send(ppid,recids[i],(void*)&cmd);
     670:	8b 45 94             	mov    -0x6c(%ebp),%eax
     673:	83 ec 04             	sub    $0x4,%esp
     676:	56                   	push   %esi
     677:	ff 34 b8             	pushl  (%eax,%edi,4)
     67a:	ff 75 8c             	pushl  -0x74(%ebp)
            for(i=0;i<P;i++)
     67d:	83 c7 01             	add    $0x1,%edi
                send(ppid,recids[i],(void*)&cmd);
     680:	e8 8d 06 00 00       	call   d12 <send>
            for(i=0;i<P;i++)
     685:	83 c4 10             	add    $0x10,%esp
     688:	39 3d a0 14 00 00    	cmp    %edi,0x14a0
     68e:	7f e0                	jg     670 <main+0x670>
     690:	e9 6b ff ff ff       	jmp    600 <main+0x600>
                                u[s-1][t+1]=msg1.val;
     695:	8b 45 a0             	mov    -0x60(%ebp),%eax
     698:	8b 4d 88             	mov    -0x78(%ebp),%ecx
     69b:	83 c3 01             	add    $0x1,%ebx
     69e:	d9 45 d0             	flds   -0x30(%ebp)
     6a1:	01 d8                	add    %ebx,%eax
     6a3:	d9 1c 81             	fstps  (%ecx,%eax,4)
     6a6:	e9 09 ff ff ff       	jmp    5b4 <main+0x5b4>
                        for(j=1;j<N-1;j++)
     6ab:	83 3d 8c 14 00 00 02 	cmpl   $0x2,0x148c
     6b2:	0f 8e 04 fd ff ff    	jle    3bc <main+0x3bc>
     6b8:	8d 5d cc             	lea    -0x34(%ebp),%ebx
     6bb:	89 75 a8             	mov    %esi,-0x58(%ebp)
     6be:	8b 75 84             	mov    -0x7c(%ebp),%esi
     6c1:	bf 01 00 00 00       	mov    $0x1,%edi
     6c6:	89 5d a4             	mov    %ebx,-0x5c(%ebp)
     6c9:	8b 9d 68 ff ff ff    	mov    -0x98(%ebp),%ebx
     6cf:	90                   	nop
                            send(pid,other_id,(void*)&msg1);
     6d0:	83 ec 04             	sub    $0x4,%esp
                            msg1.val=u[e-1][j];
     6d3:	d9 04 bb             	flds   (%ebx,%edi,4)
                            send(pid,other_id,(void*)&msg1);
     6d6:	ff 75 a4             	pushl  -0x5c(%ebp)
     6d9:	ff 75 a8             	pushl  -0x58(%ebp)
     6dc:	56                   	push   %esi
                        for(j=1;j<N-1;j++)
     6dd:	83 c7 01             	add    $0x1,%edi
                            msg1.senderid=pid;
     6e0:	89 75 cc             	mov    %esi,-0x34(%ebp)
                            msg1.val=u[e-1][j];
     6e3:	d9 5d d0             	fstps  -0x30(%ebp)
                            send(pid,other_id,(void*)&msg1);
     6e6:	e8 27 06 00 00       	call   d12 <send>
                        for(j=1;j<N-1;j++)
     6eb:	a1 8c 14 00 00       	mov    0x148c,%eax
     6f0:	83 c4 10             	add    $0x10,%esp
     6f3:	83 e8 01             	sub    $0x1,%eax
     6f6:	39 f8                	cmp    %edi,%eax
     6f8:	7f d6                	jg     6d0 <main+0x6d0>
     6fa:	e9 bd fc ff ff       	jmp    3bc <main+0x3bc>
                        for(j=1;j<N-1;j++)
     6ff:	83 f8 02             	cmp    $0x2,%eax
     702:	0f 8e b4 fc ff ff    	jle    3bc <main+0x3bc>
     708:	8d 5d cc             	lea    -0x34(%ebp),%ebx
                    int other_id=-1;
     70b:	83 ce ff             	or     $0xffffffff,%esi
                        for(j=1;j<N-1;j++)
     70e:	bf 01 00 00 00       	mov    $0x1,%edi
     713:	89 d8                	mov    %ebx,%eax
     715:	89 f3                	mov    %esi,%ebx
     717:	89 c6                	mov    %eax,%esi
     719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                            recv((void*)&msg1);
     720:	83 ec 0c             	sub    $0xc,%esp
     723:	56                   	push   %esi
     724:	e8 f1 05 00 00       	call   d1a <recv>
                            u[e][j]=msg1.val;
     729:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
     72f:	d9 45 d0             	flds   -0x30(%ebp)
                            if(other_id==-1)
     732:	83 c4 10             	add    $0x10,%esp
                                other_id=msg1.senderid;
     735:	83 fb ff             	cmp    $0xffffffff,%ebx
     738:	0f 44 5d cc          	cmove  -0x34(%ebp),%ebx
                            u[e][j]=msg1.val;
     73c:	d9 1c b8             	fstps  (%eax,%edi,4)
                        for(j=1;j<N-1;j++)
     73f:	a1 8c 14 00 00       	mov    0x148c,%eax
     744:	83 c7 01             	add    $0x1,%edi
     747:	8d 48 ff             	lea    -0x1(%eax),%ecx
     74a:	39 f9                	cmp    %edi,%ecx
     74c:	7f d2                	jg     720 <main+0x720>
     74e:	89 f7                	mov    %esi,%edi
                        for(j=1;j<N-1;j++)
     750:	83 f8 02             	cmp    $0x2,%eax
     753:	89 de                	mov    %ebx,%esi
     755:	89 fb                	mov    %edi,%ebx
     757:	0f 8e 5f fc ff ff    	jle    3bc <main+0x3bc>
     75d:	89 75 a8             	mov    %esi,-0x58(%ebp)
     760:	89 5d a4             	mov    %ebx,-0x5c(%ebp)
     763:	bf 01 00 00 00       	mov    $0x1,%edi
     768:	8b 75 84             	mov    -0x7c(%ebp),%esi
     76b:	8b 9d 68 ff ff ff    	mov    -0x98(%ebp),%ebx
     771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                            send(pid,other_id,(void*)&msg1);
     778:	83 ec 04             	sub    $0x4,%esp
                            msg1.val=u[e-1][j];
     77b:	d9 04 bb             	flds   (%ebx,%edi,4)
                            send(pid,other_id,(void*)&msg1);
     77e:	ff 75 a4             	pushl  -0x5c(%ebp)
     781:	ff 75 a8             	pushl  -0x58(%ebp)
     784:	56                   	push   %esi
                        for(j=1;j<N-1;j++)
     785:	83 c7 01             	add    $0x1,%edi
                            msg1.senderid=pid;
     788:	89 75 cc             	mov    %esi,-0x34(%ebp)
                            msg1.val=u[e-1][j];
     78b:	d9 5d d0             	fstps  -0x30(%ebp)
                            send(pid,other_id,(void*)&msg1);
     78e:	e8 7f 05 00 00       	call   d12 <send>
                        for(j=1;j<N-1;j++)
     793:	a1 8c 14 00 00       	mov    0x148c,%eax
     798:	83 c4 10             	add    $0x10,%esp
     79b:	83 e8 01             	sub    $0x1,%eax
     79e:	39 f8                	cmp    %edi,%eax
     7a0:	7f d6                	jg     778 <main+0x778>
     7a2:	e9 15 fc ff ff       	jmp    3bc <main+0x3bc>
            for(i=0;i<P;i++)
     7a7:	85 c0                	test   %eax,%eax
            cmd=0;
     7a9:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
            for(i=0;i<P;i++)
     7b0:	0f 8e 0d fb ff ff    	jle    2c3 <main+0x2c3>
     7b6:	8b 7d 8c             	mov    -0x74(%ebp),%edi
     7b9:	8d 5d c8             	lea    -0x38(%ebp),%ebx
     7bc:	31 f6                	xor    %esi,%esi
                send(ppid,recids[i],(void*)&cmd);
     7be:	8b 45 94             	mov    -0x6c(%ebp),%eax
     7c1:	51                   	push   %ecx
     7c2:	53                   	push   %ebx
     7c3:	ff 34 b0             	pushl  (%eax,%esi,4)
     7c6:	57                   	push   %edi
            for(i=0;i<P;i++)
     7c7:	83 c6 01             	add    $0x1,%esi
                send(ppid,recids[i],(void*)&cmd);
     7ca:	e8 43 05 00 00       	call   d12 <send>
                wait();
     7cf:	e8 86 04 00 00       	call   c5a <wait>
            for(i=0;i<P;i++)
     7d4:	83 c4 10             	add    $0x10,%esp
     7d7:	39 35 a0 14 00 00    	cmp    %esi,0x14a0
     7dd:	7f df                	jg     7be <main+0x7be>
     7df:	e9 df fa ff ff       	jmp    2c3 <main+0x2c3>
                send(pid,ppid,(void*)&val);
     7e4:	50                   	push   %eax
     7e5:	8d 45 c0             	lea    -0x40(%ebp),%eax
                float val=diff;
     7e8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
                send(pid,ppid,(void*)&val);
     7ef:	50                   	push   %eax
     7f0:	ff 75 8c             	pushl  -0x74(%ebp)
     7f3:	ff 75 84             	pushl  -0x7c(%ebp)
     7f6:	e8 17 05 00 00       	call   d12 <send>
                recv((void*)&cmd);
     7fb:	8d 45 c4             	lea    -0x3c(%ebp),%eax
     7fe:	89 04 24             	mov    %eax,(%esp)
     801:	e8 14 05 00 00       	call   d1a <recv>
                if((int)cmd==0)
     806:	83 c4 10             	add    $0x10,%esp
     809:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
     80d:	0f 85 b6 fc ff ff    	jne    4c9 <main+0x4c9>
                        ns=ns-1;
     813:	8b b5 74 ff ff ff    	mov    -0x8c(%ebp),%esi
     819:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
     81f:	85 f6                	test   %esi,%esi
     821:	0f 45 45 80          	cmovne -0x80(%ebp),%eax
     825:	89 45 80             	mov    %eax,-0x80(%ebp)
                    if(k==P-1)
     828:	a1 a0 14 00 00       	mov    0x14a0,%eax
     82d:	83 e8 01             	sub    $0x1,%eax
     830:	39 f0                	cmp    %esi,%eax
     832:	75 04                	jne    838 <main+0x838>
                        ne=ne+1;
     834:	83 45 98 01          	addl   $0x1,-0x68(%ebp)
     838:	8b 75 80             	mov    -0x80(%ebp),%esi
     83b:	8b 5d 9c             	mov    -0x64(%ebp),%ebx
     83e:	0f af de             	imul   %esi,%ebx
     841:	03 5d 88             	add    -0x78(%ebp),%ebx
                    for(i =ns; i <ne; i++){
     844:	3b 75 98             	cmp    -0x68(%ebp),%esi
     847:	0f 8d 76 fa ff ff    	jge    2c3 <main+0x2c3>
                        for(j = 0; j<N; j++)
     84d:	31 ff                	xor    %edi,%edi
     84f:	83 3d 8c 14 00 00 00 	cmpl   $0x0,0x148c
     856:	7e 43                	jle    89b <main+0x89b>
     858:	90                   	nop
     859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                            printf(1,"%d ",((int)u[i][j]));
     860:	d9 04 bb             	flds   (%ebx,%edi,4)
     863:	d9 7d b2             	fnstcw -0x4e(%ebp)
     866:	0f b7 55 b2          	movzwl -0x4e(%ebp),%edx
     86a:	83 ec 04             	sub    $0x4,%esp
                        for(j = 0; j<N; j++)
     86d:	83 c7 01             	add    $0x1,%edi
                            printf(1,"%d ",((int)u[i][j]));
     870:	80 ce 0c             	or     $0xc,%dh
     873:	66 89 55 b0          	mov    %dx,-0x50(%ebp)
     877:	d9 6d b0             	fldcw  -0x50(%ebp)
     87a:	db 5d ac             	fistpl -0x54(%ebp)
     87d:	d9 6d b2             	fldcw  -0x4e(%ebp)
     880:	8b 55 ac             	mov    -0x54(%ebp),%edx
     883:	52                   	push   %edx
     884:	68 61 11 00 00       	push   $0x1161
     889:	6a 01                	push   $0x1
     88b:	e8 60 05 00 00       	call   df0 <printf>
                        for(j = 0; j<N; j++)
     890:	83 c4 10             	add    $0x10,%esp
     893:	39 3d 8c 14 00 00    	cmp    %edi,0x148c
     899:	7f c5                	jg     860 <main+0x860>
                        printf(1,"\n");
     89b:	51                   	push   %ecx
     89c:	51                   	push   %ecx
                    for(i =ns; i <ne; i++){
     89d:	83 c6 01             	add    $0x1,%esi
                        printf(1,"\n");
     8a0:	68 5f 11 00 00       	push   $0x115f
     8a5:	6a 01                	push   $0x1
     8a7:	e8 44 05 00 00       	call   df0 <printf>
     8ac:	03 5d 9c             	add    -0x64(%ebp),%ebx
     8af:	83 c4 10             	add    $0x10,%esp
     8b2:	eb 90                	jmp    844 <main+0x844>
                            send(pid,recids[k-1],(void*)&msg1);
     8b4:	83 eb 02             	sub    $0x2,%ebx
                        for(j=1;j<N-1;j++)
     8b7:	bf 01 00 00 00       	mov    $0x1,%edi
                            send(pid,recids[k-1],(void*)&msg1);
     8bc:	8d 75 cc             	lea    -0x34(%ebp),%esi
     8bf:	89 5d a8             	mov    %ebx,-0x58(%ebp)
     8c2:	8b 9d 7c ff ff ff    	mov    -0x84(%ebp),%ebx
     8c8:	eb 28                	jmp    8f2 <main+0x8f2>
                            msg1.senderid=pid;
     8ca:	8b 45 84             	mov    -0x7c(%ebp),%eax
                            send(pid,recids[k-1],(void*)&msg1);
     8cd:	8b 4d 94             	mov    -0x6c(%ebp),%ecx
                            msg1.senderid=pid;
     8d0:	89 45 cc             	mov    %eax,-0x34(%ebp)
                            msg1.val=u[s][j];
     8d3:	d9 04 bb             	flds   (%ebx,%edi,4)
                            send(pid,recids[k-1],(void*)&msg1);
     8d6:	52                   	push   %edx
                        for(j=1;j<N-1;j++)
     8d7:	83 c7 01             	add    $0x1,%edi
                            send(pid,recids[k-1],(void*)&msg1);
     8da:	8b 55 a8             	mov    -0x58(%ebp),%edx
     8dd:	56                   	push   %esi
                            msg1.val=u[s][j];
     8de:	d9 5d d0             	fstps  -0x30(%ebp)
                            send(pid,recids[k-1],(void*)&msg1);
     8e1:	ff 34 91             	pushl  (%ecx,%edx,4)
     8e4:	50                   	push   %eax
     8e5:	e8 28 04 00 00       	call   d12 <send>
     8ea:	a1 8c 14 00 00       	mov    0x148c,%eax
                        for(j=1;j<N-1;j++)
     8ef:	83 c4 10             	add    $0x10,%esp
     8f2:	8d 48 ff             	lea    -0x1(%eax),%ecx
     8f5:	39 cf                	cmp    %ecx,%edi
     8f7:	7c d1                	jl     8ca <main+0x8ca>
                        for(j=1;j<N-1;j++)
     8f9:	be 01 00 00 00       	mov    $0x1,%esi
                            recv((void*)&msg1);
     8fe:	8d 5d cc             	lea    -0x34(%ebp),%ebx
     901:	8b bd 60 ff ff ff    	mov    -0xa0(%ebp),%edi
     907:	eb 1a                	jmp    923 <main+0x923>
     909:	83 ec 0c             	sub    $0xc,%esp
     90c:	53                   	push   %ebx
     90d:	e8 08 04 00 00       	call   d1a <recv>
     912:	a1 8c 14 00 00       	mov    0x148c,%eax
                            u[s-1][j]=msg1.val;
     917:	d9 45 d0             	flds   -0x30(%ebp)
                        for(j=1;j<N-1;j++)
     91a:	83 c4 10             	add    $0x10,%esp
                            u[s-1][j]=msg1.val;
     91d:	d9 1c b7             	fstps  (%edi,%esi,4)
                        for(j=1;j<N-1;j++)
     920:	83 c6 01             	add    $0x1,%esi
     923:	83 e8 01             	sub    $0x1,%eax
     926:	39 c6                	cmp    %eax,%esi
     928:	7c df                	jl     909 <main+0x909>
     92a:	e9 8d fa ff ff       	jmp    3bc <main+0x3bc>
	mean = 0.0;
     92f:	d9 ee                	fldz   
     931:	e9 d0 f8 ff ff       	jmp    206 <main+0x206>
     936:	66 90                	xchg   %ax,%ax
     938:	66 90                	xchg   %ax,%ax
     93a:	66 90                	xchg   %ax,%ax
     93c:	66 90                	xchg   %ax,%ax
     93e:	66 90                	xchg   %ax,%ax

00000940 <fabsm>:
float fabsm(float a){
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	d9 45 08             	flds   0x8(%ebp)
	if(a<0)
     946:	d9 ee                	fldz   
     948:	df e9                	fucomip %st(1),%st
     94a:	77 04                	ja     950 <fabsm+0x10>
}
     94c:	5d                   	pop    %ebp
     94d:	c3                   	ret    
     94e:	66 90                	xchg   %ax,%ax
	return -1*a;
     950:	d9 e0                	fchs   
}
     952:	5d                   	pop    %ebp
     953:	c3                   	ret    
     954:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     95a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000960 <scheduler>:
void scheduler(int works[][2]) {
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	57                   	push   %edi
     964:	56                   	push   %esi
     965:	53                   	push   %ebx
     966:	83 ec 08             	sub    $0x8,%esp
    int slice = (N-2)/nWorkers;
     969:	a1 8c 14 00 00       	mov    0x148c,%eax
    nWorkers = P;
     96e:	8b 0d a0 14 00 00    	mov    0x14a0,%ecx
void scheduler(int works[][2]) {
     974:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int slice = (N-2)/nWorkers;
     977:	83 e8 02             	sub    $0x2,%eax
    nWorkers = P;
     97a:	89 0d 94 14 00 00    	mov    %ecx,0x1494
     980:	99                   	cltd   
     981:	f7 f9                	idiv   %ecx
    for (int i = 0; i < nWorkers; ++i) {
     983:	85 c9                	test   %ecx,%ecx
     985:	89 55 f0             	mov    %edx,-0x10(%ebp)
     988:	7e 6e                	jle    9f8 <scheduler+0x98>
     98a:	b9 01 00 00 00       	mov    $0x1,%ecx
     98f:	31 d2                	xor    %edx,%edx
     991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        works[i][0]=i*slice+1;
     998:	89 0c d3             	mov    %ecx,(%ebx,%edx,8)
        works[i][1]=(i+1)*slice+1;
     99b:	83 c2 01             	add    $0x1,%edx
     99e:	01 c1                	add    %eax,%ecx
     9a0:	89 4c d3 fc          	mov    %ecx,-0x4(%ebx,%edx,8)
    for (int i = 0; i < nWorkers; ++i) {
     9a4:	3b 15 94 14 00 00    	cmp    0x1494,%edx
     9aa:	7c ec                	jl     998 <scheduler+0x38>
    if (residual != 0) {
     9ac:	8b 55 f0             	mov    -0x10(%ebp),%edx
     9af:	85 d2                	test   %edx,%edx
     9b1:	74 45                	je     9f8 <scheduler+0x98>
        for (int i = 0; i < nWorkers; ++i) {
     9b3:	8b 0d 94 14 00 00    	mov    0x1494,%ecx
     9b9:	85 c9                	test   %ecx,%ecx
     9bb:	7e 3b                	jle    9f8 <scheduler+0x98>
     9bd:	8b 13                	mov    (%ebx),%edx
     9bf:	31 f6                	xor    %esi,%esi
     9c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
     9c4:	eb 17                	jmp    9dd <scheduler+0x7d>
     9c6:	8d 76 00             	lea    0x0(%esi),%esi
     9c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if (i != 0) works[i][0] = works[i - 1][1];
     9d0:	8b 54 f3 fc          	mov    -0x4(%ebx,%esi,8),%edx
     9d4:	89 14 f3             	mov    %edx,(%ebx,%esi,8)
     9d7:	8b 0d 94 14 00 00    	mov    0x1494,%ecx
     9dd:	03 55 ec             	add    -0x14(%ebp),%edx
            if (residual-- > 0) works[i][1] = works[i][0] + slice + 1;
     9e0:	8b 7d f0             	mov    -0x10(%ebp),%edi
     9e3:	29 f7                	sub    %esi,%edi
     9e5:	8d 42 01             	lea    0x1(%edx),%eax
     9e8:	85 ff                	test   %edi,%edi
     9ea:	0f 4f d0             	cmovg  %eax,%edx
     9ed:	89 54 f3 04          	mov    %edx,0x4(%ebx,%esi,8)
        for (int i = 0; i < nWorkers; ++i) {
     9f1:	83 c6 01             	add    $0x1,%esi
     9f4:	39 f1                	cmp    %esi,%ecx
     9f6:	7f d8                	jg     9d0 <scheduler+0x70>
}
     9f8:	83 c4 08             	add    $0x8,%esp
     9fb:	5b                   	pop    %ebx
     9fc:	5e                   	pop    %esi
     9fd:	5f                   	pop    %edi
     9fe:	5d                   	pop    %ebp
     9ff:	c3                   	ret    

00000a00 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	53                   	push   %ebx
     a04:	8b 45 08             	mov    0x8(%ebp),%eax
     a07:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     a0a:	89 c2                	mov    %eax,%edx
     a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a10:	83 c1 01             	add    $0x1,%ecx
     a13:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     a17:	83 c2 01             	add    $0x1,%edx
     a1a:	84 db                	test   %bl,%bl
     a1c:	88 5a ff             	mov    %bl,-0x1(%edx)
     a1f:	75 ef                	jne    a10 <strcpy+0x10>
    ;
  return os;
}
     a21:	5b                   	pop    %ebx
     a22:	5d                   	pop    %ebp
     a23:	c3                   	ret    
     a24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000a30 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	53                   	push   %ebx
     a34:	8b 55 08             	mov    0x8(%ebp),%edx
     a37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     a3a:	0f b6 02             	movzbl (%edx),%eax
     a3d:	0f b6 19             	movzbl (%ecx),%ebx
     a40:	84 c0                	test   %al,%al
     a42:	75 1c                	jne    a60 <strcmp+0x30>
     a44:	eb 2a                	jmp    a70 <strcmp+0x40>
     a46:	8d 76 00             	lea    0x0(%esi),%esi
     a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     a50:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     a53:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     a56:	83 c1 01             	add    $0x1,%ecx
     a59:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     a5c:	84 c0                	test   %al,%al
     a5e:	74 10                	je     a70 <strcmp+0x40>
     a60:	38 d8                	cmp    %bl,%al
     a62:	74 ec                	je     a50 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     a64:	29 d8                	sub    %ebx,%eax
}
     a66:	5b                   	pop    %ebx
     a67:	5d                   	pop    %ebp
     a68:	c3                   	ret    
     a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a70:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     a72:	29 d8                	sub    %ebx,%eax
}
     a74:	5b                   	pop    %ebx
     a75:	5d                   	pop    %ebp
     a76:	c3                   	ret    
     a77:	89 f6                	mov    %esi,%esi
     a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a80 <strlen>:

uint
strlen(const char *s)
{
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     a86:	80 39 00             	cmpb   $0x0,(%ecx)
     a89:	74 15                	je     aa0 <strlen+0x20>
     a8b:	31 d2                	xor    %edx,%edx
     a8d:	8d 76 00             	lea    0x0(%esi),%esi
     a90:	83 c2 01             	add    $0x1,%edx
     a93:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     a97:	89 d0                	mov    %edx,%eax
     a99:	75 f5                	jne    a90 <strlen+0x10>
    ;
  return n;
}
     a9b:	5d                   	pop    %ebp
     a9c:	c3                   	ret    
     a9d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     aa0:	31 c0                	xor    %eax,%eax
}
     aa2:	5d                   	pop    %ebp
     aa3:	c3                   	ret    
     aa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     aaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ab0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	57                   	push   %edi
     ab4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     ab7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     aba:	8b 45 0c             	mov    0xc(%ebp),%eax
     abd:	89 d7                	mov    %edx,%edi
     abf:	fc                   	cld    
     ac0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     ac2:	89 d0                	mov    %edx,%eax
     ac4:	5f                   	pop    %edi
     ac5:	5d                   	pop    %ebp
     ac6:	c3                   	ret    
     ac7:	89 f6                	mov    %esi,%esi
     ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ad0 <strchr>:

char*
strchr(const char *s, char c)
{
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	53                   	push   %ebx
     ad4:	8b 45 08             	mov    0x8(%ebp),%eax
     ad7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     ada:	0f b6 10             	movzbl (%eax),%edx
     add:	84 d2                	test   %dl,%dl
     adf:	74 1d                	je     afe <strchr+0x2e>
    if(*s == c)
     ae1:	38 d3                	cmp    %dl,%bl
     ae3:	89 d9                	mov    %ebx,%ecx
     ae5:	75 0d                	jne    af4 <strchr+0x24>
     ae7:	eb 17                	jmp    b00 <strchr+0x30>
     ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     af0:	38 ca                	cmp    %cl,%dl
     af2:	74 0c                	je     b00 <strchr+0x30>
  for(; *s; s++)
     af4:	83 c0 01             	add    $0x1,%eax
     af7:	0f b6 10             	movzbl (%eax),%edx
     afa:	84 d2                	test   %dl,%dl
     afc:	75 f2                	jne    af0 <strchr+0x20>
      return (char*)s;
  return 0;
     afe:	31 c0                	xor    %eax,%eax
}
     b00:	5b                   	pop    %ebx
     b01:	5d                   	pop    %ebp
     b02:	c3                   	ret    
     b03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b10 <gets>:

char*
gets(char *buf, int max)
{
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	57                   	push   %edi
     b14:	56                   	push   %esi
     b15:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b16:	31 f6                	xor    %esi,%esi
     b18:	89 f3                	mov    %esi,%ebx
{
     b1a:	83 ec 1c             	sub    $0x1c,%esp
     b1d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     b20:	eb 2f                	jmp    b51 <gets+0x41>
     b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     b28:	8d 45 e7             	lea    -0x19(%ebp),%eax
     b2b:	83 ec 04             	sub    $0x4,%esp
     b2e:	6a 01                	push   $0x1
     b30:	50                   	push   %eax
     b31:	6a 00                	push   $0x0
     b33:	e8 32 01 00 00       	call   c6a <read>
    if(cc < 1)
     b38:	83 c4 10             	add    $0x10,%esp
     b3b:	85 c0                	test   %eax,%eax
     b3d:	7e 1c                	jle    b5b <gets+0x4b>
      break;
    buf[i++] = c;
     b3f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     b43:	83 c7 01             	add    $0x1,%edi
     b46:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     b49:	3c 0a                	cmp    $0xa,%al
     b4b:	74 23                	je     b70 <gets+0x60>
     b4d:	3c 0d                	cmp    $0xd,%al
     b4f:	74 1f                	je     b70 <gets+0x60>
  for(i=0; i+1 < max; ){
     b51:	83 c3 01             	add    $0x1,%ebx
     b54:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     b57:	89 fe                	mov    %edi,%esi
     b59:	7c cd                	jl     b28 <gets+0x18>
     b5b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     b60:	c6 03 00             	movb   $0x0,(%ebx)
}
     b63:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b66:	5b                   	pop    %ebx
     b67:	5e                   	pop    %esi
     b68:	5f                   	pop    %edi
     b69:	5d                   	pop    %ebp
     b6a:	c3                   	ret    
     b6b:	90                   	nop
     b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b70:	8b 75 08             	mov    0x8(%ebp),%esi
     b73:	8b 45 08             	mov    0x8(%ebp),%eax
     b76:	01 de                	add    %ebx,%esi
     b78:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     b7a:	c6 03 00             	movb   $0x0,(%ebx)
}
     b7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b80:	5b                   	pop    %ebx
     b81:	5e                   	pop    %esi
     b82:	5f                   	pop    %edi
     b83:	5d                   	pop    %ebp
     b84:	c3                   	ret    
     b85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b90 <stat>:

int
stat(const char *n, struct stat *st)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	56                   	push   %esi
     b94:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     b95:	83 ec 08             	sub    $0x8,%esp
     b98:	6a 00                	push   $0x0
     b9a:	ff 75 08             	pushl  0x8(%ebp)
     b9d:	e8 f0 00 00 00       	call   c92 <open>
  if(fd < 0)
     ba2:	83 c4 10             	add    $0x10,%esp
     ba5:	85 c0                	test   %eax,%eax
     ba7:	78 27                	js     bd0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     ba9:	83 ec 08             	sub    $0x8,%esp
     bac:	ff 75 0c             	pushl  0xc(%ebp)
     baf:	89 c3                	mov    %eax,%ebx
     bb1:	50                   	push   %eax
     bb2:	e8 f3 00 00 00       	call   caa <fstat>
  close(fd);
     bb7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     bba:	89 c6                	mov    %eax,%esi
  close(fd);
     bbc:	e8 b9 00 00 00       	call   c7a <close>
  return r;
     bc1:	83 c4 10             	add    $0x10,%esp
}
     bc4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     bc7:	89 f0                	mov    %esi,%eax
     bc9:	5b                   	pop    %ebx
     bca:	5e                   	pop    %esi
     bcb:	5d                   	pop    %ebp
     bcc:	c3                   	ret    
     bcd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     bd0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     bd5:	eb ed                	jmp    bc4 <stat+0x34>
     bd7:	89 f6                	mov    %esi,%esi
     bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000be0 <atoi>:

int
atoi(const char *s)
{
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	53                   	push   %ebx
     be4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     be7:	0f be 11             	movsbl (%ecx),%edx
     bea:	8d 42 d0             	lea    -0x30(%edx),%eax
     bed:	3c 09                	cmp    $0x9,%al
  n = 0;
     bef:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     bf4:	77 1f                	ja     c15 <atoi+0x35>
     bf6:	8d 76 00             	lea    0x0(%esi),%esi
     bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     c00:	8d 04 80             	lea    (%eax,%eax,4),%eax
     c03:	83 c1 01             	add    $0x1,%ecx
     c06:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     c0a:	0f be 11             	movsbl (%ecx),%edx
     c0d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     c10:	80 fb 09             	cmp    $0x9,%bl
     c13:	76 eb                	jbe    c00 <atoi+0x20>
  return n;
}
     c15:	5b                   	pop    %ebx
     c16:	5d                   	pop    %ebp
     c17:	c3                   	ret    
     c18:	90                   	nop
     c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c20 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	56                   	push   %esi
     c24:	53                   	push   %ebx
     c25:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c28:	8b 45 08             	mov    0x8(%ebp),%eax
     c2b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     c2e:	85 db                	test   %ebx,%ebx
     c30:	7e 14                	jle    c46 <memmove+0x26>
     c32:	31 d2                	xor    %edx,%edx
     c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     c38:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     c3c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     c3f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     c42:	39 d3                	cmp    %edx,%ebx
     c44:	75 f2                	jne    c38 <memmove+0x18>
  return vdst;
}
     c46:	5b                   	pop    %ebx
     c47:	5e                   	pop    %esi
     c48:	5d                   	pop    %ebp
     c49:	c3                   	ret    

00000c4a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     c4a:	b8 01 00 00 00       	mov    $0x1,%eax
     c4f:	cd 40                	int    $0x40
     c51:	c3                   	ret    

00000c52 <exit>:
SYSCALL(exit)
     c52:	b8 02 00 00 00       	mov    $0x2,%eax
     c57:	cd 40                	int    $0x40
     c59:	c3                   	ret    

00000c5a <wait>:
SYSCALL(wait)
     c5a:	b8 03 00 00 00       	mov    $0x3,%eax
     c5f:	cd 40                	int    $0x40
     c61:	c3                   	ret    

00000c62 <pipe>:
SYSCALL(pipe)
     c62:	b8 04 00 00 00       	mov    $0x4,%eax
     c67:	cd 40                	int    $0x40
     c69:	c3                   	ret    

00000c6a <read>:
SYSCALL(read)
     c6a:	b8 05 00 00 00       	mov    $0x5,%eax
     c6f:	cd 40                	int    $0x40
     c71:	c3                   	ret    

00000c72 <write>:
SYSCALL(write)
     c72:	b8 10 00 00 00       	mov    $0x10,%eax
     c77:	cd 40                	int    $0x40
     c79:	c3                   	ret    

00000c7a <close>:
SYSCALL(close)
     c7a:	b8 15 00 00 00       	mov    $0x15,%eax
     c7f:	cd 40                	int    $0x40
     c81:	c3                   	ret    

00000c82 <kill>:
SYSCALL(kill)
     c82:	b8 06 00 00 00       	mov    $0x6,%eax
     c87:	cd 40                	int    $0x40
     c89:	c3                   	ret    

00000c8a <exec>:
SYSCALL(exec)
     c8a:	b8 07 00 00 00       	mov    $0x7,%eax
     c8f:	cd 40                	int    $0x40
     c91:	c3                   	ret    

00000c92 <open>:
SYSCALL(open)
     c92:	b8 0f 00 00 00       	mov    $0xf,%eax
     c97:	cd 40                	int    $0x40
     c99:	c3                   	ret    

00000c9a <mknod>:
SYSCALL(mknod)
     c9a:	b8 11 00 00 00       	mov    $0x11,%eax
     c9f:	cd 40                	int    $0x40
     ca1:	c3                   	ret    

00000ca2 <unlink>:
SYSCALL(unlink)
     ca2:	b8 12 00 00 00       	mov    $0x12,%eax
     ca7:	cd 40                	int    $0x40
     ca9:	c3                   	ret    

00000caa <fstat>:
SYSCALL(fstat)
     caa:	b8 08 00 00 00       	mov    $0x8,%eax
     caf:	cd 40                	int    $0x40
     cb1:	c3                   	ret    

00000cb2 <link>:
SYSCALL(link)
     cb2:	b8 13 00 00 00       	mov    $0x13,%eax
     cb7:	cd 40                	int    $0x40
     cb9:	c3                   	ret    

00000cba <mkdir>:
SYSCALL(mkdir)
     cba:	b8 14 00 00 00       	mov    $0x14,%eax
     cbf:	cd 40                	int    $0x40
     cc1:	c3                   	ret    

00000cc2 <chdir>:
SYSCALL(chdir)
     cc2:	b8 09 00 00 00       	mov    $0x9,%eax
     cc7:	cd 40                	int    $0x40
     cc9:	c3                   	ret    

00000cca <dup>:
SYSCALL(dup)
     cca:	b8 0a 00 00 00       	mov    $0xa,%eax
     ccf:	cd 40                	int    $0x40
     cd1:	c3                   	ret    

00000cd2 <getpid>:
SYSCALL(getpid)
     cd2:	b8 0b 00 00 00       	mov    $0xb,%eax
     cd7:	cd 40                	int    $0x40
     cd9:	c3                   	ret    

00000cda <sbrk>:
SYSCALL(sbrk)
     cda:	b8 0c 00 00 00       	mov    $0xc,%eax
     cdf:	cd 40                	int    $0x40
     ce1:	c3                   	ret    

00000ce2 <sleep>:
SYSCALL(sleep)
     ce2:	b8 0d 00 00 00       	mov    $0xd,%eax
     ce7:	cd 40                	int    $0x40
     ce9:	c3                   	ret    

00000cea <uptime>:
SYSCALL(uptime)
     cea:	b8 0e 00 00 00       	mov    $0xe,%eax
     cef:	cd 40                	int    $0x40
     cf1:	c3                   	ret    

00000cf2 <toggle>:
SYSCALL(toggle)
     cf2:	b8 16 00 00 00       	mov    $0x16,%eax
     cf7:	cd 40                	int    $0x40
     cf9:	c3                   	ret    

00000cfa <print_count>:
SYSCALL(print_count)
     cfa:	b8 17 00 00 00       	mov    $0x17,%eax
     cff:	cd 40                	int    $0x40
     d01:	c3                   	ret    

00000d02 <add>:
SYSCALL(add)
     d02:	b8 18 00 00 00       	mov    $0x18,%eax
     d07:	cd 40                	int    $0x40
     d09:	c3                   	ret    

00000d0a <ps>:
SYSCALL(ps)
     d0a:	b8 19 00 00 00       	mov    $0x19,%eax
     d0f:	cd 40                	int    $0x40
     d11:	c3                   	ret    

00000d12 <send>:
SYSCALL(send)
     d12:	b8 1a 00 00 00       	mov    $0x1a,%eax
     d17:	cd 40                	int    $0x40
     d19:	c3                   	ret    

00000d1a <recv>:
SYSCALL(recv)
     d1a:	b8 1b 00 00 00       	mov    $0x1b,%eax
     d1f:	cd 40                	int    $0x40
     d21:	c3                   	ret    

00000d22 <sigset>:
SYSCALL(sigset)
     d22:	b8 1c 00 00 00       	mov    $0x1c,%eax
     d27:	cd 40                	int    $0x40
     d29:	c3                   	ret    

00000d2a <sigsend>:
SYSCALL(sigsend)
     d2a:	b8 1d 00 00 00       	mov    $0x1d,%eax
     d2f:	cd 40                	int    $0x40
     d31:	c3                   	ret    

00000d32 <sigret>:
SYSCALL(sigret)
     d32:	b8 1e 00 00 00       	mov    $0x1e,%eax
     d37:	cd 40                	int    $0x40
     d39:	c3                   	ret    

00000d3a <sigpause>:
SYSCALL(sigpause)
     d3a:	b8 1f 00 00 00       	mov    $0x1f,%eax
     d3f:	cd 40                	int    $0x40
     d41:	c3                   	ret    

00000d42 <send_multi>:
SYSCALL(send_multi)
     d42:	b8 20 00 00 00       	mov    $0x20,%eax
     d47:	cd 40                	int    $0x40
     d49:	c3                   	ret    
     d4a:	66 90                	xchg   %ax,%ax
     d4c:	66 90                	xchg   %ax,%ax
     d4e:	66 90                	xchg   %ax,%ax

00000d50 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	57                   	push   %edi
     d54:	56                   	push   %esi
     d55:	53                   	push   %ebx
     d56:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d59:	85 d2                	test   %edx,%edx
{
     d5b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
     d5e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     d60:	79 76                	jns    dd8 <printint+0x88>
     d62:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     d66:	74 70                	je     dd8 <printint+0x88>
    x = -xx;
     d68:	f7 d8                	neg    %eax
    neg = 1;
     d6a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     d71:	31 f6                	xor    %esi,%esi
     d73:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     d76:	eb 0a                	jmp    d82 <printint+0x32>
     d78:	90                   	nop
     d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     d80:	89 fe                	mov    %edi,%esi
     d82:	31 d2                	xor    %edx,%edx
     d84:	8d 7e 01             	lea    0x1(%esi),%edi
     d87:	f7 f1                	div    %ecx
     d89:	0f b6 92 7c 11 00 00 	movzbl 0x117c(%edx),%edx
  }while((x /= base) != 0);
     d90:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     d92:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     d95:	75 e9                	jne    d80 <printint+0x30>
  if(neg)
     d97:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     d9a:	85 c0                	test   %eax,%eax
     d9c:	74 08                	je     da6 <printint+0x56>
    buf[i++] = '-';
     d9e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     da3:	8d 7e 02             	lea    0x2(%esi),%edi
     da6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     daa:	8b 7d c0             	mov    -0x40(%ebp),%edi
     dad:	8d 76 00             	lea    0x0(%esi),%esi
     db0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
     db3:	83 ec 04             	sub    $0x4,%esp
     db6:	83 ee 01             	sub    $0x1,%esi
     db9:	6a 01                	push   $0x1
     dbb:	53                   	push   %ebx
     dbc:	57                   	push   %edi
     dbd:	88 45 d7             	mov    %al,-0x29(%ebp)
     dc0:	e8 ad fe ff ff       	call   c72 <write>

  while(--i >= 0)
     dc5:	83 c4 10             	add    $0x10,%esp
     dc8:	39 de                	cmp    %ebx,%esi
     dca:	75 e4                	jne    db0 <printint+0x60>
    putc(fd, buf[i]);
}
     dcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dcf:	5b                   	pop    %ebx
     dd0:	5e                   	pop    %esi
     dd1:	5f                   	pop    %edi
     dd2:	5d                   	pop    %ebp
     dd3:	c3                   	ret    
     dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     dd8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     ddf:	eb 90                	jmp    d71 <printint+0x21>
     de1:	eb 0d                	jmp    df0 <printf>
     de3:	90                   	nop
     de4:	90                   	nop
     de5:	90                   	nop
     de6:	90                   	nop
     de7:	90                   	nop
     de8:	90                   	nop
     de9:	90                   	nop
     dea:	90                   	nop
     deb:	90                   	nop
     dec:	90                   	nop
     ded:	90                   	nop
     dee:	90                   	nop
     def:	90                   	nop

00000df0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
     df3:	57                   	push   %edi
     df4:	56                   	push   %esi
     df5:	53                   	push   %ebx
     df6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     df9:	8b 75 0c             	mov    0xc(%ebp),%esi
     dfc:	0f b6 1e             	movzbl (%esi),%ebx
     dff:	84 db                	test   %bl,%bl
     e01:	0f 84 b3 00 00 00    	je     eba <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
     e07:	8d 45 10             	lea    0x10(%ebp),%eax
     e0a:	83 c6 01             	add    $0x1,%esi
  state = 0;
     e0d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
     e0f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e12:	eb 2f                	jmp    e43 <printf+0x53>
     e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e18:	83 f8 25             	cmp    $0x25,%eax
     e1b:	0f 84 a7 00 00 00    	je     ec8 <printf+0xd8>
  write(fd, &c, 1);
     e21:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     e24:	83 ec 04             	sub    $0x4,%esp
     e27:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     e2a:	6a 01                	push   $0x1
     e2c:	50                   	push   %eax
     e2d:	ff 75 08             	pushl  0x8(%ebp)
     e30:	e8 3d fe ff ff       	call   c72 <write>
     e35:	83 c4 10             	add    $0x10,%esp
     e38:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     e3b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     e3f:	84 db                	test   %bl,%bl
     e41:	74 77                	je     eba <printf+0xca>
    if(state == 0){
     e43:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     e45:	0f be cb             	movsbl %bl,%ecx
     e48:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     e4b:	74 cb                	je     e18 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     e4d:	83 ff 25             	cmp    $0x25,%edi
     e50:	75 e6                	jne    e38 <printf+0x48>
      if(c == 'd'){
     e52:	83 f8 64             	cmp    $0x64,%eax
     e55:	0f 84 05 01 00 00    	je     f60 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     e5b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     e61:	83 f9 70             	cmp    $0x70,%ecx
     e64:	74 72                	je     ed8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     e66:	83 f8 73             	cmp    $0x73,%eax
     e69:	0f 84 99 00 00 00    	je     f08 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     e6f:	83 f8 63             	cmp    $0x63,%eax
     e72:	0f 84 08 01 00 00    	je     f80 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     e78:	83 f8 25             	cmp    $0x25,%eax
     e7b:	0f 84 ef 00 00 00    	je     f70 <printf+0x180>
  write(fd, &c, 1);
     e81:	8d 45 e7             	lea    -0x19(%ebp),%eax
     e84:	83 ec 04             	sub    $0x4,%esp
     e87:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     e8b:	6a 01                	push   $0x1
     e8d:	50                   	push   %eax
     e8e:	ff 75 08             	pushl  0x8(%ebp)
     e91:	e8 dc fd ff ff       	call   c72 <write>
     e96:	83 c4 0c             	add    $0xc,%esp
     e99:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     e9c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     e9f:	6a 01                	push   $0x1
     ea1:	50                   	push   %eax
     ea2:	ff 75 08             	pushl  0x8(%ebp)
     ea5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     ea8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     eaa:	e8 c3 fd ff ff       	call   c72 <write>
  for(i = 0; fmt[i]; i++){
     eaf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     eb3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     eb6:	84 db                	test   %bl,%bl
     eb8:	75 89                	jne    e43 <printf+0x53>
    }
  }
}
     eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ebd:	5b                   	pop    %ebx
     ebe:	5e                   	pop    %esi
     ebf:	5f                   	pop    %edi
     ec0:	5d                   	pop    %ebp
     ec1:	c3                   	ret    
     ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
     ec8:	bf 25 00 00 00       	mov    $0x25,%edi
     ecd:	e9 66 ff ff ff       	jmp    e38 <printf+0x48>
     ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     ed8:	83 ec 0c             	sub    $0xc,%esp
     edb:	b9 10 00 00 00       	mov    $0x10,%ecx
     ee0:	6a 00                	push   $0x0
     ee2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     ee5:	8b 45 08             	mov    0x8(%ebp),%eax
     ee8:	8b 17                	mov    (%edi),%edx
     eea:	e8 61 fe ff ff       	call   d50 <printint>
        ap++;
     eef:	89 f8                	mov    %edi,%eax
     ef1:	83 c4 10             	add    $0x10,%esp
      state = 0;
     ef4:	31 ff                	xor    %edi,%edi
        ap++;
     ef6:	83 c0 04             	add    $0x4,%eax
     ef9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     efc:	e9 37 ff ff ff       	jmp    e38 <printf+0x48>
     f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     f08:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f0b:	8b 08                	mov    (%eax),%ecx
        ap++;
     f0d:	83 c0 04             	add    $0x4,%eax
     f10:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
     f13:	85 c9                	test   %ecx,%ecx
     f15:	0f 84 8e 00 00 00    	je     fa9 <printf+0x1b9>
        while(*s != 0){
     f1b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
     f1e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
     f20:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
     f22:	84 c0                	test   %al,%al
     f24:	0f 84 0e ff ff ff    	je     e38 <printf+0x48>
     f2a:	89 75 d0             	mov    %esi,-0x30(%ebp)
     f2d:	89 de                	mov    %ebx,%esi
     f2f:	8b 5d 08             	mov    0x8(%ebp),%ebx
     f32:	8d 7d e3             	lea    -0x1d(%ebp),%edi
     f35:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
     f38:	83 ec 04             	sub    $0x4,%esp
          s++;
     f3b:	83 c6 01             	add    $0x1,%esi
     f3e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     f41:	6a 01                	push   $0x1
     f43:	57                   	push   %edi
     f44:	53                   	push   %ebx
     f45:	e8 28 fd ff ff       	call   c72 <write>
        while(*s != 0){
     f4a:	0f b6 06             	movzbl (%esi),%eax
     f4d:	83 c4 10             	add    $0x10,%esp
     f50:	84 c0                	test   %al,%al
     f52:	75 e4                	jne    f38 <printf+0x148>
     f54:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
     f57:	31 ff                	xor    %edi,%edi
     f59:	e9 da fe ff ff       	jmp    e38 <printf+0x48>
     f5e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
     f60:	83 ec 0c             	sub    $0xc,%esp
     f63:	b9 0a 00 00 00       	mov    $0xa,%ecx
     f68:	6a 01                	push   $0x1
     f6a:	e9 73 ff ff ff       	jmp    ee2 <printf+0xf2>
     f6f:	90                   	nop
  write(fd, &c, 1);
     f70:	83 ec 04             	sub    $0x4,%esp
     f73:	88 5d e5             	mov    %bl,-0x1b(%ebp)
     f76:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     f79:	6a 01                	push   $0x1
     f7b:	e9 21 ff ff ff       	jmp    ea1 <printf+0xb1>
        putc(fd, *ap);
     f80:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
     f83:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
     f86:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
     f88:	6a 01                	push   $0x1
        ap++;
     f8a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
     f8d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
     f90:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     f93:	50                   	push   %eax
     f94:	ff 75 08             	pushl  0x8(%ebp)
     f97:	e8 d6 fc ff ff       	call   c72 <write>
        ap++;
     f9c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     f9f:	83 c4 10             	add    $0x10,%esp
      state = 0;
     fa2:	31 ff                	xor    %edi,%edi
     fa4:	e9 8f fe ff ff       	jmp    e38 <printf+0x48>
          s = "(null)";
     fa9:	bb 74 11 00 00       	mov    $0x1174,%ebx
        while(*s != 0){
     fae:	b8 28 00 00 00       	mov    $0x28,%eax
     fb3:	e9 72 ff ff ff       	jmp    f2a <printf+0x13a>
     fb8:	66 90                	xchg   %ax,%ax
     fba:	66 90                	xchg   %ax,%ax
     fbc:	66 90                	xchg   %ax,%ax
     fbe:	66 90                	xchg   %ax,%ax

00000fc0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fc0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fc1:	a1 80 14 00 00       	mov    0x1480,%eax
{
     fc6:	89 e5                	mov    %esp,%ebp
     fc8:	57                   	push   %edi
     fc9:	56                   	push   %esi
     fca:	53                   	push   %ebx
     fcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
     fce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
     fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fd8:	39 c8                	cmp    %ecx,%eax
     fda:	8b 10                	mov    (%eax),%edx
     fdc:	73 32                	jae    1010 <free+0x50>
     fde:	39 d1                	cmp    %edx,%ecx
     fe0:	72 04                	jb     fe6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fe2:	39 d0                	cmp    %edx,%eax
     fe4:	72 32                	jb     1018 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
     fe6:	8b 73 fc             	mov    -0x4(%ebx),%esi
     fe9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     fec:	39 fa                	cmp    %edi,%edx
     fee:	74 30                	je     1020 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     ff0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     ff3:	8b 50 04             	mov    0x4(%eax),%edx
     ff6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     ff9:	39 f1                	cmp    %esi,%ecx
     ffb:	74 3a                	je     1037 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
     ffd:	89 08                	mov    %ecx,(%eax)
  freep = p;
     fff:	a3 80 14 00 00       	mov    %eax,0x1480
}
    1004:	5b                   	pop    %ebx
    1005:	5e                   	pop    %esi
    1006:	5f                   	pop    %edi
    1007:	5d                   	pop    %ebp
    1008:	c3                   	ret    
    1009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1010:	39 d0                	cmp    %edx,%eax
    1012:	72 04                	jb     1018 <free+0x58>
    1014:	39 d1                	cmp    %edx,%ecx
    1016:	72 ce                	jb     fe6 <free+0x26>
{
    1018:	89 d0                	mov    %edx,%eax
    101a:	eb bc                	jmp    fd8 <free+0x18>
    101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1020:	03 72 04             	add    0x4(%edx),%esi
    1023:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1026:	8b 10                	mov    (%eax),%edx
    1028:	8b 12                	mov    (%edx),%edx
    102a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    102d:	8b 50 04             	mov    0x4(%eax),%edx
    1030:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1033:	39 f1                	cmp    %esi,%ecx
    1035:	75 c6                	jne    ffd <free+0x3d>
    p->s.size += bp->s.size;
    1037:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    103a:	a3 80 14 00 00       	mov    %eax,0x1480
    p->s.size += bp->s.size;
    103f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1042:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1045:	89 10                	mov    %edx,(%eax)
}
    1047:	5b                   	pop    %ebx
    1048:	5e                   	pop    %esi
    1049:	5f                   	pop    %edi
    104a:	5d                   	pop    %ebp
    104b:	c3                   	ret    
    104c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001050 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	57                   	push   %edi
    1054:	56                   	push   %esi
    1055:	53                   	push   %ebx
    1056:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1059:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    105c:	8b 15 80 14 00 00    	mov    0x1480,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1062:	8d 78 07             	lea    0x7(%eax),%edi
    1065:	c1 ef 03             	shr    $0x3,%edi
    1068:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    106b:	85 d2                	test   %edx,%edx
    106d:	0f 84 9d 00 00 00    	je     1110 <malloc+0xc0>
    1073:	8b 02                	mov    (%edx),%eax
    1075:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1078:	39 cf                	cmp    %ecx,%edi
    107a:	76 6c                	jbe    10e8 <malloc+0x98>
    107c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1082:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1087:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    108a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1091:	eb 0e                	jmp    10a1 <malloc+0x51>
    1093:	90                   	nop
    1094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1098:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    109a:	8b 48 04             	mov    0x4(%eax),%ecx
    109d:	39 f9                	cmp    %edi,%ecx
    109f:	73 47                	jae    10e8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    10a1:	39 05 80 14 00 00    	cmp    %eax,0x1480
    10a7:	89 c2                	mov    %eax,%edx
    10a9:	75 ed                	jne    1098 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    10ab:	83 ec 0c             	sub    $0xc,%esp
    10ae:	56                   	push   %esi
    10af:	e8 26 fc ff ff       	call   cda <sbrk>
  if(p == (char*)-1)
    10b4:	83 c4 10             	add    $0x10,%esp
    10b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    10ba:	74 1c                	je     10d8 <malloc+0x88>
  hp->s.size = nu;
    10bc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    10bf:	83 ec 0c             	sub    $0xc,%esp
    10c2:	83 c0 08             	add    $0x8,%eax
    10c5:	50                   	push   %eax
    10c6:	e8 f5 fe ff ff       	call   fc0 <free>
  return freep;
    10cb:	8b 15 80 14 00 00    	mov    0x1480,%edx
      if((p = morecore(nunits)) == 0)
    10d1:	83 c4 10             	add    $0x10,%esp
    10d4:	85 d2                	test   %edx,%edx
    10d6:	75 c0                	jne    1098 <malloc+0x48>
        return 0;
  }
}
    10d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    10db:	31 c0                	xor    %eax,%eax
}
    10dd:	5b                   	pop    %ebx
    10de:	5e                   	pop    %esi
    10df:	5f                   	pop    %edi
    10e0:	5d                   	pop    %ebp
    10e1:	c3                   	ret    
    10e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    10e8:	39 cf                	cmp    %ecx,%edi
    10ea:	74 54                	je     1140 <malloc+0xf0>
        p->s.size -= nunits;
    10ec:	29 f9                	sub    %edi,%ecx
    10ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    10f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    10f4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    10f7:	89 15 80 14 00 00    	mov    %edx,0x1480
}
    10fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1100:	83 c0 08             	add    $0x8,%eax
}
    1103:	5b                   	pop    %ebx
    1104:	5e                   	pop    %esi
    1105:	5f                   	pop    %edi
    1106:	5d                   	pop    %ebp
    1107:	c3                   	ret    
    1108:	90                   	nop
    1109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1110:	c7 05 80 14 00 00 84 	movl   $0x1484,0x1480
    1117:	14 00 00 
    111a:	c7 05 84 14 00 00 84 	movl   $0x1484,0x1484
    1121:	14 00 00 
    base.s.size = 0;
    1124:	b8 84 14 00 00       	mov    $0x1484,%eax
    1129:	c7 05 88 14 00 00 00 	movl   $0x0,0x1488
    1130:	00 00 00 
    1133:	e9 44 ff ff ff       	jmp    107c <malloc+0x2c>
    1138:	90                   	nop
    1139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1140:	8b 08                	mov    (%eax),%ecx
    1142:	89 0a                	mov    %ecx,(%edx)
    1144:	eb b1                	jmp    10f7 <malloc+0xa7>
