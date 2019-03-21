
_maekawa:     file format elf32-i386


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
      11:	81 ec 18 01 00 00    	sub    $0x118,%esp
    ppid=getpid();
      17:	e8 26 12 00 00       	call   1242 <getpid>
      1c:	a3 80 1b 00 00       	mov    %eax,0x1b80
    for(i=1;i<=n;i++)
      21:	b8 01 00 00 00       	mov    $0x1,%eax
      26:	8d 76 00             	lea    0x0(%esi),%esi
      29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      30:	83 c0 01             	add    $0x1,%eax
      33:	83 f8 1a             	cmp    $0x1a,%eax
      36:	74 0a                	je     42 <main+0x42>
        if(i*i==n)
      38:	89 c2                	mov    %eax,%edx
      3a:	0f af d0             	imul   %eax,%edx
      3d:	83 fa 19             	cmp    $0x19,%edx
      40:	75 ee                	jne    30 <main+0x30>
      42:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
    for(i=1;i<=n;i++)
      48:	31 db                	xor    %ebx,%ebx
      4a:	eb 17                	jmp    63 <main+0x63>
      4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                releaselock(peers,num_peers,waitingQ,size,t,pid);
            }
        }
        else
        {
            process_ids[k]=child;
      50:	89 84 9d 0c ff ff ff 	mov    %eax,-0xf4(%ebp,%ebx,4)
    for(int k=0;k<P;k++)
      57:	83 c3 01             	add    $0x1,%ebx
      5a:	83 fb 19             	cmp    $0x19,%ebx
      5d:	0f 84 80 01 00 00    	je     1e3 <main+0x1e3>
        int child=fork();
      63:	e8 52 11 00 00       	call   11ba <fork>
        if(child==0)
      68:	85 c0                	test   %eax,%eax
      6a:	75 e4                	jne    50 <main+0x50>
      6c:	89 c6                	mov    %eax,%esi
      6e:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
      74:	8d 55 e8             	lea    -0x18(%ebp),%edx
      77:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
      7d:	8d 76 00             	lea    0x0(%esi),%esi
                waitingQ[i]=0;
      80:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
      86:	83 c0 04             	add    $0x4,%eax
            for(int i=0;i<30;i++)
      89:	39 c2                	cmp    %eax,%edx
      8b:	75 f3                	jne    80 <main+0x80>
            int num_peers=2*root_P-1;
      8d:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
            int size=0;
      93:	c7 85 fc fe ff ff 00 	movl   $0x0,-0x104(%ebp)
      9a:	00 00 00 
            int t=0;
      9d:	c7 85 00 ff ff ff 00 	movl   $0x0,-0x100(%ebp)
      a4:	00 00 00 
            int num_peers=2*root_P-1;
      a7:	01 ff                	add    %edi,%edi
      a9:	83 ef 01             	sub    $0x1,%edi
            int peers[num_peers];
      ac:	8d 04 bd 12 00 00 00 	lea    0x12(,%edi,4),%eax
      b3:	83 e0 f0             	and    $0xfffffff0,%eax
      b6:	29 c4                	sub    %eax,%esp
      b8:	89 a5 f0 fe ff ff    	mov    %esp,-0x110(%ebp)
            int pid=getpid();
      be:	e8 7f 11 00 00       	call   1242 <getpid>
      c3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
      c9:	eb 26                	jmp    f1 <main+0xf1>
      cb:	90                   	nop
      cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                        waitingQ[t++]=peerid.senderid;
      d0:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
                        size++;
      d6:	83 85 fc fe ff ff 01 	addl   $0x1,-0x104(%ebp)
                while(i<num_peers)
      dd:	39 fe                	cmp    %edi,%esi
                        waitingQ[t++]=peerid.senderid;
      df:	8d 4a 01             	lea    0x1(%edx),%ecx
      e2:	89 84 95 70 ff ff ff 	mov    %eax,-0x90(%ebp,%edx,4)
      e9:	89 8d 00 ff ff ff    	mov    %ecx,-0x100(%ebp)
                while(i<num_peers)
      ef:	7d 36                	jge    127 <main+0x127>
                    recv((void*)&peerid);
      f1:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
      f7:	83 ec 0c             	sub    $0xc,%esp
      fa:	50                   	push   %eax
      fb:	e8 8a 11 00 00       	call   128a <recv>
                    if(peerid.senderid==ppid)
     100:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
     106:	83 c4 10             	add    $0x10,%esp
     109:	3b 05 80 1b 00 00    	cmp    0x1b80,%eax
     10f:	75 bf                	jne    d0 <main+0xd0>
                        peers[i]=peerid.val;
     111:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
     117:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
     11d:	89 04 b1             	mov    %eax,(%ecx,%esi,4)
                        i++;
     120:	83 c6 01             	add    $0x1,%esi
                while(i<num_peers)
     123:	39 fe                	cmp    %edi,%esi
     125:	7c ca                	jl     f1 <main+0xf1>
            else if(k>=P1&&k<P1+P2)
     127:	83 fb 0b             	cmp    $0xb,%ebx
     12a:	7e 72                	jle    19e <main+0x19e>
                acquirelock(peers,num_peers,waitingQ,&size,&t,pid);
     12c:	8b 9d ec fe ff ff    	mov    -0x114(%ebp),%ebx
     132:	8d 85 00 ff ff ff    	lea    -0x100(%ebp),%eax
     138:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
     13e:	51                   	push   %ecx
     13f:	51                   	push   %ecx
     140:	53                   	push   %ebx
     141:	50                   	push   %eax
     142:	8d 85 fc fe ff ff    	lea    -0x104(%ebp),%eax
     148:	50                   	push   %eax
     149:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
     14f:	57                   	push   %edi
     150:	56                   	push   %esi
     151:	e8 ca 02 00 00       	call   420 <acquirelock>
                printf(1,"lock acquired by category 3 process with id=%d\n",pid);
     156:	83 c4 1c             	add    $0x1c,%esp
     159:	53                   	push   %ebx
     15a:	68 bc 17 00 00       	push   $0x17bc
     15f:	6a 01                	push   $0x1
     161:	e8 fa 11 00 00       	call   1360 <printf>
                sleep(2);
     166:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     16d:	e8 e0 10 00 00       	call   1252 <sleep>
                printf(1,"lock released by category 3 process with id=%d\n",pid);
     172:	83 c4 0c             	add    $0xc,%esp
     175:	53                   	push   %ebx
     176:	68 ec 17 00 00       	push   $0x17ec
     17b:	6a 01                	push   $0x1
     17d:	e8 de 11 00 00       	call   1360 <printf>
                releaselock(peers,num_peers,waitingQ,size,t,pid);
     182:	58                   	pop    %eax
     183:	5a                   	pop    %edx
     184:	53                   	push   %ebx
     185:	ff b5 00 ff ff ff    	pushl  -0x100(%ebp)
     18b:	ff b5 fc fe ff ff    	pushl  -0x104(%ebp)
     191:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
     197:	57                   	push   %edi
     198:	56                   	push   %esi
     199:	e8 22 0a 00 00       	call   bc0 <releaselock>
                acquirelock(peers,num_peers,waitingQ, &size,&t,pid);
     19e:	53                   	push   %ebx
     19f:	53                   	push   %ebx
     1a0:	8d 85 00 ff ff ff    	lea    -0x100(%ebp),%eax
     1a6:	8b 9d ec fe ff ff    	mov    -0x114(%ebp),%ebx
     1ac:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
     1b2:	53                   	push   %ebx
     1b3:	50                   	push   %eax
     1b4:	8d 85 fc fe ff ff    	lea    -0x104(%ebp),%eax
     1ba:	50                   	push   %eax
     1bb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
     1c1:	57                   	push   %edi
     1c2:	56                   	push   %esi
     1c3:	e8 58 02 00 00       	call   420 <acquirelock>
                printf(1,"lock acquired by category 2 process with id=%d\n",pid);
     1c8:	83 c4 1c             	add    $0x1c,%esp
     1cb:	53                   	push   %ebx
     1cc:	68 5c 17 00 00       	push   $0x175c
     1d1:	6a 01                	push   $0x1
     1d3:	e8 88 11 00 00       	call   1360 <printf>
                printf(1,"lock released by category 2 process with id=%d\n",pid);
     1d8:	83 c4 0c             	add    $0xc,%esp
     1db:	53                   	push   %ebx
     1dc:	68 8c 17 00 00       	push   $0x178c
     1e1:	eb 98                	jmp    17b <main+0x17b>
     1e3:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
        }
    }
    for(int i=P1;i<P;i++)
     1e9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
     1f0:	00 00 00 
     1f3:	c1 e0 02             	shl    $0x2,%eax
     1f6:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
     1fc:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
     202:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
     208:	90                   	nop
     209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     210:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
     216:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
    {
        int row_s=(i/root_P)*root_P;
        // printf(1,"peers of process %d\n",process_ids[i]);
        struct msg pmsg;
        pmsg.senderid=ppid;
     21c:	8b 0d 80 1b 00 00    	mov    0x1b80,%ecx
     222:	99                   	cltd   
     223:	f7 ff                	idiv   %edi
     225:	89 8d 70 ff ff ff    	mov    %ecx,-0x90(%ebp)
     22b:	89 95 e4 fe ff ff    	mov    %edx,-0x11c(%ebp)
     231:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
        int row_s=(i/root_P)*root_P;
     237:	0f af c7             	imul   %edi,%eax
     23a:	8b 9c 95 0c ff ff ff 	mov    -0xf4(%ebp,%edx,4),%ebx
     241:	89 c6                	mov    %eax,%esi
     243:	01 c7                	add    %eax,%edi
     245:	8d 76 00             	lea    0x0(%esi),%esi
        for(int j=0;j<root_P;j++)
        {
            pmsg.val=process_ids[row_s+j];
            if(row_s+j!=i)
     248:	3b b5 f0 fe ff ff    	cmp    -0x110(%ebp),%esi
            pmsg.val=process_ids[row_s+j];
     24e:	8b 84 b5 0c ff ff ff 	mov    -0xf4(%ebp,%esi,4),%eax
     255:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
            if(row_s+j!=i)
     25b:	74 19                	je     276 <main+0x276>
            {
                send(ppid,process_ids[i], (void*)&pmsg);
     25d:	83 ec 04             	sub    $0x4,%esp
     260:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
     266:	53                   	push   %ebx
     267:	51                   	push   %ecx
     268:	e8 15 10 00 00       	call   1282 <send>
     26d:	8b 0d 80 1b 00 00    	mov    0x1b80,%ecx
     273:	83 c4 10             	add    $0x10,%esp
     276:	83 c6 01             	add    $0x1,%esi
        for(int j=0;j<root_P;j++)
     279:	39 fe                	cmp    %edi,%esi
     27b:	75 cb                	jne    248 <main+0x248>
     27d:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
                // printf(1,"peer_id=%d\n",pmsg.val);
            }
        }
        int col_s=(i%root_P);
        for(int j=0;j<root_P;j++)
     283:	31 ff                	xor    %edi,%edi
     285:	8d b4 85 0c ff ff ff 	lea    -0xf4(%ebp,%eax,4),%esi
     28c:	89 c8                	mov    %ecx,%eax
     28e:	eb 05                	jmp    295 <main+0x295>
     290:	a1 80 1b 00 00       	mov    0x1b80,%eax
        {
            pmsg.val=process_ids[col_s+j*root_P];
     295:	8b 16                	mov    (%esi),%edx
            send(ppid,process_ids[i], (void*)&pmsg);
     297:	83 ec 04             	sub    $0x4,%esp
     29a:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
     2a0:	53                   	push   %ebx
     2a1:	50                   	push   %eax
        for(int j=0;j<root_P;j++)
     2a2:	83 c7 01             	add    $0x1,%edi
            pmsg.val=process_ids[col_s+j*root_P];
     2a5:	89 95 74 ff ff ff    	mov    %edx,-0x8c(%ebp)
            send(ppid,process_ids[i], (void*)&pmsg);
     2ab:	e8 d2 0f 00 00       	call   1282 <send>
     2b0:	03 b5 e8 fe ff ff    	add    -0x118(%ebp),%esi
        for(int j=0;j<root_P;j++)
     2b6:	83 c4 10             	add    $0x10,%esp
     2b9:	3b bd ec fe ff ff    	cmp    -0x114(%ebp),%edi
     2bf:	75 cf                	jne    290 <main+0x290>
    for(int i=P1;i<P;i++)
     2c1:	83 85 f0 fe ff ff 01 	addl   $0x1,-0x110(%ebp)
     2c8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
     2ce:	83 f8 19             	cmp    $0x19,%eax
     2d1:	0f 85 39 ff ff ff    	jne    210 <main+0x210>
     2d7:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
     2dd:	bb 19 00 00 00       	mov    $0x19,%ebx
     2e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        }
    }
    for(int i=0;i<P2+P3;i++)
    {
        struct msg message;
        recv((void*)&message);
     2e8:	83 ec 0c             	sub    $0xc,%esp
     2eb:	56                   	push   %esi
     2ec:	e8 99 0f 00 00       	call   128a <recv>
    for(int i=0;i<P2+P3;i++)
     2f1:	83 c4 10             	add    $0x10,%esp
     2f4:	83 eb 01             	sub    $0x1,%ebx
     2f7:	75 ef                	jne    2e8 <main+0x2e8>
    }
    // printf(1,"ppid=%d\n",ppid);
    struct msg message;
    message.senderid=ppid;
     2f9:	a1 80 1b 00 00       	mov    0x1b80,%eax
     2fe:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
     304:	8d 9d 0c ff ff ff    	lea    -0xf4(%ebp),%ebx
    message.val=0;
     30a:	c7 85 74 ff ff ff 00 	movl   $0x0,-0x8c(%ebp)
     311:	00 00 00 
    message.senderid=ppid;
     314:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
     31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(int i=0;i<P;i++)
        send(ppid,process_ids[i],(void*)&message);
     320:	83 ec 04             	sub    $0x4,%esp
     323:	83 c3 04             	add    $0x4,%ebx
     326:	56                   	push   %esi
     327:	ff 73 fc             	pushl  -0x4(%ebx)
     32a:	ff 35 80 1b 00 00    	pushl  0x1b80
     330:	e8 4d 0f 00 00       	call   1282 <send>
    for(int i=0;i<P;i++)
     335:	83 c4 10             	add    $0x10,%esp
     338:	39 de                	cmp    %ebx,%esi
     33a:	75 e4                	jne    320 <main+0x320>
     33c:	bb 19 00 00 00       	mov    $0x19,%ebx
     341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(int i=0;i<P;i++)
    {
        wait();
     348:	e8 7d 0e 00 00       	call   11ca <wait>
    for(int i=0;i<P;i++)
     34d:	83 eb 01             	sub    $0x1,%ebx
     350:	75 f6                	jne    348 <main+0x348>
    }
    exit();
     352:	e8 6b 0e 00 00       	call   11c2 <exit>
     357:	66 90                	xchg   %ax,%ax
     359:	66 90                	xchg   %ax,%ax
     35b:	66 90                	xchg   %ax,%ax
     35d:	66 90                	xchg   %ax,%ax
     35f:	90                   	nop

00000360 <deque_min>:
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	57                   	push   %edi
     364:	56                   	push   %esi
     365:	53                   	push   %ebx
     366:	83 ec 1c             	sub    $0x1c,%esp
    int size=*sizeadd;
     369:	8b 45 0c             	mov    0xc(%ebp),%eax
{
     36c:	8b 75 08             	mov    0x8(%ebp),%esi
    int size=*sizeadd;
     36f:	8b 38                	mov    (%eax),%edi
    if(size==0)
     371:	85 ff                	test   %edi,%edi
     373:	74 5b                	je     3d0 <deque_min+0x70>
    for(int i=0;i<30;i++)
     375:	31 d2                	xor    %edx,%edx
    int idx=0;
     377:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    int min_id=10000;
     37e:	b8 10 27 00 00       	mov    $0x2710,%eax
    int count=0;
     383:	31 db                	xor    %ebx,%ebx
     385:	eb 11                	jmp    398 <deque_min+0x38>
     387:	89 f6                	mov    %esi,%esi
     389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(int i=0;i<30;i++)
     390:	83 c2 01             	add    $0x1,%edx
     393:	83 fa 1e             	cmp    $0x1e,%edx
     396:	74 17                	je     3af <deque_min+0x4f>
        if(waitingQ[i]!=0)
     398:	8b 0c 96             	mov    (%esi,%edx,4),%ecx
     39b:	85 c9                	test   %ecx,%ecx
     39d:	74 f1                	je     390 <deque_min+0x30>
            count++;
     39f:	83 c3 01             	add    $0x1,%ebx
            if(waitingQ[i]<min_id)
     3a2:	39 c1                	cmp    %eax,%ecx
     3a4:	7d 05                	jge    3ab <deque_min+0x4b>
     3a6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     3a9:	89 c8                	mov    %ecx,%eax
            if(count==size)
     3ab:	39 df                	cmp    %ebx,%edi
     3ad:	75 e1                	jne    390 <deque_min+0x30>
    waitingQ[idx]=0;
     3af:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    size--;
     3b2:	83 ef 01             	sub    $0x1,%edi
    waitingQ[idx]=0;
     3b5:	c7 04 9e 00 00 00 00 	movl   $0x0,(%esi,%ebx,4)
    size--;
     3bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     3bf:	89 3b                	mov    %edi,(%ebx)
}
     3c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     3c4:	5b                   	pop    %ebx
     3c5:	5e                   	pop    %esi
     3c6:	5f                   	pop    %edi
     3c7:	5d                   	pop    %ebp
     3c8:	c3                   	ret    
     3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"waitingQ size is zero\n");
     3d0:	83 ec 08             	sub    $0x8,%esp
     3d3:	68 b8 16 00 00       	push   $0x16b8
     3d8:	6a 01                	push   $0x1
     3da:	e8 81 0f 00 00       	call   1360 <printf>
     3df:	83 c4 10             	add    $0x10,%esp
     3e2:	eb 91                	jmp    375 <deque_min+0x15>
     3e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003f0 <sqrt>:
{
     3f0:	55                   	push   %ebp
    for(i=1;i<=n;i++)
     3f1:	b8 01 00 00 00       	mov    $0x1,%eax
{
     3f6:	89 e5                	mov    %esp,%ebp
     3f8:	8b 55 08             	mov    0x8(%ebp),%edx
    for(i=1;i<=n;i++)
     3fb:	83 fa 01             	cmp    $0x1,%edx
     3fe:	7f 11                	jg     411 <sqrt+0x21>
     400:	eb 16                	jmp    418 <sqrt+0x28>
     402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if(i*i==n)
     408:	89 c1                	mov    %eax,%ecx
     40a:	0f af c8             	imul   %eax,%ecx
     40d:	39 d1                	cmp    %edx,%ecx
     40f:	74 07                	je     418 <sqrt+0x28>
    for(i=1;i<=n;i++)
     411:	83 c0 01             	add    $0x1,%eax
     414:	39 c2                	cmp    %eax,%edx
     416:	7d f0                	jge    408 <sqrt+0x18>
}
     418:	5d                   	pop    %ebp
     419:	c3                   	ret    
     41a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000420 <acquirelock>:
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	57                   	push   %edi
     424:	56                   	push   %esi
     425:	53                   	push   %ebx
     426:	81 ec 4c 01 00 00    	sub    $0x14c,%esp
    int size=*sizeadd;
     42c:	8b 45 14             	mov    0x14(%ebp),%eax
     42f:	8b 00                	mov    (%eax),%eax
     431:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
     437:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
    int t=*tadd;
     43d:	8b 45 18             	mov    0x18(%ebp),%eax
     440:	8b 00                	mov    (%eax),%eax
     442:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
    for(int i=0;i<num_peers;i++)
     448:	8b 45 0c             	mov    0xc(%ebp),%eax
     44b:	85 c0                	test   %eax,%eax
     44d:	7e 57                	jle    4a6 <acquirelock+0x86>
     44f:	8b 7d 08             	mov    0x8(%ebp),%edi
     452:	8b 45 0c             	mov    0xc(%ebp),%eax
     455:	8d 9d 70 ff ff ff    	lea    -0x90(%ebp),%ebx
     45b:	8d 34 87             	lea    (%edi,%eax,4),%esi
     45e:	89 b5 d0 fe ff ff    	mov    %esi,-0x130(%ebp)
     464:	8b 75 1c             	mov    0x1c(%ebp),%esi
     467:	89 f6                	mov    %esi,%esi
     469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        send(pid,peers[i],(void*)&message3);
     470:	83 ec 04             	sub    $0x4,%esp
        message3.senderid=pid;
     473:	89 b5 70 ff ff ff    	mov    %esi,-0x90(%ebp)
        message3.val=REQUEST;
     479:	c7 85 74 ff ff ff 01 	movl   $0x1,-0x8c(%ebp)
     480:	00 00 00 
        send(pid,peers[i],(void*)&message3);
     483:	53                   	push   %ebx
     484:	ff 37                	pushl  (%edi)
     486:	83 c7 04             	add    $0x4,%edi
     489:	56                   	push   %esi
     48a:	e8 f3 0d 00 00       	call   1282 <send>
    for(int i=0;i<num_peers;i++)
     48f:	83 c4 10             	add    $0x10,%esp
     492:	3b bd d0 fe ff ff    	cmp    -0x130(%ebp),%edi
     498:	75 d6                	jne    470 <acquirelock+0x50>
     49a:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
     4a0:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
    if(size!=0)
     4a6:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
    int locked_by=0;
     4ac:	c7 85 c8 fe ff ff 00 	movl   $0x0,-0x138(%ebp)
     4b3:	00 00 00 
    if(size!=0)
     4b6:	85 c0                	test   %eax,%eax
     4b8:	0f 85 30 06 00 00    	jne    aee <acquirelock+0x6ce>
    int locked_by=0;
     4be:	c7 85 c0 fe ff ff 00 	movl   $0x0,-0x140(%ebp)
     4c5:	00 00 00 
     4c8:	c7 85 ac fe ff ff 00 	movl   $0x0,-0x154(%ebp)
     4cf:	00 00 00 
     4d2:	c7 85 b0 fe ff ff 00 	movl   $0x0,-0x150(%ebp)
     4d9:	00 00 00 
     4dc:	c7 85 b8 fe ff ff 00 	movl   $0x0,-0x148(%ebp)
     4e3:	00 00 00 
     4e6:	c7 85 bc fe ff ff 00 	movl   $0x0,-0x144(%ebp)
     4ed:	00 00 00 
     4f0:	c7 85 d0 fe ff ff 00 	movl   $0x0,-0x130(%ebp)
     4f7:	00 00 00 
     4fa:	c7 85 c4 fe ff ff 00 	movl   $0x0,-0x13c(%ebp)
     501:	00 00 00 
     504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        count++;
     508:	83 85 d0 fe ff ff 01 	addl   $0x1,-0x130(%ebp)
        if(t>=30)
     50f:	83 bd d4 fe ff ff 1d 	cmpl   $0x1d,-0x12c(%ebp)
     516:	0f 8f 94 00 00 00    	jg     5b0 <acquirelock+0x190>
        recv((void*)&message);
     51c:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
     522:	83 ec 0c             	sub    $0xc,%esp
     525:	50                   	push   %eax
     526:	e8 5f 0d 00 00       	call   128a <recv>
        if(message.val==REQUEST)
     52b:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
     531:	83 c4 10             	add    $0x10,%esp
        int sender_id=message.senderid;
     534:	8b bd e8 fe ff ff    	mov    -0x118(%ebp),%edi
        if(message.val==REQUEST)
     53a:	83 f8 01             	cmp    $0x1,%eax
     53d:	0f 84 8d 00 00 00    	je     5d0 <acquirelock+0x1b0>
        else if(message.val==RELEASE)
     543:	83 f8 03             	cmp    $0x3,%eax
     546:	0f 84 5c 01 00 00    	je     6a8 <acquirelock+0x288>
        else if(message.val==RELINQUISH)
     54c:	83 f8 05             	cmp    $0x5,%eax
     54f:	0f 84 a3 02 00 00    	je     7f8 <acquirelock+0x3d8>
        else if(message.val==LOCKED)
     555:	83 f8 02             	cmp    $0x2,%eax
     558:	0f 84 ba 01 00 00    	je     718 <acquirelock+0x2f8>
        else if(message.val==FAILED)
     55e:	83 f8 04             	cmp    $0x4,%eax
     561:	0f 84 71 03 00 00    	je     8d8 <acquirelock+0x4b8>
        else if(message.val==INQUIRE)
     567:	83 f8 06             	cmp    $0x6,%eax
     56a:	0f 85 60 02 00 00    	jne    7d0 <acquirelock+0x3b0>
            if(failedQ_size!=0)
     570:	8b 9d bc fe ff ff    	mov    -0x144(%ebp),%ebx
     576:	85 db                	test   %ebx,%ebx
     578:	0f 85 62 04 00 00    	jne    9e0 <acquirelock+0x5c0>
                inquireQ[inquireQ_tail++]=sender_id;
     57e:	8b 85 ac fe ff ff    	mov    -0x154(%ebp),%eax
                inquireQ_size++;
     584:	83 85 b8 fe ff ff 01 	addl   $0x1,-0x148(%ebp)
        count++;
     58b:	83 85 d0 fe ff ff 01 	addl   $0x1,-0x130(%ebp)
                inquireQ[inquireQ_tail++]=sender_id;
     592:	89 bc 85 f8 fe ff ff 	mov    %edi,-0x108(%ebp,%eax,4)
     599:	83 c0 01             	add    $0x1,%eax
        if(t>=30)
     59c:	83 bd d4 fe ff ff 1d 	cmpl   $0x1d,-0x12c(%ebp)
                inquireQ[inquireQ_tail++]=sender_id;
     5a3:	89 85 ac fe ff ff    	mov    %eax,-0x154(%ebp)
        if(t>=30)
     5a9:	0f 8e 6d ff ff ff    	jle    51c <acquirelock+0xfc>
     5af:	90                   	nop
        printf(1,"kanish blunder kar diya tune\n");
     5b0:	83 ec 08             	sub    $0x8,%esp
     5b3:	68 cf 16 00 00       	push   $0x16cf
     5b8:	6a 01                	push   $0x1
     5ba:	e8 a1 0d 00 00       	call   1360 <printf>
     5bf:	83 c4 10             	add    $0x10,%esp
     5c2:	e9 55 ff ff ff       	jmp    51c <acquirelock+0xfc>
     5c7:	89 f6                	mov    %esi,%esi
     5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if(!locked)
     5d0:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
     5d6:	85 c0                	test   %eax,%eax
     5d8:	0f 84 b2 01 00 00    	je     790 <acquirelock+0x370>
                if(t>=30)
     5de:	83 bd d4 fe ff ff 1d 	cmpl   $0x1d,-0x12c(%ebp)
     5e5:	0f 8f 95 02 00 00    	jg     880 <acquirelock+0x460>
                if(size>0)
     5eb:	8b 9d e4 fe ff ff    	mov    -0x11c(%ebp),%ebx
                int min_id=10000;
     5f1:	b9 10 27 00 00       	mov    $0x2710,%ecx
                if(size>0)
     5f6:	85 db                	test   %ebx,%ebx
     5f8:	7e 35                	jle    62f <acquirelock+0x20f>
     5fa:	8b 45 10             	mov    0x10(%ebp),%eax
                    int count=0;
     5fd:	89 bd b4 fe ff ff    	mov    %edi,-0x14c(%ebp)
     603:	31 f6                	xor    %esi,%esi
     605:	8d 50 78             	lea    0x78(%eax),%edx
     608:	89 d7                	mov    %edx,%edi
     60a:	eb 0b                	jmp    617 <acquirelock+0x1f7>
     60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     610:	83 c0 04             	add    $0x4,%eax
                    for(int i=0;i<30;i++)
     613:	39 c7                	cmp    %eax,%edi
     615:	74 12                	je     629 <acquirelock+0x209>
                        if(waitingQ[i]!=0)
     617:	8b 10                	mov    (%eax),%edx
     619:	85 d2                	test   %edx,%edx
     61b:	74 08                	je     625 <acquirelock+0x205>
                            count++;
     61d:	83 c6 01             	add    $0x1,%esi
     620:	39 d1                	cmp    %edx,%ecx
     622:	0f 4f ca             	cmovg  %edx,%ecx
                        if(count==size)
     625:	39 f3                	cmp    %esi,%ebx
     627:	75 e7                	jne    610 <acquirelock+0x1f0>
     629:	8b bd b4 fe ff ff    	mov    -0x14c(%ebp),%edi
                waitingQ[t++]=sender_id;
     62f:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
     635:	8b 55 10             	mov    0x10(%ebp),%edx
                size++;
     638:	83 c3 01             	add    $0x1,%ebx
                if(min_id<sender_id||sender_id>locked_by)
     63b:	39 f9                	cmp    %edi,%ecx
                size++;
     63d:	89 9d e4 fe ff ff    	mov    %ebx,-0x11c(%ebp)
                waitingQ[t++]=sender_id;
     643:	8d 70 01             	lea    0x1(%eax),%esi
     646:	89 3c 82             	mov    %edi,(%edx,%eax,4)
                if(min_id<sender_id||sender_id>locked_by)
     649:	0f 8c 51 02 00 00    	jl     8a0 <acquirelock+0x480>
     64f:	39 bd c8 fe ff ff    	cmp    %edi,-0x138(%ebp)
     655:	0f 8c 45 02 00 00    	jl     8a0 <acquirelock+0x480>
                else if(min_id>sender_id&&sender_id<locked_by)
     65b:	8b 9d c8 fe ff ff    	mov    -0x138(%ebp),%ebx
                waitingQ[t++]=sender_id;
     661:	89 b5 d4 fe ff ff    	mov    %esi,-0x12c(%ebp)
                else if(min_id>sender_id&&sender_id<locked_by)
     667:	39 cb                	cmp    %ecx,%ebx
     669:	89 d8                	mov    %ebx,%eax
     66b:	0f 4f c1             	cmovg  %ecx,%eax
     66e:	39 f8                	cmp    %edi,%eax
     670:	0f 8e 92 fe ff ff    	jle    508 <acquirelock+0xe8>
                    if(min_id<locked_by)
     676:	39 cb                	cmp    %ecx,%ebx
     678:	0f 8f 1a 04 00 00    	jg     a98 <acquirelock+0x678>
                    if(!inquired_someone)
     67e:	8b bd c4 fe ff ff    	mov    -0x13c(%ebp),%edi
     684:	85 ff                	test   %edi,%edi
     686:	0f 84 c4 03 00 00    	je     a50 <acquirelock+0x630>
     68c:	8b 85 c4 fe ff ff    	mov    -0x13c(%ebp),%eax
                waitingQ[t++]=sender_id;
     692:	89 b5 d4 fe ff ff    	mov    %esi,-0x12c(%ebp)
     698:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
     69e:	e9 65 fe ff ff       	jmp    508 <acquirelock+0xe8>
     6a3:	90                   	nop
     6a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if(size!=0)
     6a8:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
     6ae:	c7 85 c4 fe ff ff 00 	movl   $0x0,-0x13c(%ebp)
     6b5:	00 00 00 
     6b8:	85 c0                	test   %eax,%eax
     6ba:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
     6c0:	0f 84 42 fe ff ff    	je     508 <acquirelock+0xe8>
                int min_id=deque_min(waitingQ,&size);
     6c6:	8d 85 e4 fe ff ff    	lea    -0x11c(%ebp),%eax
     6cc:	83 ec 08             	sub    $0x8,%esp
     6cf:	50                   	push   %eax
     6d0:	ff 75 10             	pushl  0x10(%ebp)
     6d3:	e8 88 fc ff ff       	call   360 <deque_min>
                message2.senderid=pid;
     6d8:	8b 75 1c             	mov    0x1c(%ebp),%esi
                send(pid,min_id,(void*)&message2);
     6db:	8d 8d f0 fe ff ff    	lea    -0x110(%ebp),%ecx
     6e1:	83 c4 0c             	add    $0xc,%esp
                int min_id=deque_min(waitingQ,&size);
     6e4:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
                message2.val=LOCKED;
     6ea:	c7 85 f4 fe ff ff 02 	movl   $0x2,-0x10c(%ebp)
     6f1:	00 00 00 
                send(pid,min_id,(void*)&message2);
     6f4:	51                   	push   %ecx
     6f5:	50                   	push   %eax
     6f6:	56                   	push   %esi
                message2.senderid=pid;
     6f7:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
                send(pid,min_id,(void*)&message2);
     6fd:	e8 80 0b 00 00       	call   1282 <send>
     702:	83 c4 10             	add    $0x10,%esp
                locked=1;
     705:	c7 85 cc fe ff ff 01 	movl   $0x1,-0x134(%ebp)
     70c:	00 00 00 
     70f:	e9 f4 fd ff ff       	jmp    508 <acquirelock+0xe8>
     714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            locked_count++;
     718:	83 85 c0 fe ff ff 01 	addl   $0x1,-0x140(%ebp)
     71f:	8b 85 c0 fe ff ff    	mov    -0x140(%ebp),%eax
            if(locked_count==num_peers)
     725:	39 45 0c             	cmp    %eax,0xc(%ebp)
     728:	0f 84 a2 03 00 00    	je     ad0 <acquirelock+0x6b0>
            if(failedQ_size!=0)
     72e:	8b b5 bc fe ff ff    	mov    -0x144(%ebp),%esi
     734:	85 f6                	test   %esi,%esi
     736:	0f 84 cc fd ff ff    	je     508 <acquirelock+0xe8>
                for(int i=0;i<30;i++)
     73c:	31 c0                	xor    %eax,%eax
                int count=0;
     73e:	31 d2                	xor    %edx,%edx
     740:	8b 9d bc fe ff ff    	mov    -0x144(%ebp),%ebx
     746:	eb 1c                	jmp    764 <acquirelock+0x344>
     748:	90                   	nop
     749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                    if(count==failedQ_size)
     750:	39 d3                	cmp    %edx,%ebx
     752:	0f 84 b0 fd ff ff    	je     508 <acquirelock+0xe8>
                for(int i=0;i<30;i++)
     758:	83 c0 01             	add    $0x1,%eax
     75b:	83 f8 1e             	cmp    $0x1e,%eax
     75e:	0f 84 a4 fd ff ff    	je     508 <acquirelock+0xe8>
                    if(failedQ[i]!=0)
     764:	8b 8c 85 70 ff ff ff 	mov    -0x90(%ebp,%eax,4),%ecx
                    count++;
     76b:	83 f9 01             	cmp    $0x1,%ecx
     76e:	83 da ff             	sbb    $0xffffffff,%edx
                    if(failedQ[i]==sender_id)
     771:	39 f9                	cmp    %edi,%ecx
     773:	75 db                	jne    750 <acquirelock+0x330>
                        failedQ[i]=0;
     775:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
     77c:	00 00 00 00 
                        failedQ_size--;
     780:	83 ad bc fe ff ff 01 	subl   $0x1,-0x144(%ebp)
                        break;
     787:	e9 7c fd ff ff       	jmp    508 <acquirelock+0xe8>
     78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                message2.senderid=pid;
     790:	8b 45 1c             	mov    0x1c(%ebp),%eax
                send(pid,message.senderid,(void*)&message2);
     793:	83 ec 04             	sub    $0x4,%esp
                message2.val=LOCKED;
     796:	c7 85 f4 fe ff ff 02 	movl   $0x2,-0x10c(%ebp)
     79d:	00 00 00 
                message2.senderid=pid;
     7a0:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
                send(pid,message.senderid,(void*)&message2);
     7a6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
     7ac:	50                   	push   %eax
     7ad:	57                   	push   %edi
     7ae:	ff 75 1c             	pushl  0x1c(%ebp)
     7b1:	e8 cc 0a 00 00       	call   1282 <send>
     7b6:	83 c4 10             	add    $0x10,%esp
        int sender_id=message.senderid;
     7b9:	89 bd c8 fe ff ff    	mov    %edi,-0x138(%ebp)
                locked=1;
     7bf:	c7 85 cc fe ff ff 01 	movl   $0x1,-0x134(%ebp)
     7c6:	00 00 00 
     7c9:	e9 3a fd ff ff       	jmp    508 <acquirelock+0xe8>
     7ce:	66 90                	xchg   %ax,%ax
            printf(1,"message value=%d by %d in %d at count=%d\n",message.val,sender_id,pid,count);
     7d0:	83 ec 08             	sub    $0x8,%esp
     7d3:	ff b5 d0 fe ff ff    	pushl  -0x130(%ebp)
     7d9:	ff 75 1c             	pushl  0x1c(%ebp)
     7dc:	57                   	push   %edi
     7dd:	50                   	push   %eax
     7de:	68 30 17 00 00       	push   $0x1730
     7e3:	6a 01                	push   $0x1
     7e5:	e8 76 0b 00 00       	call   1360 <printf>
     7ea:	83 c4 20             	add    $0x20,%esp
     7ed:	e9 16 fd ff ff       	jmp    508 <acquirelock+0xe8>
     7f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            int min_id=deque_min(waitingQ,&size);
     7f8:	8d 85 e4 fe ff ff    	lea    -0x11c(%ebp),%eax
     7fe:	83 ec 08             	sub    $0x8,%esp
     801:	50                   	push   %eax
     802:	ff 75 10             	pushl  0x10(%ebp)
     805:	e8 56 fb ff ff       	call   360 <deque_min>
            if(min_id>sender_id)
     80a:	83 c4 10             	add    $0x10,%esp
     80d:	39 c7                	cmp    %eax,%edi
            int min_id=deque_min(waitingQ,&size);
     80f:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
            if(min_id>sender_id)
     815:	0f 8c 1d 02 00 00    	jl     a38 <acquirelock+0x618>
            message2.senderid=pid;
     81b:	8b 45 1c             	mov    0x1c(%ebp),%eax
            send(pid,min_id,(void*)&message2);
     81e:	83 ec 04             	sub    $0x4,%esp
            message2.val=LOCKED;
     821:	c7 85 f4 fe ff ff 02 	movl   $0x2,-0x10c(%ebp)
     828:	00 00 00 
            message2.senderid=pid;
     82b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
            send(pid,min_id,(void*)&message2);
     831:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
     837:	50                   	push   %eax
     838:	ff b5 c8 fe ff ff    	pushl  -0x138(%ebp)
     83e:	ff 75 1c             	pushl  0x1c(%ebp)
     841:	e8 3c 0a 00 00       	call   1282 <send>
            waitingQ[t++]=sender_id;
     846:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
     84c:	8b 75 10             	mov    0x10(%ebp),%esi
     84f:	83 c4 10             	add    $0x10,%esp
            size++;
     852:	83 85 e4 fe ff ff 01 	addl   $0x1,-0x11c(%ebp)
            inquired_someone=0;
     859:	c7 85 c4 fe ff ff 00 	movl   $0x0,-0x13c(%ebp)
     860:	00 00 00 
            locked=1;
     863:	c7 85 cc fe ff ff 01 	movl   $0x1,-0x134(%ebp)
     86a:	00 00 00 
            waitingQ[t++]=sender_id;
     86d:	89 3c 86             	mov    %edi,(%esi,%eax,4)
     870:	83 c0 01             	add    $0x1,%eax
     873:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
     879:	e9 8a fc ff ff       	jmp    508 <acquirelock+0xe8>
     87e:	66 90                	xchg   %ax,%ax
                    printf(1,"waiting Q is full error\n");
     880:	83 ec 08             	sub    $0x8,%esp
     883:	68 ed 16 00 00       	push   $0x16ed
     888:	6a 01                	push   $0x1
     88a:	e8 d1 0a 00 00       	call   1360 <printf>
     88f:	83 c4 10             	add    $0x10,%esp
     892:	e9 54 fd ff ff       	jmp    5eb <acquirelock+0x1cb>
     897:	89 f6                	mov    %esi,%esi
     899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                    message2.senderid=pid;
     8a0:	8b 45 1c             	mov    0x1c(%ebp),%eax
                    send(pid,sender_id,(void*)&message2);
     8a3:	83 ec 04             	sub    $0x4,%esp
                    message2.val=FAILED;
     8a6:	c7 85 f4 fe ff ff 04 	movl   $0x4,-0x10c(%ebp)
     8ad:	00 00 00 
                    message2.senderid=pid;
     8b0:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
                    send(pid,sender_id,(void*)&message2);
     8b6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
     8bc:	50                   	push   %eax
     8bd:	57                   	push   %edi
     8be:	ff 75 1c             	pushl  0x1c(%ebp)
     8c1:	e8 bc 09 00 00       	call   1282 <send>
     8c6:	83 c4 10             	add    $0x10,%esp
                waitingQ[t++]=sender_id;
     8c9:	89 b5 d4 fe ff ff    	mov    %esi,-0x12c(%ebp)
     8cf:	e9 34 fc ff ff       	jmp    508 <acquirelock+0xe8>
     8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     8d8:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
     8de:	8d 5d e8             	lea    -0x18(%ebp),%ebx
            int count=0;
     8e1:	31 c9                	xor    %ecx,%ecx
     8e3:	8b b5 bc fe ff ff    	mov    -0x144(%ebp),%esi
     8e9:	eb 0c                	jmp    8f7 <acquirelock+0x4d7>
     8eb:	90                   	nop
     8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     8f0:	83 c0 04             	add    $0x4,%eax
            for(int i=0;i<30;i++)
     8f3:	39 d8                	cmp    %ebx,%eax
     8f5:	74 15                	je     90c <acquirelock+0x4ec>
                if(failedQ[i]!=0)
     8f7:	8b 10                	mov    (%eax),%edx
     8f9:	85 d2                	test   %edx,%edx
     8fb:	74 0b                	je     908 <acquirelock+0x4e8>
                    count++;
     8fd:	83 c1 01             	add    $0x1,%ecx
                    if(failedQ[i]==sender_id)
     900:	39 fa                	cmp    %edi,%edx
     902:	0f 84 00 fc ff ff    	je     508 <acquirelock+0xe8>
                if(count==failedQ_size)
     908:	39 ce                	cmp    %ecx,%esi
     90a:	75 e4                	jne    8f0 <acquirelock+0x4d0>
                failedQ[failedQ_tail++]=sender_id;
     90c:	8b 85 b0 fe ff ff    	mov    -0x150(%ebp),%eax
                while(inquireQ_size!=0)
     912:	8b 8d b8 fe ff ff    	mov    -0x148(%ebp),%ecx
                failedQ[failedQ_tail++]=sender_id;
     918:	8d 50 01             	lea    0x1(%eax),%edx
     91b:	89 bc 85 70 ff ff ff 	mov    %edi,-0x90(%ebp,%eax,4)
                failedQ_size++;
     922:	8b 85 bc fe ff ff    	mov    -0x144(%ebp),%eax
     928:	83 c0 01             	add    $0x1,%eax
                while(inquireQ_size!=0)
     92b:	85 c9                	test   %ecx,%ecx
     92d:	0f 84 72 02 00 00    	je     ba5 <acquirelock+0x785>
     933:	8b 85 b0 fe ff ff    	mov    -0x150(%ebp),%eax
     939:	8d 9d f8 fe ff ff    	lea    -0x108(%ebp),%ebx
                int j=0;
     93f:	31 ff                	xor    %edi,%edi
     941:	8d b4 85 70 ff ff ff 	lea    -0x90(%ebp,%eax,4),%esi
     948:	89 b5 b4 fe ff ff    	mov    %esi,-0x14c(%ebp)
     94e:	89 fe                	mov    %edi,%esi
     950:	89 df                	mov    %ebx,%edi
     952:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
                    failedQ[failedQ_tail++]=inquireQ[j];
     955:	8b 04 b7             	mov    (%edi,%esi,4),%eax
     958:	8b 8d b4 fe ff ff    	mov    -0x14c(%ebp),%ecx
                    send(pid,inquireQ[j++],(void*)&message2);
     95e:	83 ec 04             	sub    $0x4,%esp
                    message2.senderid=pid;
     961:	89 9d f0 fe ff ff    	mov    %ebx,-0x110(%ebp)
                    message2.val=RELINQUISH;
     967:	c7 85 f4 fe ff ff 05 	movl   $0x5,-0x10c(%ebp)
     96e:	00 00 00 
                    failedQ[failedQ_tail++]=inquireQ[j];
     971:	89 44 b1 04          	mov    %eax,0x4(%ecx,%esi,4)
                    send(pid,inquireQ[j++],(void*)&message2);
     975:	8d 8d f0 fe ff ff    	lea    -0x110(%ebp),%ecx
     97b:	83 c6 01             	add    $0x1,%esi
     97e:	51                   	push   %ecx
     97f:	50                   	push   %eax
     980:	53                   	push   %ebx
     981:	e8 fc 08 00 00       	call   1282 <send>
                while(inquireQ_size!=0)
     986:	83 c4 10             	add    $0x10,%esp
     989:	39 b5 b8 fe ff ff    	cmp    %esi,-0x148(%ebp)
     98f:	75 c4                	jne    955 <acquirelock+0x535>
     991:	8b 8d b8 fe ff ff    	mov    -0x148(%ebp),%ecx
     997:	8b b5 b0 fe ff ff    	mov    -0x150(%ebp),%esi
     99d:	29 8d c0 fe ff ff    	sub    %ecx,-0x140(%ebp)
                inquireQ_tail=0;
     9a3:	c7 85 ac fe ff ff 00 	movl   $0x0,-0x154(%ebp)
     9aa:	00 00 00 
                while(inquireQ_size!=0)
     9ad:	c7 85 b8 fe ff ff 00 	movl   $0x0,-0x148(%ebp)
     9b4:	00 00 00 
     9b7:	8d 41 ff             	lea    -0x1(%ecx),%eax
     9ba:	8d 74 06 02          	lea    0x2(%esi,%eax,1),%esi
     9be:	89 b5 b0 fe ff ff    	mov    %esi,-0x150(%ebp)
     9c4:	8b b5 bc fe ff ff    	mov    -0x144(%ebp),%esi
     9ca:	8d 44 06 02          	lea    0x2(%esi,%eax,1),%eax
     9ce:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
     9d4:	e9 2f fb ff ff       	jmp    508 <acquirelock+0xe8>
     9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                message2.senderid=pid;
     9e0:	8b 45 1c             	mov    0x1c(%ebp),%eax
                send(pid,sender_id,(void*)&message2);
     9e3:	83 ec 04             	sub    $0x4,%esp
                locked_count--;
     9e6:	83 ad c0 fe ff ff 01 	subl   $0x1,-0x140(%ebp)
                message2.val=RELINQUISH;
     9ed:	c7 85 f4 fe ff ff 05 	movl   $0x5,-0x10c(%ebp)
     9f4:	00 00 00 
                message2.senderid=pid;
     9f7:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
                send(pid,sender_id,(void*)&message2);
     9fd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
     a03:	50                   	push   %eax
     a04:	57                   	push   %edi
     a05:	ff 75 1c             	pushl  0x1c(%ebp)
     a08:	e8 75 08 00 00       	call   1282 <send>
                failedQ[failedQ_tail++]=sender_id;
     a0d:	8b 85 b0 fe ff ff    	mov    -0x150(%ebp),%eax
                failedQ_size++;
     a13:	83 85 bc fe ff ff 01 	addl   $0x1,-0x144(%ebp)
     a1a:	83 c4 10             	add    $0x10,%esp
                failedQ[failedQ_tail++]=sender_id;
     a1d:	89 bc 85 70 ff ff ff 	mov    %edi,-0x90(%ebp,%eax,4)
     a24:	83 c0 01             	add    $0x1,%eax
     a27:	89 85 b0 fe ff ff    	mov    %eax,-0x150(%ebp)
     a2d:	e9 d6 fa ff ff       	jmp    508 <acquirelock+0xe8>
     a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                printf(1,"error with min_id=%d and sender id=%d\n",min_id,sender_id);
     a38:	57                   	push   %edi
     a39:	50                   	push   %eax
     a3a:	68 08 17 00 00       	push   $0x1708
     a3f:	6a 01                	push   $0x1
     a41:	e8 1a 09 00 00       	call   1360 <printf>
     a46:	83 c4 10             	add    $0x10,%esp
     a49:	e9 cd fd ff ff       	jmp    81b <acquirelock+0x3fb>
     a4e:	66 90                	xchg   %ax,%ax
                        message2.senderid=pid;
     a50:	8b 45 1c             	mov    0x1c(%ebp),%eax
                        send(pid,locked_by,(void*)&message2);
     a53:	83 ec 04             	sub    $0x4,%esp
                        message2.val=INQUIRE;
     a56:	c7 85 f4 fe ff ff 06 	movl   $0x6,-0x10c(%ebp)
     a5d:	00 00 00 
                        message2.senderid=pid;
     a60:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
                        send(pid,locked_by,(void*)&message2);
     a66:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
     a6c:	50                   	push   %eax
     a6d:	ff b5 c8 fe ff ff    	pushl  -0x138(%ebp)
     a73:	ff 75 1c             	pushl  0x1c(%ebp)
     a76:	e8 07 08 00 00       	call   1282 <send>
                        inquired_someone=1;
     a7b:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
     a81:	83 c4 10             	add    $0x10,%esp
                waitingQ[t++]=sender_id;
     a84:	89 b5 d4 fe ff ff    	mov    %esi,-0x12c(%ebp)
                        inquired_someone=1;
     a8a:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
     a90:	e9 73 fa ff ff       	jmp    508 <acquirelock+0xe8>
     a95:	8d 76 00             	lea    0x0(%esi),%esi
                        message2.senderid=pid;
     a98:	8b 45 1c             	mov    0x1c(%ebp),%eax
                        send(pid,min_id,(void*)&message2);   
     a9b:	83 ec 04             	sub    $0x4,%esp
                        message2.val=FAILED;
     a9e:	c7 85 f4 fe ff ff 04 	movl   $0x4,-0x10c(%ebp)
     aa5:	00 00 00 
                        message2.senderid=pid;
     aa8:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
                        send(pid,min_id,(void*)&message2);   
     aae:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
     ab4:	50                   	push   %eax
     ab5:	51                   	push   %ecx
     ab6:	ff 75 1c             	pushl  0x1c(%ebp)
     ab9:	e8 c4 07 00 00       	call   1282 <send>
     abe:	83 c4 10             	add    $0x10,%esp
     ac1:	e9 b8 fb ff ff       	jmp    67e <acquirelock+0x25e>
     ac6:	8d 76 00             	lea    0x0(%esi),%esi
     ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                *sizeadd=size;
     ad0:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
     ad6:	8b 75 14             	mov    0x14(%ebp),%esi
                *tadd=t;
     ad9:	8b 8d d4 fe ff ff    	mov    -0x12c(%ebp),%ecx
                *sizeadd=size;
     adf:	89 06                	mov    %eax,(%esi)
                *tadd=t;
     ae1:	8b 45 18             	mov    0x18(%ebp),%eax
     ae4:	89 08                	mov    %ecx,(%eax)
}
     ae6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ae9:	5b                   	pop    %ebx
     aea:	5e                   	pop    %esi
     aeb:	5f                   	pop    %edi
     aec:	5d                   	pop    %ebp
     aed:	c3                   	ret    
        int min_id=deque_min(waitingQ,&size);
     aee:	8d 85 e4 fe ff ff    	lea    -0x11c(%ebp),%eax
     af4:	83 ec 08             	sub    $0x8,%esp
     af7:	50                   	push   %eax
     af8:	ff 75 10             	pushl  0x10(%ebp)
     afb:	e8 60 f8 ff ff       	call   360 <deque_min>
     b00:	89 c1                	mov    %eax,%ecx
     b02:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
        message2.senderid=pid;
     b08:	8b 45 1c             	mov    0x1c(%ebp),%eax
        send(pid,min_id,(void*)&message2);
     b0b:	83 c4 0c             	add    $0xc,%esp
        message2.val=LOCKED;
     b0e:	c7 85 fc fe ff ff 02 	movl   $0x2,-0x104(%ebp)
     b15:	00 00 00 
        message2.senderid=pid;
     b18:	89 85 f8 fe ff ff    	mov    %eax,-0x108(%ebp)
        send(pid,min_id,(void*)&message2);
     b1e:	8d 85 f8 fe ff ff    	lea    -0x108(%ebp),%eax
     b24:	50                   	push   %eax
     b25:	51                   	push   %ecx
     b26:	ff 75 1c             	pushl  0x1c(%ebp)
     b29:	e8 54 07 00 00       	call   1282 <send>
        if(size!=0)
     b2e:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
     b34:	83 c4 10             	add    $0x10,%esp
     b37:	85 c0                	test   %eax,%eax
     b39:	74 5b                	je     b96 <acquirelock+0x776>
     b3b:	8b 5d 10             	mov    0x10(%ebp),%ebx
            message4.senderid=pid;
     b3e:	8b 45 1c             	mov    0x1c(%ebp),%eax
            int count=0;
     b41:	31 f6                	xor    %esi,%esi
            message4.val=FAILED;
     b43:	c7 85 74 ff ff ff 04 	movl   $0x4,-0x8c(%ebp)
     b4a:	00 00 00 
     b4d:	8d 7b 78             	lea    0x78(%ebx),%edi
            message4.senderid=pid;
     b50:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
                    send(pid,waitingQ[j],(void*)&message4);
     b56:	89 f8                	mov    %edi,%eax
     b58:	89 f7                	mov    %esi,%edi
     b5a:	89 c6                	mov    %eax,%esi
     b5c:	eb 11                	jmp    b6f <acquirelock+0x74f>
     b5e:	66 90                	xchg   %ax,%ax
                if(count==size)
     b60:	39 bd e4 fe ff ff    	cmp    %edi,-0x11c(%ebp)
     b66:	74 2e                	je     b96 <acquirelock+0x776>
     b68:	83 c3 04             	add    $0x4,%ebx
            for(int j=0;j<30;j++)
     b6b:	39 de                	cmp    %ebx,%esi
     b6d:	74 27                	je     b96 <acquirelock+0x776>
                if(waitingQ[j]!=0)
     b6f:	8b 03                	mov    (%ebx),%eax
     b71:	85 c0                	test   %eax,%eax
     b73:	74 eb                	je     b60 <acquirelock+0x740>
                    send(pid,waitingQ[j],(void*)&message4);
     b75:	8d 8d 70 ff ff ff    	lea    -0x90(%ebp),%ecx
     b7b:	83 ec 04             	sub    $0x4,%esp
                    count++;
     b7e:	83 c7 01             	add    $0x1,%edi
                    send(pid,waitingQ[j],(void*)&message4);
     b81:	51                   	push   %ecx
     b82:	50                   	push   %eax
     b83:	ff 75 1c             	pushl  0x1c(%ebp)
     b86:	e8 f7 06 00 00       	call   1282 <send>
     b8b:	83 c4 10             	add    $0x10,%esp
                if(count==size)
     b8e:	39 bd e4 fe ff ff    	cmp    %edi,-0x11c(%ebp)
     b94:	75 d2                	jne    b68 <acquirelock+0x748>
        locked=1;
     b96:	c7 85 cc fe ff ff 01 	movl   $0x1,-0x134(%ebp)
     b9d:	00 00 00 
     ba0:	e9 19 f9 ff ff       	jmp    4be <acquirelock+0x9e>
                inquireQ_tail=0;
     ba5:	c7 85 ac fe ff ff 00 	movl   $0x0,-0x154(%ebp)
     bac:	00 00 00 
                failedQ[failedQ_tail++]=sender_id;
     baf:	89 95 b0 fe ff ff    	mov    %edx,-0x150(%ebp)
                failedQ_size++;
     bb5:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
    {
     bbb:	e9 48 f9 ff ff       	jmp    508 <acquirelock+0xe8>

00000bc0 <releaselock>:
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	57                   	push   %edi
     bc4:	56                   	push   %esi
     bc5:	53                   	push   %ebx
    send(pid,ppid,(void*)&message3);
     bc6:	8d 75 d0             	lea    -0x30(%ebp),%esi
{
     bc9:	83 ec 50             	sub    $0x50,%esp
    message3.senderid=pid;
     bcc:	8b 45 1c             	mov    0x1c(%ebp),%eax
{
     bcf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    send(pid,ppid,(void*)&message3);
     bd2:	56                   	push   %esi
     bd3:	ff 35 80 1b 00 00    	pushl  0x1b80
    message3.val=RELEASE;
     bd9:	c7 45 d4 03 00 00 00 	movl   $0x3,-0x2c(%ebp)
    send(pid,ppid,(void*)&message3);
     be0:	50                   	push   %eax
    message3.senderid=pid;
     be1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    send(pid,ppid,(void*)&message3);
     be4:	e8 99 06 00 00       	call   1282 <send>
    for(int i=0;i<num_peers;i++)
     be9:	83 c4 10             	add    $0x10,%esp
     bec:	85 db                	test   %ebx,%ebx
     bee:	7e 2c                	jle    c1c <releaselock+0x5c>
     bf0:	8b 7d 08             	mov    0x8(%ebp),%edi
     bf3:	8d 1c 9f             	lea    (%edi,%ebx,4),%ebx
     bf6:	89 5d c4             	mov    %ebx,-0x3c(%ebp)
     bf9:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
     bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(peers[i]!=pid)
     c00:	8b 07                	mov    (%edi),%eax
     c02:	39 d8                	cmp    %ebx,%eax
     c04:	74 0e                	je     c14 <releaselock+0x54>
        send(pid,peers[i],(void*)&message3);
     c06:	83 ec 04             	sub    $0x4,%esp
     c09:	56                   	push   %esi
     c0a:	50                   	push   %eax
     c0b:	53                   	push   %ebx
     c0c:	e8 71 06 00 00       	call   1282 <send>
     c11:	83 c4 10             	add    $0x10,%esp
     c14:	83 c7 04             	add    $0x4,%edi
    for(int i=0;i<num_peers;i++)
     c17:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
     c1a:	75 e4                	jne    c00 <releaselock+0x40>
    if(size!=0)
     c1c:	8b 45 14             	mov    0x14(%ebp),%eax
    int locked_by=0;
     c1f:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    if(size!=0)
     c26:	85 c0                	test   %eax,%eax
     c28:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     c2b:	0f 85 aa 02 00 00    	jne    edb <releaselock+0x31b>
     c31:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
     c38:	90                   	nop
     c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if(t>=30)
     c40:	83 7d 18 1d          	cmpl   $0x1d,0x18(%ebp)
     c44:	0f 8f f6 00 00 00    	jg     d40 <releaselock+0x180>
        recv((void*)&message);
     c4a:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c4d:	83 ec 0c             	sub    $0xc,%esp
     c50:	50                   	push   %eax
     c51:	e8 34 06 00 00       	call   128a <recv>
        if(message.val==REQUEST)
     c56:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c59:	83 c4 10             	add    $0x10,%esp
        int sender_id=message.senderid;
     c5c:	8b 7d d8             	mov    -0x28(%ebp),%edi
        if(message.val==REQUEST)
     c5f:	83 f8 01             	cmp    $0x1,%eax
     c62:	74 24                	je     c88 <releaselock+0xc8>
        else if(message.val==RELEASE)
     c64:	83 f8 03             	cmp    $0x3,%eax
     c67:	0f 84 f3 00 00 00    	je     d60 <releaselock+0x1a0>
        else if(message.val==RELINQUISH)
     c6d:	83 f8 05             	cmp    $0x5,%eax
     c70:	0f 84 7a 01 00 00    	je     df0 <releaselock+0x230>
        else if(sender_id==ppid)
     c76:	39 3d 80 1b 00 00    	cmp    %edi,0x1b80
     c7c:	75 c2                	jne    c40 <releaselock+0x80>
            exit();
     c7e:	e8 3f 05 00 00       	call   11c2 <exit>
     c83:	90                   	nop
     c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if(!locked)
     c88:	8b 75 c4             	mov    -0x3c(%ebp),%esi
     c8b:	85 f6                	test   %esi,%esi
     c8d:	0f 84 25 01 00 00    	je     db8 <releaselock+0x1f8>
                if(t==30)
     c93:	83 7d 18 1e          	cmpl   $0x1e,0x18(%ebp)
     c97:	0f 84 b3 01 00 00    	je     e50 <releaselock+0x290>
     c9d:	8b 4d 18             	mov    0x18(%ebp),%ecx
     ca0:	8b 45 10             	mov    0x10(%ebp),%eax
     ca3:	83 45 18 01          	addl   $0x1,0x18(%ebp)
     ca7:	8d 04 88             	lea    (%eax,%ecx,4),%eax
     caa:	89 45 b8             	mov    %eax,-0x48(%ebp)
                if(size>0)
     cad:	8b 5d 14             	mov    0x14(%ebp),%ebx
                int min_id=10000;
     cb0:	b9 10 27 00 00       	mov    $0x2710,%ecx
                if(size>0)
     cb5:	85 db                	test   %ebx,%ebx
     cb7:	7e 33                	jle    cec <releaselock+0x12c>
     cb9:	8b 45 10             	mov    0x10(%ebp),%eax
                    int count=0;
     cbc:	89 7d b4             	mov    %edi,-0x4c(%ebp)
     cbf:	31 f6                	xor    %esi,%esi
     cc1:	89 c2                	mov    %eax,%edx
     cc3:	83 c2 78             	add    $0x78,%edx
     cc6:	89 d7                	mov    %edx,%edi
     cc8:	eb 0d                	jmp    cd7 <releaselock+0x117>
     cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cd0:	83 c0 04             	add    $0x4,%eax
                    for(int i=0;i<30;i++)
     cd3:	39 c7                	cmp    %eax,%edi
     cd5:	74 12                	je     ce9 <releaselock+0x129>
                        if(waitingQ[i]!=0)
     cd7:	8b 10                	mov    (%eax),%edx
     cd9:	85 d2                	test   %edx,%edx
     cdb:	74 08                	je     ce5 <releaselock+0x125>
                            count++;
     cdd:	83 c6 01             	add    $0x1,%esi
     ce0:	39 d1                	cmp    %edx,%ecx
     ce2:	0f 4f ca             	cmovg  %edx,%ecx
                        if(count==size)
     ce5:	39 f3                	cmp    %esi,%ebx
     ce7:	75 e7                	jne    cd0 <releaselock+0x110>
     ce9:	8b 7d b4             	mov    -0x4c(%ebp),%edi
                waitingQ[t++]=sender_id;
     cec:	8b 45 b8             	mov    -0x48(%ebp),%eax
                size++;
     cef:	83 c3 01             	add    $0x1,%ebx
                if(min_id<sender_id||sender_id>locked_by)
     cf2:	39 f9                	cmp    %edi,%ecx
                size++;
     cf4:	89 5d 14             	mov    %ebx,0x14(%ebp)
                waitingQ[t++]=sender_id;
     cf7:	89 38                	mov    %edi,(%eax)
                if(min_id<sender_id||sender_id>locked_by)
     cf9:	0f 8c 69 01 00 00    	jl     e68 <releaselock+0x2a8>
     cff:	39 7d c0             	cmp    %edi,-0x40(%ebp)
     d02:	0f 8c 60 01 00 00    	jl     e68 <releaselock+0x2a8>
                else if(min_id>sender_id&&sender_id<locked_by)
     d08:	8b 75 c0             	mov    -0x40(%ebp),%esi
     d0b:	39 ce                	cmp    %ecx,%esi
     d0d:	89 f0                	mov    %esi,%eax
     d0f:	0f 4f c1             	cmovg  %ecx,%eax
     d12:	39 f8                	cmp    %edi,%eax
     d14:	0f 8e 26 ff ff ff    	jle    c40 <releaselock+0x80>
                    if(min_id<locked_by)
     d1a:	39 ce                	cmp    %ecx,%esi
     d1c:	0f 8f 6b 01 00 00    	jg     e8d <releaselock+0x2cd>
                    if(!inquired_someone)
     d22:	8b 55 bc             	mov    -0x44(%ebp),%edx
     d25:	85 d2                	test   %edx,%edx
     d27:	0f 84 83 01 00 00    	je     eb0 <releaselock+0x2f0>
        if(t>=30)
     d2d:	83 7d 18 1d          	cmpl   $0x1d,0x18(%ebp)
     d31:	8b 45 bc             	mov    -0x44(%ebp),%eax
     d34:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     d37:	0f 8e 0d ff ff ff    	jle    c4a <releaselock+0x8a>
     d3d:	8d 76 00             	lea    0x0(%esi),%esi
        printf(1,"kanish blunder kar diya tune\n");
     d40:	83 ec 08             	sub    $0x8,%esp
     d43:	68 cf 16 00 00       	push   $0x16cf
     d48:	6a 01                	push   $0x1
     d4a:	e8 11 06 00 00       	call   1360 <printf>
     d4f:	83 c4 10             	add    $0x10,%esp
     d52:	e9 f3 fe ff ff       	jmp    c4a <releaselock+0x8a>
     d57:	89 f6                	mov    %esi,%esi
     d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if(size!=0)
     d60:	8b 45 14             	mov    0x14(%ebp),%eax
     d63:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
     d6a:	85 c0                	test   %eax,%eax
     d6c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     d6f:	0f 84 cb fe ff ff    	je     c40 <releaselock+0x80>
                int min_id=deque_min(waitingQ,&size);
     d75:	8d 45 14             	lea    0x14(%ebp),%eax
     d78:	83 ec 08             	sub    $0x8,%esp
     d7b:	50                   	push   %eax
     d7c:	ff 75 10             	pushl  0x10(%ebp)
     d7f:	e8 dc f5 ff ff       	call   360 <deque_min>
                message2.senderid=pid;
     d84:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
                send(pid,min_id,(void*)&message2);
     d87:	83 c4 0c             	add    $0xc,%esp
                int min_id=deque_min(waitingQ,&size);
     d8a:	89 45 c0             	mov    %eax,-0x40(%ebp)
                message2.val=LOCKED;
     d8d:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
                message2.senderid=pid;
     d94:	89 4d e0             	mov    %ecx,-0x20(%ebp)
                send(pid,min_id,(void*)&message2);
     d97:	8d 4d e0             	lea    -0x20(%ebp),%ecx
     d9a:	51                   	push   %ecx
     d9b:	50                   	push   %eax
     d9c:	ff 75 1c             	pushl  0x1c(%ebp)
     d9f:	e8 de 04 00 00       	call   1282 <send>
     da4:	83 c4 10             	add    $0x10,%esp
                locked=1;
     da7:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
     dae:	e9 8d fe ff ff       	jmp    c40 <releaselock+0x80>
     db3:	90                   	nop
     db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                message2.senderid=pid;
     db8:	8b 45 1c             	mov    0x1c(%ebp),%eax
                send(pid,message.senderid,(void*)&message2);
     dbb:	83 ec 04             	sub    $0x4,%esp
                message2.val=LOCKED;
     dbe:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
                message2.senderid=pid;
     dc5:	89 45 e0             	mov    %eax,-0x20(%ebp)
                send(pid,message.senderid,(void*)&message2);
     dc8:	8d 45 e0             	lea    -0x20(%ebp),%eax
     dcb:	50                   	push   %eax
     dcc:	57                   	push   %edi
     dcd:	ff 75 1c             	pushl  0x1c(%ebp)
     dd0:	e8 ad 04 00 00       	call   1282 <send>
     dd5:	83 c4 10             	add    $0x10,%esp
        int sender_id=message.senderid;
     dd8:	89 7d c0             	mov    %edi,-0x40(%ebp)
                locked=1;
     ddb:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
     de2:	e9 59 fe ff ff       	jmp    c40 <releaselock+0x80>
     de7:	89 f6                	mov    %esi,%esi
     de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            int min_id=deque_min(waitingQ,&size);
     df0:	8d 45 14             	lea    0x14(%ebp),%eax
     df3:	83 ec 08             	sub    $0x8,%esp
     df6:	50                   	push   %eax
     df7:	ff 75 10             	pushl  0x10(%ebp)
     dfa:	e8 61 f5 ff ff       	call   360 <deque_min>
            message2.senderid=pid;
     dff:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
            send(pid,min_id,(void*)&message2);
     e02:	83 c4 0c             	add    $0xc,%esp
            int min_id=deque_min(waitingQ,&size);
     e05:	89 45 c0             	mov    %eax,-0x40(%ebp)
            message2.val=LOCKED;
     e08:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
            message2.senderid=pid;
     e0f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
            send(pid,min_id,(void*)&message2);
     e12:	8d 4d e0             	lea    -0x20(%ebp),%ecx
     e15:	51                   	push   %ecx
     e16:	50                   	push   %eax
     e17:	ff 75 1c             	pushl  0x1c(%ebp)
     e1a:	e8 63 04 00 00       	call   1282 <send>
            waitingQ[t++]=sender_id;
     e1f:	8b 4d 18             	mov    0x18(%ebp),%ecx
     e22:	8b 45 10             	mov    0x10(%ebp),%eax
     e25:	83 c4 10             	add    $0x10,%esp
            size++;
     e28:	83 45 14 01          	addl   $0x1,0x14(%ebp)
            inquired_someone=0;
     e2c:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
            locked=1;
     e33:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
            waitingQ[t++]=sender_id;
     e3a:	89 3c 88             	mov    %edi,(%eax,%ecx,4)
     e3d:	89 c8                	mov    %ecx,%eax
     e3f:	83 c0 01             	add    $0x1,%eax
     e42:	89 45 18             	mov    %eax,0x18(%ebp)
     e45:	e9 f6 fd ff ff       	jmp    c40 <releaselock+0x80>
     e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e50:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     e53:	89 45 18             	mov    %eax,0x18(%ebp)
     e56:	8b 45 10             	mov    0x10(%ebp),%eax
     e59:	89 45 b8             	mov    %eax,-0x48(%ebp)
     e5c:	e9 4c fe ff ff       	jmp    cad <releaselock+0xed>
     e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                    message2.senderid=pid;
     e68:	8b 45 1c             	mov    0x1c(%ebp),%eax
                    send(pid,sender_id,(void*)&message2);
     e6b:	83 ec 04             	sub    $0x4,%esp
                    message2.val=FAILED;
     e6e:	c7 45 e4 04 00 00 00 	movl   $0x4,-0x1c(%ebp)
                    message2.senderid=pid;
     e75:	89 45 e0             	mov    %eax,-0x20(%ebp)
                    send(pid,sender_id,(void*)&message2);
     e78:	8d 45 e0             	lea    -0x20(%ebp),%eax
     e7b:	50                   	push   %eax
     e7c:	57                   	push   %edi
     e7d:	ff 75 1c             	pushl  0x1c(%ebp)
     e80:	e8 fd 03 00 00       	call   1282 <send>
     e85:	83 c4 10             	add    $0x10,%esp
     e88:	e9 b3 fd ff ff       	jmp    c40 <releaselock+0x80>
                        message2.senderid=pid;
     e8d:	8b 45 1c             	mov    0x1c(%ebp),%eax
                        send(pid,min_id,(void*)&message2);   
     e90:	53                   	push   %ebx
                        message2.val=FAILED;
     e91:	c7 45 e4 04 00 00 00 	movl   $0x4,-0x1c(%ebp)
                        message2.senderid=pid;
     e98:	89 45 e0             	mov    %eax,-0x20(%ebp)
                        send(pid,min_id,(void*)&message2);   
     e9b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     e9e:	50                   	push   %eax
     e9f:	51                   	push   %ecx
     ea0:	ff 75 1c             	pushl  0x1c(%ebp)
     ea3:	e8 da 03 00 00       	call   1282 <send>
     ea8:	83 c4 10             	add    $0x10,%esp
     eab:	e9 72 fe ff ff       	jmp    d22 <releaselock+0x162>
                        message2.senderid=pid;
     eb0:	8b 45 1c             	mov    0x1c(%ebp),%eax
                        message2.val=INQUIRE;
     eb3:	c7 45 e4 06 00 00 00 	movl   $0x6,-0x1c(%ebp)
                        message2.senderid=pid;
     eba:	89 45 e0             	mov    %eax,-0x20(%ebp)
                        send(pid,locked_by,(void*)&message2);
     ebd:	50                   	push   %eax
     ebe:	8d 45 e0             	lea    -0x20(%ebp),%eax
     ec1:	50                   	push   %eax
     ec2:	ff 75 c0             	pushl  -0x40(%ebp)
     ec5:	ff 75 1c             	pushl  0x1c(%ebp)
     ec8:	e8 b5 03 00 00       	call   1282 <send>
                        inquired_someone=1;
     ecd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     ed0:	83 c4 10             	add    $0x10,%esp
     ed3:	89 45 bc             	mov    %eax,-0x44(%ebp)
     ed6:	e9 65 fd ff ff       	jmp    c40 <releaselock+0x80>
        int min_id=deque_min(waitingQ,&size);
     edb:	8d 45 14             	lea    0x14(%ebp),%eax
     ede:	51                   	push   %ecx
     edf:	51                   	push   %ecx
        send(pid,min_id,(void*)&message2);
     ee0:	8d 75 d8             	lea    -0x28(%ebp),%esi
        int min_id=deque_min(waitingQ,&size);
     ee3:	50                   	push   %eax
     ee4:	ff 75 10             	pushl  0x10(%ebp)
     ee7:	e8 74 f4 ff ff       	call   360 <deque_min>
        message2.senderid=pid;
     eec:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
        send(pid,min_id,(void*)&message2);
     eef:	83 c4 0c             	add    $0xc,%esp
        int min_id=deque_min(waitingQ,&size);
     ef2:	89 45 c0             	mov    %eax,-0x40(%ebp)
        send(pid,min_id,(void*)&message2);
     ef5:	56                   	push   %esi
     ef6:	50                   	push   %eax
        message2.val=LOCKED;
     ef7:	c7 45 dc 02 00 00 00 	movl   $0x2,-0x24(%ebp)
        send(pid,min_id,(void*)&message2);
     efe:	51                   	push   %ecx
        message2.senderid=pid;
     eff:	89 4d d8             	mov    %ecx,-0x28(%ebp)
        send(pid,min_id,(void*)&message2);
     f02:	e8 7b 03 00 00       	call   1282 <send>
        if(size!=0)
     f07:	83 c4 10             	add    $0x10,%esp
     f0a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     f0e:	74 48                	je     f58 <releaselock+0x398>
     f10:	8b 5d 10             	mov    0x10(%ebp),%ebx
            message4.senderid=pid;
     f13:	8b 45 1c             	mov    0x1c(%ebp),%eax
            int count=0;
     f16:	31 f6                	xor    %esi,%esi
            message4.val=FAILED;
     f18:	c7 45 e4 04 00 00 00 	movl   $0x4,-0x1c(%ebp)
     f1f:	8d 7b 78             	lea    0x78(%ebx),%edi
            message4.senderid=pid;
     f22:	89 45 e0             	mov    %eax,-0x20(%ebp)
                    send(pid,waitingQ[j],(void*)&message4);
     f25:	89 f8                	mov    %edi,%eax
     f27:	89 f7                	mov    %esi,%edi
     f29:	89 c6                	mov    %eax,%esi
     f2b:	eb 0f                	jmp    f3c <releaselock+0x37c>
     f2d:	8d 76 00             	lea    0x0(%esi),%esi
                if(count==size)
     f30:	39 7d 14             	cmp    %edi,0x14(%ebp)
     f33:	74 23                	je     f58 <releaselock+0x398>
     f35:	83 c3 04             	add    $0x4,%ebx
            for(int j=0;j<30;j++)
     f38:	39 f3                	cmp    %esi,%ebx
     f3a:	74 1c                	je     f58 <releaselock+0x398>
                if(waitingQ[j]!=0)
     f3c:	8b 03                	mov    (%ebx),%eax
     f3e:	85 c0                	test   %eax,%eax
     f40:	74 ee                	je     f30 <releaselock+0x370>
                    send(pid,waitingQ[j],(void*)&message4);
     f42:	8d 4d e0             	lea    -0x20(%ebp),%ecx
     f45:	52                   	push   %edx
                    count++;
     f46:	83 c7 01             	add    $0x1,%edi
                    send(pid,waitingQ[j],(void*)&message4);
     f49:	51                   	push   %ecx
     f4a:	50                   	push   %eax
     f4b:	ff 75 1c             	pushl  0x1c(%ebp)
     f4e:	e8 2f 03 00 00       	call   1282 <send>
     f53:	83 c4 10             	add    $0x10,%esp
     f56:	eb d8                	jmp    f30 <releaselock+0x370>
        locked=1;
     f58:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
     f5f:	e9 cd fc ff ff       	jmp    c31 <releaselock+0x71>
     f64:	66 90                	xchg   %ax,%ax
     f66:	66 90                	xchg   %ax,%ax
     f68:	66 90                	xchg   %ax,%ax
     f6a:	66 90                	xchg   %ax,%ax
     f6c:	66 90                	xchg   %ax,%ax
     f6e:	66 90                	xchg   %ax,%ax

00000f70 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     f70:	55                   	push   %ebp
     f71:	89 e5                	mov    %esp,%ebp
     f73:	53                   	push   %ebx
     f74:	8b 45 08             	mov    0x8(%ebp),%eax
     f77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     f7a:	89 c2                	mov    %eax,%edx
     f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f80:	83 c1 01             	add    $0x1,%ecx
     f83:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     f87:	83 c2 01             	add    $0x1,%edx
     f8a:	84 db                	test   %bl,%bl
     f8c:	88 5a ff             	mov    %bl,-0x1(%edx)
     f8f:	75 ef                	jne    f80 <strcpy+0x10>
    ;
  return os;
}
     f91:	5b                   	pop    %ebx
     f92:	5d                   	pop    %ebp
     f93:	c3                   	ret    
     f94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000fa0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	53                   	push   %ebx
     fa4:	8b 55 08             	mov    0x8(%ebp),%edx
     fa7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     faa:	0f b6 02             	movzbl (%edx),%eax
     fad:	0f b6 19             	movzbl (%ecx),%ebx
     fb0:	84 c0                	test   %al,%al
     fb2:	75 1c                	jne    fd0 <strcmp+0x30>
     fb4:	eb 2a                	jmp    fe0 <strcmp+0x40>
     fb6:	8d 76 00             	lea    0x0(%esi),%esi
     fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     fc0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     fc3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     fc6:	83 c1 01             	add    $0x1,%ecx
     fc9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     fcc:	84 c0                	test   %al,%al
     fce:	74 10                	je     fe0 <strcmp+0x40>
     fd0:	38 d8                	cmp    %bl,%al
     fd2:	74 ec                	je     fc0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     fd4:	29 d8                	sub    %ebx,%eax
}
     fd6:	5b                   	pop    %ebx
     fd7:	5d                   	pop    %ebp
     fd8:	c3                   	ret    
     fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fe0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     fe2:	29 d8                	sub    %ebx,%eax
}
     fe4:	5b                   	pop    %ebx
     fe5:	5d                   	pop    %ebp
     fe6:	c3                   	ret    
     fe7:	89 f6                	mov    %esi,%esi
     fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ff0 <strlen>:

uint
strlen(const char *s)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     ff6:	80 39 00             	cmpb   $0x0,(%ecx)
     ff9:	74 15                	je     1010 <strlen+0x20>
     ffb:	31 d2                	xor    %edx,%edx
     ffd:	8d 76 00             	lea    0x0(%esi),%esi
    1000:	83 c2 01             	add    $0x1,%edx
    1003:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1007:	89 d0                	mov    %edx,%eax
    1009:	75 f5                	jne    1000 <strlen+0x10>
    ;
  return n;
}
    100b:	5d                   	pop    %ebp
    100c:	c3                   	ret    
    100d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1010:	31 c0                	xor    %eax,%eax
}
    1012:	5d                   	pop    %ebp
    1013:	c3                   	ret    
    1014:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    101a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001020 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1027:	8b 4d 10             	mov    0x10(%ebp),%ecx
    102a:	8b 45 0c             	mov    0xc(%ebp),%eax
    102d:	89 d7                	mov    %edx,%edi
    102f:	fc                   	cld    
    1030:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1032:	89 d0                	mov    %edx,%eax
    1034:	5f                   	pop    %edi
    1035:	5d                   	pop    %ebp
    1036:	c3                   	ret    
    1037:	89 f6                	mov    %esi,%esi
    1039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001040 <strchr>:

char*
strchr(const char *s, char c)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	53                   	push   %ebx
    1044:	8b 45 08             	mov    0x8(%ebp),%eax
    1047:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    104a:	0f b6 10             	movzbl (%eax),%edx
    104d:	84 d2                	test   %dl,%dl
    104f:	74 1d                	je     106e <strchr+0x2e>
    if(*s == c)
    1051:	38 d3                	cmp    %dl,%bl
    1053:	89 d9                	mov    %ebx,%ecx
    1055:	75 0d                	jne    1064 <strchr+0x24>
    1057:	eb 17                	jmp    1070 <strchr+0x30>
    1059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1060:	38 ca                	cmp    %cl,%dl
    1062:	74 0c                	je     1070 <strchr+0x30>
  for(; *s; s++)
    1064:	83 c0 01             	add    $0x1,%eax
    1067:	0f b6 10             	movzbl (%eax),%edx
    106a:	84 d2                	test   %dl,%dl
    106c:	75 f2                	jne    1060 <strchr+0x20>
      return (char*)s;
  return 0;
    106e:	31 c0                	xor    %eax,%eax
}
    1070:	5b                   	pop    %ebx
    1071:	5d                   	pop    %ebp
    1072:	c3                   	ret    
    1073:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001080 <gets>:

char*
gets(char *buf, int max)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	57                   	push   %edi
    1084:	56                   	push   %esi
    1085:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1086:	31 f6                	xor    %esi,%esi
    1088:	89 f3                	mov    %esi,%ebx
{
    108a:	83 ec 1c             	sub    $0x1c,%esp
    108d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1090:	eb 2f                	jmp    10c1 <gets+0x41>
    1092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1098:	8d 45 e7             	lea    -0x19(%ebp),%eax
    109b:	83 ec 04             	sub    $0x4,%esp
    109e:	6a 01                	push   $0x1
    10a0:	50                   	push   %eax
    10a1:	6a 00                	push   $0x0
    10a3:	e8 32 01 00 00       	call   11da <read>
    if(cc < 1)
    10a8:	83 c4 10             	add    $0x10,%esp
    10ab:	85 c0                	test   %eax,%eax
    10ad:	7e 1c                	jle    10cb <gets+0x4b>
      break;
    buf[i++] = c;
    10af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    10b3:	83 c7 01             	add    $0x1,%edi
    10b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    10b9:	3c 0a                	cmp    $0xa,%al
    10bb:	74 23                	je     10e0 <gets+0x60>
    10bd:	3c 0d                	cmp    $0xd,%al
    10bf:	74 1f                	je     10e0 <gets+0x60>
  for(i=0; i+1 < max; ){
    10c1:	83 c3 01             	add    $0x1,%ebx
    10c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    10c7:	89 fe                	mov    %edi,%esi
    10c9:	7c cd                	jl     1098 <gets+0x18>
    10cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    10cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    10d0:	c6 03 00             	movb   $0x0,(%ebx)
}
    10d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10d6:	5b                   	pop    %ebx
    10d7:	5e                   	pop    %esi
    10d8:	5f                   	pop    %edi
    10d9:	5d                   	pop    %ebp
    10da:	c3                   	ret    
    10db:	90                   	nop
    10dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10e0:	8b 75 08             	mov    0x8(%ebp),%esi
    10e3:	8b 45 08             	mov    0x8(%ebp),%eax
    10e6:	01 de                	add    %ebx,%esi
    10e8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    10ea:	c6 03 00             	movb   $0x0,(%ebx)
}
    10ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10f0:	5b                   	pop    %ebx
    10f1:	5e                   	pop    %esi
    10f2:	5f                   	pop    %edi
    10f3:	5d                   	pop    %ebp
    10f4:	c3                   	ret    
    10f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001100 <stat>:

int
stat(const char *n, struct stat *st)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	56                   	push   %esi
    1104:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1105:	83 ec 08             	sub    $0x8,%esp
    1108:	6a 00                	push   $0x0
    110a:	ff 75 08             	pushl  0x8(%ebp)
    110d:	e8 f0 00 00 00       	call   1202 <open>
  if(fd < 0)
    1112:	83 c4 10             	add    $0x10,%esp
    1115:	85 c0                	test   %eax,%eax
    1117:	78 27                	js     1140 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1119:	83 ec 08             	sub    $0x8,%esp
    111c:	ff 75 0c             	pushl  0xc(%ebp)
    111f:	89 c3                	mov    %eax,%ebx
    1121:	50                   	push   %eax
    1122:	e8 f3 00 00 00       	call   121a <fstat>
  close(fd);
    1127:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    112a:	89 c6                	mov    %eax,%esi
  close(fd);
    112c:	e8 b9 00 00 00       	call   11ea <close>
  return r;
    1131:	83 c4 10             	add    $0x10,%esp
}
    1134:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1137:	89 f0                	mov    %esi,%eax
    1139:	5b                   	pop    %ebx
    113a:	5e                   	pop    %esi
    113b:	5d                   	pop    %ebp
    113c:	c3                   	ret    
    113d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1140:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1145:	eb ed                	jmp    1134 <stat+0x34>
    1147:	89 f6                	mov    %esi,%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001150 <atoi>:

int
atoi(const char *s)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	53                   	push   %ebx
    1154:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1157:	0f be 11             	movsbl (%ecx),%edx
    115a:	8d 42 d0             	lea    -0x30(%edx),%eax
    115d:	3c 09                	cmp    $0x9,%al
  n = 0;
    115f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1164:	77 1f                	ja     1185 <atoi+0x35>
    1166:	8d 76 00             	lea    0x0(%esi),%esi
    1169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1170:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1173:	83 c1 01             	add    $0x1,%ecx
    1176:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    117a:	0f be 11             	movsbl (%ecx),%edx
    117d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1180:	80 fb 09             	cmp    $0x9,%bl
    1183:	76 eb                	jbe    1170 <atoi+0x20>
  return n;
}
    1185:	5b                   	pop    %ebx
    1186:	5d                   	pop    %ebp
    1187:	c3                   	ret    
    1188:	90                   	nop
    1189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001190 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	56                   	push   %esi
    1194:	53                   	push   %ebx
    1195:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1198:	8b 45 08             	mov    0x8(%ebp),%eax
    119b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    119e:	85 db                	test   %ebx,%ebx
    11a0:	7e 14                	jle    11b6 <memmove+0x26>
    11a2:	31 d2                	xor    %edx,%edx
    11a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    11a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    11ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    11af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    11b2:	39 d3                	cmp    %edx,%ebx
    11b4:	75 f2                	jne    11a8 <memmove+0x18>
  return vdst;
}
    11b6:	5b                   	pop    %ebx
    11b7:	5e                   	pop    %esi
    11b8:	5d                   	pop    %ebp
    11b9:	c3                   	ret    

000011ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11ba:	b8 01 00 00 00       	mov    $0x1,%eax
    11bf:	cd 40                	int    $0x40
    11c1:	c3                   	ret    

000011c2 <exit>:
SYSCALL(exit)
    11c2:	b8 02 00 00 00       	mov    $0x2,%eax
    11c7:	cd 40                	int    $0x40
    11c9:	c3                   	ret    

000011ca <wait>:
SYSCALL(wait)
    11ca:	b8 03 00 00 00       	mov    $0x3,%eax
    11cf:	cd 40                	int    $0x40
    11d1:	c3                   	ret    

000011d2 <pipe>:
SYSCALL(pipe)
    11d2:	b8 04 00 00 00       	mov    $0x4,%eax
    11d7:	cd 40                	int    $0x40
    11d9:	c3                   	ret    

000011da <read>:
SYSCALL(read)
    11da:	b8 05 00 00 00       	mov    $0x5,%eax
    11df:	cd 40                	int    $0x40
    11e1:	c3                   	ret    

000011e2 <write>:
SYSCALL(write)
    11e2:	b8 10 00 00 00       	mov    $0x10,%eax
    11e7:	cd 40                	int    $0x40
    11e9:	c3                   	ret    

000011ea <close>:
SYSCALL(close)
    11ea:	b8 15 00 00 00       	mov    $0x15,%eax
    11ef:	cd 40                	int    $0x40
    11f1:	c3                   	ret    

000011f2 <kill>:
SYSCALL(kill)
    11f2:	b8 06 00 00 00       	mov    $0x6,%eax
    11f7:	cd 40                	int    $0x40
    11f9:	c3                   	ret    

000011fa <exec>:
SYSCALL(exec)
    11fa:	b8 07 00 00 00       	mov    $0x7,%eax
    11ff:	cd 40                	int    $0x40
    1201:	c3                   	ret    

00001202 <open>:
SYSCALL(open)
    1202:	b8 0f 00 00 00       	mov    $0xf,%eax
    1207:	cd 40                	int    $0x40
    1209:	c3                   	ret    

0000120a <mknod>:
SYSCALL(mknod)
    120a:	b8 11 00 00 00       	mov    $0x11,%eax
    120f:	cd 40                	int    $0x40
    1211:	c3                   	ret    

00001212 <unlink>:
SYSCALL(unlink)
    1212:	b8 12 00 00 00       	mov    $0x12,%eax
    1217:	cd 40                	int    $0x40
    1219:	c3                   	ret    

0000121a <fstat>:
SYSCALL(fstat)
    121a:	b8 08 00 00 00       	mov    $0x8,%eax
    121f:	cd 40                	int    $0x40
    1221:	c3                   	ret    

00001222 <link>:
SYSCALL(link)
    1222:	b8 13 00 00 00       	mov    $0x13,%eax
    1227:	cd 40                	int    $0x40
    1229:	c3                   	ret    

0000122a <mkdir>:
SYSCALL(mkdir)
    122a:	b8 14 00 00 00       	mov    $0x14,%eax
    122f:	cd 40                	int    $0x40
    1231:	c3                   	ret    

00001232 <chdir>:
SYSCALL(chdir)
    1232:	b8 09 00 00 00       	mov    $0x9,%eax
    1237:	cd 40                	int    $0x40
    1239:	c3                   	ret    

0000123a <dup>:
SYSCALL(dup)
    123a:	b8 0a 00 00 00       	mov    $0xa,%eax
    123f:	cd 40                	int    $0x40
    1241:	c3                   	ret    

00001242 <getpid>:
SYSCALL(getpid)
    1242:	b8 0b 00 00 00       	mov    $0xb,%eax
    1247:	cd 40                	int    $0x40
    1249:	c3                   	ret    

0000124a <sbrk>:
SYSCALL(sbrk)
    124a:	b8 0c 00 00 00       	mov    $0xc,%eax
    124f:	cd 40                	int    $0x40
    1251:	c3                   	ret    

00001252 <sleep>:
SYSCALL(sleep)
    1252:	b8 0d 00 00 00       	mov    $0xd,%eax
    1257:	cd 40                	int    $0x40
    1259:	c3                   	ret    

0000125a <uptime>:
SYSCALL(uptime)
    125a:	b8 0e 00 00 00       	mov    $0xe,%eax
    125f:	cd 40                	int    $0x40
    1261:	c3                   	ret    

00001262 <toggle>:
SYSCALL(toggle)
    1262:	b8 16 00 00 00       	mov    $0x16,%eax
    1267:	cd 40                	int    $0x40
    1269:	c3                   	ret    

0000126a <print_count>:
SYSCALL(print_count)
    126a:	b8 17 00 00 00       	mov    $0x17,%eax
    126f:	cd 40                	int    $0x40
    1271:	c3                   	ret    

00001272 <add>:
SYSCALL(add)
    1272:	b8 18 00 00 00       	mov    $0x18,%eax
    1277:	cd 40                	int    $0x40
    1279:	c3                   	ret    

0000127a <ps>:
SYSCALL(ps)
    127a:	b8 19 00 00 00       	mov    $0x19,%eax
    127f:	cd 40                	int    $0x40
    1281:	c3                   	ret    

00001282 <send>:
SYSCALL(send)
    1282:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1287:	cd 40                	int    $0x40
    1289:	c3                   	ret    

0000128a <recv>:
SYSCALL(recv)
    128a:	b8 1b 00 00 00       	mov    $0x1b,%eax
    128f:	cd 40                	int    $0x40
    1291:	c3                   	ret    

00001292 <sigset>:
SYSCALL(sigset)
    1292:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1297:	cd 40                	int    $0x40
    1299:	c3                   	ret    

0000129a <sigsend>:
SYSCALL(sigsend)
    129a:	b8 1d 00 00 00       	mov    $0x1d,%eax
    129f:	cd 40                	int    $0x40
    12a1:	c3                   	ret    

000012a2 <sigret>:
SYSCALL(sigret)
    12a2:	b8 1e 00 00 00       	mov    $0x1e,%eax
    12a7:	cd 40                	int    $0x40
    12a9:	c3                   	ret    

000012aa <sigpause>:
SYSCALL(sigpause)
    12aa:	b8 1f 00 00 00       	mov    $0x1f,%eax
    12af:	cd 40                	int    $0x40
    12b1:	c3                   	ret    

000012b2 <send_multi>:
SYSCALL(send_multi)
    12b2:	b8 20 00 00 00       	mov    $0x20,%eax
    12b7:	cd 40                	int    $0x40
    12b9:	c3                   	ret    
    12ba:	66 90                	xchg   %ax,%ax
    12bc:	66 90                	xchg   %ax,%ax
    12be:	66 90                	xchg   %ax,%ax

000012c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	57                   	push   %edi
    12c4:	56                   	push   %esi
    12c5:	53                   	push   %ebx
    12c6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    12c9:	85 d2                	test   %edx,%edx
{
    12cb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    12ce:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    12d0:	79 76                	jns    1348 <printint+0x88>
    12d2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    12d6:	74 70                	je     1348 <printint+0x88>
    x = -xx;
    12d8:	f7 d8                	neg    %eax
    neg = 1;
    12da:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    12e1:	31 f6                	xor    %esi,%esi
    12e3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    12e6:	eb 0a                	jmp    12f2 <printint+0x32>
    12e8:	90                   	nop
    12e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    12f0:	89 fe                	mov    %edi,%esi
    12f2:	31 d2                	xor    %edx,%edx
    12f4:	8d 7e 01             	lea    0x1(%esi),%edi
    12f7:	f7 f1                	div    %ecx
    12f9:	0f b6 92 24 18 00 00 	movzbl 0x1824(%edx),%edx
  }while((x /= base) != 0);
    1300:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1302:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1305:	75 e9                	jne    12f0 <printint+0x30>
  if(neg)
    1307:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    130a:	85 c0                	test   %eax,%eax
    130c:	74 08                	je     1316 <printint+0x56>
    buf[i++] = '-';
    130e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1313:	8d 7e 02             	lea    0x2(%esi),%edi
    1316:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    131a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    131d:	8d 76 00             	lea    0x0(%esi),%esi
    1320:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    1323:	83 ec 04             	sub    $0x4,%esp
    1326:	83 ee 01             	sub    $0x1,%esi
    1329:	6a 01                	push   $0x1
    132b:	53                   	push   %ebx
    132c:	57                   	push   %edi
    132d:	88 45 d7             	mov    %al,-0x29(%ebp)
    1330:	e8 ad fe ff ff       	call   11e2 <write>

  while(--i >= 0)
    1335:	83 c4 10             	add    $0x10,%esp
    1338:	39 de                	cmp    %ebx,%esi
    133a:	75 e4                	jne    1320 <printint+0x60>
    putc(fd, buf[i]);
}
    133c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    133f:	5b                   	pop    %ebx
    1340:	5e                   	pop    %esi
    1341:	5f                   	pop    %edi
    1342:	5d                   	pop    %ebp
    1343:	c3                   	ret    
    1344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1348:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    134f:	eb 90                	jmp    12e1 <printint+0x21>
    1351:	eb 0d                	jmp    1360 <printf>
    1353:	90                   	nop
    1354:	90                   	nop
    1355:	90                   	nop
    1356:	90                   	nop
    1357:	90                   	nop
    1358:	90                   	nop
    1359:	90                   	nop
    135a:	90                   	nop
    135b:	90                   	nop
    135c:	90                   	nop
    135d:	90                   	nop
    135e:	90                   	nop
    135f:	90                   	nop

00001360 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	57                   	push   %edi
    1364:	56                   	push   %esi
    1365:	53                   	push   %ebx
    1366:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1369:	8b 75 0c             	mov    0xc(%ebp),%esi
    136c:	0f b6 1e             	movzbl (%esi),%ebx
    136f:	84 db                	test   %bl,%bl
    1371:	0f 84 b3 00 00 00    	je     142a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    1377:	8d 45 10             	lea    0x10(%ebp),%eax
    137a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    137d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    137f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1382:	eb 2f                	jmp    13b3 <printf+0x53>
    1384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1388:	83 f8 25             	cmp    $0x25,%eax
    138b:	0f 84 a7 00 00 00    	je     1438 <printf+0xd8>
  write(fd, &c, 1);
    1391:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1394:	83 ec 04             	sub    $0x4,%esp
    1397:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    139a:	6a 01                	push   $0x1
    139c:	50                   	push   %eax
    139d:	ff 75 08             	pushl  0x8(%ebp)
    13a0:	e8 3d fe ff ff       	call   11e2 <write>
    13a5:	83 c4 10             	add    $0x10,%esp
    13a8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    13ab:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    13af:	84 db                	test   %bl,%bl
    13b1:	74 77                	je     142a <printf+0xca>
    if(state == 0){
    13b3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    13b5:	0f be cb             	movsbl %bl,%ecx
    13b8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    13bb:	74 cb                	je     1388 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    13bd:	83 ff 25             	cmp    $0x25,%edi
    13c0:	75 e6                	jne    13a8 <printf+0x48>
      if(c == 'd'){
    13c2:	83 f8 64             	cmp    $0x64,%eax
    13c5:	0f 84 05 01 00 00    	je     14d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    13cb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    13d1:	83 f9 70             	cmp    $0x70,%ecx
    13d4:	74 72                	je     1448 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    13d6:	83 f8 73             	cmp    $0x73,%eax
    13d9:	0f 84 99 00 00 00    	je     1478 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    13df:	83 f8 63             	cmp    $0x63,%eax
    13e2:	0f 84 08 01 00 00    	je     14f0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    13e8:	83 f8 25             	cmp    $0x25,%eax
    13eb:	0f 84 ef 00 00 00    	je     14e0 <printf+0x180>
  write(fd, &c, 1);
    13f1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    13f4:	83 ec 04             	sub    $0x4,%esp
    13f7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    13fb:	6a 01                	push   $0x1
    13fd:	50                   	push   %eax
    13fe:	ff 75 08             	pushl  0x8(%ebp)
    1401:	e8 dc fd ff ff       	call   11e2 <write>
    1406:	83 c4 0c             	add    $0xc,%esp
    1409:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    140c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    140f:	6a 01                	push   $0x1
    1411:	50                   	push   %eax
    1412:	ff 75 08             	pushl  0x8(%ebp)
    1415:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1418:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    141a:	e8 c3 fd ff ff       	call   11e2 <write>
  for(i = 0; fmt[i]; i++){
    141f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    1423:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1426:	84 db                	test   %bl,%bl
    1428:	75 89                	jne    13b3 <printf+0x53>
    }
  }
}
    142a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    142d:	5b                   	pop    %ebx
    142e:	5e                   	pop    %esi
    142f:	5f                   	pop    %edi
    1430:	5d                   	pop    %ebp
    1431:	c3                   	ret    
    1432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    1438:	bf 25 00 00 00       	mov    $0x25,%edi
    143d:	e9 66 ff ff ff       	jmp    13a8 <printf+0x48>
    1442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1448:	83 ec 0c             	sub    $0xc,%esp
    144b:	b9 10 00 00 00       	mov    $0x10,%ecx
    1450:	6a 00                	push   $0x0
    1452:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    1455:	8b 45 08             	mov    0x8(%ebp),%eax
    1458:	8b 17                	mov    (%edi),%edx
    145a:	e8 61 fe ff ff       	call   12c0 <printint>
        ap++;
    145f:	89 f8                	mov    %edi,%eax
    1461:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1464:	31 ff                	xor    %edi,%edi
        ap++;
    1466:	83 c0 04             	add    $0x4,%eax
    1469:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    146c:	e9 37 ff ff ff       	jmp    13a8 <printf+0x48>
    1471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1478:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    147b:	8b 08                	mov    (%eax),%ecx
        ap++;
    147d:	83 c0 04             	add    $0x4,%eax
    1480:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1483:	85 c9                	test   %ecx,%ecx
    1485:	0f 84 8e 00 00 00    	je     1519 <printf+0x1b9>
        while(*s != 0){
    148b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    148e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1490:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1492:	84 c0                	test   %al,%al
    1494:	0f 84 0e ff ff ff    	je     13a8 <printf+0x48>
    149a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    149d:	89 de                	mov    %ebx,%esi
    149f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    14a2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    14a5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    14a8:	83 ec 04             	sub    $0x4,%esp
          s++;
    14ab:	83 c6 01             	add    $0x1,%esi
    14ae:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    14b1:	6a 01                	push   $0x1
    14b3:	57                   	push   %edi
    14b4:	53                   	push   %ebx
    14b5:	e8 28 fd ff ff       	call   11e2 <write>
        while(*s != 0){
    14ba:	0f b6 06             	movzbl (%esi),%eax
    14bd:	83 c4 10             	add    $0x10,%esp
    14c0:	84 c0                	test   %al,%al
    14c2:	75 e4                	jne    14a8 <printf+0x148>
    14c4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    14c7:	31 ff                	xor    %edi,%edi
    14c9:	e9 da fe ff ff       	jmp    13a8 <printf+0x48>
    14ce:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    14d0:	83 ec 0c             	sub    $0xc,%esp
    14d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    14d8:	6a 01                	push   $0x1
    14da:	e9 73 ff ff ff       	jmp    1452 <printf+0xf2>
    14df:	90                   	nop
  write(fd, &c, 1);
    14e0:	83 ec 04             	sub    $0x4,%esp
    14e3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    14e6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    14e9:	6a 01                	push   $0x1
    14eb:	e9 21 ff ff ff       	jmp    1411 <printf+0xb1>
        putc(fd, *ap);
    14f0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    14f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    14f6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    14f8:	6a 01                	push   $0x1
        ap++;
    14fa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    14fd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1500:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1503:	50                   	push   %eax
    1504:	ff 75 08             	pushl  0x8(%ebp)
    1507:	e8 d6 fc ff ff       	call   11e2 <write>
        ap++;
    150c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    150f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1512:	31 ff                	xor    %edi,%edi
    1514:	e9 8f fe ff ff       	jmp    13a8 <printf+0x48>
          s = "(null)";
    1519:	bb 1c 18 00 00       	mov    $0x181c,%ebx
        while(*s != 0){
    151e:	b8 28 00 00 00       	mov    $0x28,%eax
    1523:	e9 72 ff ff ff       	jmp    149a <printf+0x13a>
    1528:	66 90                	xchg   %ax,%ax
    152a:	66 90                	xchg   %ax,%ax
    152c:	66 90                	xchg   %ax,%ax
    152e:	66 90                	xchg   %ax,%ax

00001530 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1530:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1531:	a1 74 1b 00 00       	mov    0x1b74,%eax
{
    1536:	89 e5                	mov    %esp,%ebp
    1538:	57                   	push   %edi
    1539:	56                   	push   %esi
    153a:	53                   	push   %ebx
    153b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    153e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1548:	39 c8                	cmp    %ecx,%eax
    154a:	8b 10                	mov    (%eax),%edx
    154c:	73 32                	jae    1580 <free+0x50>
    154e:	39 d1                	cmp    %edx,%ecx
    1550:	72 04                	jb     1556 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1552:	39 d0                	cmp    %edx,%eax
    1554:	72 32                	jb     1588 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1556:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1559:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    155c:	39 fa                	cmp    %edi,%edx
    155e:	74 30                	je     1590 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1560:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1563:	8b 50 04             	mov    0x4(%eax),%edx
    1566:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1569:	39 f1                	cmp    %esi,%ecx
    156b:	74 3a                	je     15a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    156d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    156f:	a3 74 1b 00 00       	mov    %eax,0x1b74
}
    1574:	5b                   	pop    %ebx
    1575:	5e                   	pop    %esi
    1576:	5f                   	pop    %edi
    1577:	5d                   	pop    %ebp
    1578:	c3                   	ret    
    1579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1580:	39 d0                	cmp    %edx,%eax
    1582:	72 04                	jb     1588 <free+0x58>
    1584:	39 d1                	cmp    %edx,%ecx
    1586:	72 ce                	jb     1556 <free+0x26>
{
    1588:	89 d0                	mov    %edx,%eax
    158a:	eb bc                	jmp    1548 <free+0x18>
    158c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1590:	03 72 04             	add    0x4(%edx),%esi
    1593:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1596:	8b 10                	mov    (%eax),%edx
    1598:	8b 12                	mov    (%edx),%edx
    159a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    159d:	8b 50 04             	mov    0x4(%eax),%edx
    15a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    15a3:	39 f1                	cmp    %esi,%ecx
    15a5:	75 c6                	jne    156d <free+0x3d>
    p->s.size += bp->s.size;
    15a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    15aa:	a3 74 1b 00 00       	mov    %eax,0x1b74
    p->s.size += bp->s.size;
    15af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    15b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    15b5:	89 10                	mov    %edx,(%eax)
}
    15b7:	5b                   	pop    %ebx
    15b8:	5e                   	pop    %esi
    15b9:	5f                   	pop    %edi
    15ba:	5d                   	pop    %ebp
    15bb:	c3                   	ret    
    15bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000015c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	57                   	push   %edi
    15c4:	56                   	push   %esi
    15c5:	53                   	push   %ebx
    15c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    15c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    15cc:	8b 15 74 1b 00 00    	mov    0x1b74,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    15d2:	8d 78 07             	lea    0x7(%eax),%edi
    15d5:	c1 ef 03             	shr    $0x3,%edi
    15d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    15db:	85 d2                	test   %edx,%edx
    15dd:	0f 84 9d 00 00 00    	je     1680 <malloc+0xc0>
    15e3:	8b 02                	mov    (%edx),%eax
    15e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    15e8:	39 cf                	cmp    %ecx,%edi
    15ea:	76 6c                	jbe    1658 <malloc+0x98>
    15ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    15f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    15f7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    15fa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1601:	eb 0e                	jmp    1611 <malloc+0x51>
    1603:	90                   	nop
    1604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1608:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    160a:	8b 48 04             	mov    0x4(%eax),%ecx
    160d:	39 f9                	cmp    %edi,%ecx
    160f:	73 47                	jae    1658 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1611:	39 05 74 1b 00 00    	cmp    %eax,0x1b74
    1617:	89 c2                	mov    %eax,%edx
    1619:	75 ed                	jne    1608 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    161b:	83 ec 0c             	sub    $0xc,%esp
    161e:	56                   	push   %esi
    161f:	e8 26 fc ff ff       	call   124a <sbrk>
  if(p == (char*)-1)
    1624:	83 c4 10             	add    $0x10,%esp
    1627:	83 f8 ff             	cmp    $0xffffffff,%eax
    162a:	74 1c                	je     1648 <malloc+0x88>
  hp->s.size = nu;
    162c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    162f:	83 ec 0c             	sub    $0xc,%esp
    1632:	83 c0 08             	add    $0x8,%eax
    1635:	50                   	push   %eax
    1636:	e8 f5 fe ff ff       	call   1530 <free>
  return freep;
    163b:	8b 15 74 1b 00 00    	mov    0x1b74,%edx
      if((p = morecore(nunits)) == 0)
    1641:	83 c4 10             	add    $0x10,%esp
    1644:	85 d2                	test   %edx,%edx
    1646:	75 c0                	jne    1608 <malloc+0x48>
        return 0;
  }
}
    1648:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    164b:	31 c0                	xor    %eax,%eax
}
    164d:	5b                   	pop    %ebx
    164e:	5e                   	pop    %esi
    164f:	5f                   	pop    %edi
    1650:	5d                   	pop    %ebp
    1651:	c3                   	ret    
    1652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1658:	39 cf                	cmp    %ecx,%edi
    165a:	74 54                	je     16b0 <malloc+0xf0>
        p->s.size -= nunits;
    165c:	29 f9                	sub    %edi,%ecx
    165e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1661:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1664:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1667:	89 15 74 1b 00 00    	mov    %edx,0x1b74
}
    166d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1670:	83 c0 08             	add    $0x8,%eax
}
    1673:	5b                   	pop    %ebx
    1674:	5e                   	pop    %esi
    1675:	5f                   	pop    %edi
    1676:	5d                   	pop    %ebp
    1677:	c3                   	ret    
    1678:	90                   	nop
    1679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1680:	c7 05 74 1b 00 00 78 	movl   $0x1b78,0x1b74
    1687:	1b 00 00 
    168a:	c7 05 78 1b 00 00 78 	movl   $0x1b78,0x1b78
    1691:	1b 00 00 
    base.s.size = 0;
    1694:	b8 78 1b 00 00       	mov    $0x1b78,%eax
    1699:	c7 05 7c 1b 00 00 00 	movl   $0x0,0x1b7c
    16a0:	00 00 00 
    16a3:	e9 44 ff ff ff       	jmp    15ec <malloc+0x2c>
    16a8:	90                   	nop
    16a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    16b0:	8b 08                	mov    (%eax),%ecx
    16b2:	89 0a                	mov    %ecx,(%edx)
    16b4:	eb b1                	jmp    1667 <malloc+0xa7>
