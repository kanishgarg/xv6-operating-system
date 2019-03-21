
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
	float mean;
	float u[N][N];
	float w[N][N];
    scheduler();
	int count=0;
	mean = 0.0;
   7:	d9 ee                	fldz   
{
   9:	ff 71 fc             	pushl  -0x4(%ecx)
   c:	55                   	push   %ebp
   d:	89 e5                	mov    %esp,%ebp
   f:	57                   	push   %edi
  10:	56                   	push   %esi
  11:	8d bd 20 fc ff ff    	lea    -0x3e0(%ebp),%edi
  17:	53                   	push   %ebx
  18:	51                   	push   %ecx
  19:	8d b5 04 fe ff ff    	lea    -0x1fc(%ebp),%esi
  1f:	81 ec 68 04 00 00    	sub    $0x468,%esp
        works[i][1]=(i+1)*slice+1;
  25:	89 fa                	mov    %edi,%edx
    nWorkers = P;
  27:	c7 05 a8 12 00 00 03 	movl   $0x3,0x12a8
  2e:	00 00 00 
        works[i][0]=i*slice+1;
  31:	c7 05 ac 12 00 00 01 	movl   $0x1,0x12ac
  38:	00 00 00 
        works[i][1]=(i+1)*slice+1;
  3b:	c7 05 b0 12 00 00 04 	movl   $0x4,0x12b0
  42:	00 00 00 
  45:	89 f8                	mov    %edi,%eax
        works[i][0]=i*slice+1;
  47:	c7 05 b4 12 00 00 04 	movl   $0x4,0x12b4
  4e:	00 00 00 
        works[i][1]=(i+1)*slice+1;
  51:	c7 05 b8 12 00 00 07 	movl   $0x7,0x12b8
  58:	00 00 00 
        works[i][0]=i*slice+1;
  5b:	c7 05 bc 12 00 00 07 	movl   $0x7,0x12bc
  62:	00 00 00 
        works[i][1]=(i+1)*slice+1;
  65:	c7 05 c0 12 00 00 0a 	movl   $0xa,0x12c0
  6c:	00 00 00 
  6f:	90                   	nop
	for (i = 0; i < N; i++){
		u[i][0] = T;
  70:	d9 05 80 0f 00 00    	flds   0xf80
  76:	83 c0 2c             	add    $0x2c,%eax
  79:	83 c2 04             	add    $0x4,%edx
  7c:	d9 50 d4             	fsts   -0x2c(%eax)
        u[i][N-1] = T;
  7f:	d9 50 fc             	fsts   -0x4(%eax)
        u[0][i] = T;
  82:	d9 52 fc             	fsts   -0x4(%edx)
		u[N-1][i] = 0.0;
  85:	d9 ee                	fldz   
  87:	d9 92 b4 01 00 00    	fsts   0x1b4(%edx)
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
  8d:	d9 40 d4             	flds   -0x2c(%eax)
  90:	d8 40 fc             	fadds  -0x4(%eax)
	for (i = 0; i < N; i++){
  93:	39 f0                	cmp    %esi,%eax
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
  95:	de c2                	faddp  %st,%st(2)
  97:	de c1                	faddp  %st,%st(1)
  99:	de c1                	faddp  %st,%st(1)
	for (i = 0; i < N; i++){
  9b:	75 d3                	jne    70 <main+0x70>
	}
	mean /= (4.0 * N);
  9d:	d8 35 84 0f 00 00    	fdivs  0xf84
  a3:	8d 8d 50 fc ff ff    	lea    -0x3b0(%ebp),%ecx
  a9:	8d 9f bc 01 00 00    	lea    0x1bc(%edi),%ebx
  af:	90                   	nop
  b0:	8d 51 24             	lea    0x24(%ecx),%edx
	mean = 0.0;
  b3:	89 c8                	mov    %ecx,%eax
  b5:	8d 76 00             	lea    0x0(%esi),%esi
	for (i = 1; i < N-1; i++ )
		for ( j= 1; j < N-1; j++) u[i][j] = mean;
  b8:	d9 10                	fsts   (%eax)
  ba:	83 c0 04             	add    $0x4,%eax
  bd:	39 d0                	cmp    %edx,%eax
  bf:	75 f7                	jne    b8 <main+0xb8>
  c1:	83 c1 2c             	add    $0x2c,%ecx
	for (i = 1; i < N-1; i++ )
  c4:	39 d9                	cmp    %ebx,%ecx
  c6:	75 e8                	jne    b0 <main+0xb0>
  c8:	dd d8                	fstp   %st(0)
                printf(1,"%d ",((int)u[i][j]));
            printf(1,"\n");
        }
        exit();
    }
    int ppid=getpid();
  ca:	e8 33 0a 00 00       	call   b02 <getpid>
    int recids[P];

    for(k=0;k<P;k++)
  cf:	31 db                	xor    %ebx,%ebx
    int ppid=getpid();
  d1:	89 85 e4 fb ff ff    	mov    %eax,-0x41c(%ebp)
    {
        int child=fork();
  d7:	e8 9e 09 00 00       	call   a7a <fork>
        if(child==0)
  dc:	85 c0                	test   %eax,%eax
  de:	0f 84 e7 00 00 00    	je     1cb <main+0x1cb>
                }   
            }
        }
        else
        {
            recids[k]=child;
  e4:	89 84 9d 14 fc ff ff 	mov    %eax,-0x3ec(%ebp,%ebx,4)
    for(k=0;k<P;k++)
  eb:	83 c3 01             	add    $0x1,%ebx
  ee:	83 fb 03             	cmp    $0x3,%ebx
  f1:	75 e4                	jne    d7 <main+0xd7>
  f3:	8d 85 0c fc ff ff    	lea    -0x3f4(%ebp),%eax
  f9:	c7 85 e0 fb ff ff d1 	movl   $0x7d1,-0x420(%ebp)
 100:	07 00 00 
 103:	89 85 e8 fb ff ff    	mov    %eax,-0x418(%ebp)
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
    }
    while(1)
    {
        int cmd=1;
        float maxdiff=0.0;
 110:	d9 ee                	fldz   
        int cmd=1;
 112:	c7 85 0c fc ff ff 01 	movl   $0x1,-0x3f4(%ebp)
 119:	00 00 00 
 11c:	bb 03 00 00 00       	mov    $0x3,%ebx
        count++;
        for (i=0;i<P;i++)
        {
            float value;
            recv((void*)&value);
 121:	83 ec 0c             	sub    $0xc,%esp
 124:	d9 9d ec fb ff ff    	fstps  -0x414(%ebp)
 12a:	56                   	push   %esi
 12b:	e8 1a 0a 00 00       	call   b4a <recv>
            if(value>maxdiff)
                maxdiff=value;
 130:	d9 85 ec fb ff ff    	flds   -0x414(%ebp)
            if(value>maxdiff)
 136:	d9 85 04 fe ff ff    	flds   -0x1fc(%ebp)
 13c:	83 c4 10             	add    $0x10,%esp
                maxdiff=value;
 13f:	db e9                	fucomi %st(1),%st
 141:	da d1                	fcmovbe %st(1),%st
 143:	dd d9                	fstp   %st(1)
        for (i=0;i<P;i++)
 145:	83 eb 01             	sub    $0x1,%ebx
 148:	75 d7                	jne    121 <main+0x121>
        }
        if(maxdiff<= E || count > L){ 
 14a:	dd 05 90 0f 00 00    	fldl   0xf90
 150:	df e9                	fucomip %st(1),%st
 152:	dd d8                	fstp   %st(0)
 154:	73 3a                	jae    190 <main+0x190>
 156:	83 ad e0 fb ff ff 01 	subl   $0x1,-0x420(%ebp)
 15d:	74 31                	je     190 <main+0x190>
 15f:	8d 9d 14 fc ff ff    	lea    -0x3ec(%ebp),%ebx
        }
        else
        {
            for(i=0;i<P;i++)
            {
                send(ppid,recids[i],(void*)&cmd);
 165:	83 ec 04             	sub    $0x4,%esp
 168:	ff b5 e8 fb ff ff    	pushl  -0x418(%ebp)
 16e:	ff 33                	pushl  (%ebx)
 170:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
 176:	83 c3 04             	add    $0x4,%ebx
 179:	e8 c4 09 00 00       	call   b42 <send>
            for(i=0;i<P;i++)
 17e:	83 c4 10             	add    $0x10,%esp
 181:	39 fb                	cmp    %edi,%ebx
 183:	75 e0                	jne    165 <main+0x165>
 185:	eb 89                	jmp    110 <main+0x110>
 187:	89 f6                	mov    %esi,%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 190:	8b b5 e4 fb ff ff    	mov    -0x41c(%ebp),%esi
 196:	8d 9d 14 fc ff ff    	lea    -0x3ec(%ebp),%ebx
            cmd=0;
 19c:	c7 85 0c fc ff ff 00 	movl   $0x0,-0x3f4(%ebp)
 1a3:	00 00 00 
                send(ppid,recids[i],(void*)&cmd);
 1a6:	83 ec 04             	sub    $0x4,%esp
 1a9:	ff b5 e8 fb ff ff    	pushl  -0x418(%ebp)
 1af:	ff 33                	pushl  (%ebx)
 1b1:	56                   	push   %esi
 1b2:	83 c3 04             	add    $0x4,%ebx
 1b5:	e8 88 09 00 00       	call   b42 <send>
                wait();
 1ba:	e8 cb 08 00 00       	call   a8a <wait>
            for(i=0;i<P;i++)
 1bf:	83 c4 10             	add    $0x10,%esp
 1c2:	39 fb                	cmp    %edi,%ebx
 1c4:	75 e0                	jne    1a6 <main+0x1a6>
                    exit();
 1c6:	e8 b7 08 00 00       	call   a82 <exit>
            int s=works[k][0];
 1cb:	8b 14 dd ac 12 00 00 	mov    0x12ac(,%ebx,8),%edx
 1d2:	89 d8                	mov    %ebx,%eax
 1d4:	89 9d b4 fb ff ff    	mov    %ebx,-0x44c(%ebp)
            int e=works[k][1];
 1da:	8b 04 c5 b0 12 00 00 	mov    0x12b0(,%eax,8),%eax
            int s=works[k][0];
 1e1:	89 d3                	mov    %edx,%ebx
 1e3:	89 95 b0 fb ff ff    	mov    %edx,-0x450(%ebp)
            int e=works[k][1];
 1e9:	89 85 d0 fb ff ff    	mov    %eax,-0x430(%ebp)
            int pid=getpid();
 1ef:	e8 0e 09 00 00       	call   b02 <getpid>
 1f4:	6b cb d4             	imul   $0xffffffd4,%ebx,%ecx
 1f7:	89 85 e0 fb ff ff    	mov    %eax,-0x420(%ebp)
 1fd:	8d 43 01             	lea    0x1(%ebx),%eax
 200:	89 da                	mov    %ebx,%edx
 202:	6b c0 2c             	imul   $0x2c,%eax,%eax
 205:	89 8d a4 fb ff ff    	mov    %ecx,-0x45c(%ebp)
 20b:	8d 4b ff             	lea    -0x1(%ebx),%ecx
 20e:	8b 9d d0 fb ff ff    	mov    -0x430(%ebp),%ebx
 214:	89 8d bc fb ff ff    	mov    %ecx,-0x444(%ebp)
 21a:	89 85 a0 fb ff ff    	mov    %eax,-0x460(%ebp)
 220:	6b c3 2c             	imul   $0x2c,%ebx,%eax
 223:	6b d2 2c             	imul   $0x2c,%edx,%edx
 226:	89 85 ec fb ff ff    	mov    %eax,-0x414(%ebp)
 22c:	83 e8 2c             	sub    $0x2c,%eax
 22f:	6b c9 2c             	imul   $0x2c,%ecx,%ecx
 232:	89 85 cc fb ff ff    	mov    %eax,-0x434(%ebp)
 238:	8d 42 04             	lea    0x4(%edx),%eax
 23b:	89 85 9c fb ff ff    	mov    %eax,-0x464(%ebp)
 241:	89 8d ac fb ff ff    	mov    %ecx,-0x454(%ebp)
 247:	89 c1                	mov    %eax,%ecx
 249:	8b 85 ec fb ff ff    	mov    -0x414(%ebp),%eax
 24f:	83 c0 04             	add    $0x4,%eax
 252:	89 85 a8 fb ff ff    	mov    %eax,-0x458(%ebp)
 258:	89 c8                	mov    %ecx,%eax
 25a:	01 f8                	add    %edi,%eax
 25c:	89 85 94 fb ff ff    	mov    %eax,-0x46c(%ebp)
 262:	8d 47 28             	lea    0x28(%edi),%eax
 265:	01 c2                	add    %eax,%edx
 267:	89 95 c8 fb ff ff    	mov    %edx,-0x438(%ebp)
 26d:	8d 53 ff             	lea    -0x1(%ebx),%edx
 270:	6b d2 2c             	imul   $0x2c,%edx,%edx
 273:	8d 4c 17 04          	lea    0x4(%edi,%edx,1),%ecx
 277:	89 8d 98 fb ff ff    	mov    %ecx,-0x468(%ebp)
 27d:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
 280:	8b 95 ac fb ff ff    	mov    -0x454(%ebp),%edx
 286:	89 8d d4 fb ff ff    	mov    %ecx,-0x42c(%ebp)
 28c:	8d 4c 17 04          	lea    0x4(%edi,%edx,1),%ecx
 290:	89 8d 8c fb ff ff    	mov    %ecx,-0x474(%ebp)
 296:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
 299:	03 85 ec fb ff ff    	add    -0x414(%ebp),%eax
 29f:	8b 95 a8 fb ff ff    	mov    -0x458(%ebp),%edx
 2a5:	89 8d b8 fb ff ff    	mov    %ecx,-0x448(%ebp)
 2ab:	89 85 c0 fb ff ff    	mov    %eax,-0x440(%ebp)
 2b1:	8d 0c 17             	lea    (%edi,%edx,1),%ecx
                                u[e][j-t+1]=msg1.val;
 2b4:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
 2b7:	89 8d 90 fb ff ff    	mov    %ecx,-0x470(%ebp)
 2bd:	89 85 c4 fb ff ff    	mov    %eax,-0x43c(%ebp)
 2c3:	90                   	nop
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                for(i =s; i < e; i++){
 2c8:	8b 8d d0 fb ff ff    	mov    -0x430(%ebp),%ecx
 2ce:	39 8d b0 fb ff ff    	cmp    %ecx,-0x450(%ebp)
 2d4:	0f 8d e0 03 00 00    	jge    6ba <main+0x6ba>
 2da:	8b 85 a0 fb ff ff    	mov    -0x460(%ebp),%eax
 2e0:	8b 95 ac fb ff ff    	mov    -0x454(%ebp),%edx
                diff = 0.0;
 2e6:	d9 ee                	fldz   
                for(i =s; i < e; i++){
 2e8:	89 85 e8 fb ff ff    	mov    %eax,-0x418(%ebp)
 2ee:	8b 85 a4 fb ff ff    	mov    -0x45c(%ebp),%eax
 2f4:	89 85 ec fb ff ff    	mov    %eax,-0x414(%ebp)
 2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 300:	8b 8d ec fb ff ff    	mov    -0x414(%ebp),%ecx
 306:	8d 42 2c             	lea    0x2c(%edx),%eax
 309:	d9 84 15 50 fc ff ff 	flds   -0x3b0(%ebp,%edx,1)
 310:	8d 5a 50             	lea    0x50(%edx),%ebx
 313:	89 85 dc fb ff ff    	mov    %eax,-0x424(%ebp)
 319:	01 ca                	add    %ecx,%edx
 31b:	89 95 d8 fb ff ff    	mov    %edx,-0x428(%ebp)
 321:	89 ca                	mov    %ecx,%edx
 323:	8b 8d e8 fb ff ff    	mov    -0x418(%ebp),%ecx
 329:	01 ca                	add    %ecx,%edx
                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
 32b:	8b 8d d8 fb ff ff    	mov    -0x428(%ebp),%ecx
 331:	01 fa                	add    %edi,%edx
 333:	01 f9                	add    %edi,%ecx
 335:	8d 76 00             	lea    0x0(%esi),%esi
                                u[i][j-1] + u[i][j+1])/4.0;
 338:	d9 84 05 28 fc ff ff 	flds   -0x3d8(%ebp,%eax,1)
                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
 33f:	d9 44 01 04          	flds   0x4(%ecx,%eax,1)
 343:	d8 44 02 04          	fadds  0x4(%edx,%eax,1)
 347:	d8 04 38             	fadds  (%eax,%edi,1)
                                u[i][j-1] + u[i][j+1])/4.0;
 34a:	d8 c1                	fadd   %st(1),%st
                        w[i][j] = ( u[i-1][j] + u[i+1][j]+
 34c:	d8 0d 88 0f 00 00    	fmuls  0xf88
 352:	d9 94 05 08 fe ff ff 	fsts   -0x1f8(%ebp,%eax,1)
                        if( fabsm(w[i][j] - u[i][j]) > diff )
 359:	de e2                	fsubp  %st,%st(2)
	if(a<0)
 35b:	d9 ee                	fldz   
 35d:	df ea                	fucomip %st(2),%st
 35f:	76 0f                	jbe    370 <main+0x370>
 361:	d9 c9                	fxch   %st(1)
	return -1*a;
 363:	d9 e0                	fchs   
 365:	eb 0b                	jmp    372 <main+0x372>
 367:	89 f6                	mov    %esi,%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 370:	d9 c9                	fxch   %st(1)
                            diff = fabsm(w[i][j]- u[i][j]);	
 372:	db ea                	fucomi %st(2),%st
 374:	da d2                	fcmovbe %st(2),%st
 376:	dd da                	fstp   %st(2)
 378:	83 c0 04             	add    $0x4,%eax
                    for(j =1 ; j < N-1; j++){
 37b:	39 d8                	cmp    %ebx,%eax
 37d:	75 b9                	jne    338 <main+0x338>
 37f:	dd d8                	fstp   %st(0)
 381:	83 ad ec fb ff ff 2c 	subl   $0x2c,-0x414(%ebp)
 388:	83 85 e8 fb ff ff 2c 	addl   $0x2c,-0x418(%ebp)
 38f:	8b 95 dc fb ff ff    	mov    -0x424(%ebp),%edx
                for(i =s; i < e; i++){
 395:	3b 95 cc fb ff ff    	cmp    -0x434(%ebp),%edx
 39b:	0f 85 5f ff ff ff    	jne    300 <main+0x300>
                send(pid,ppid,(void*)&val);
 3a1:	8d 85 04 fc ff ff    	lea    -0x3fc(%ebp),%eax
 3a7:	83 ec 04             	sub    $0x4,%esp
                float val=diff;
 3aa:	d9 9d 04 fc ff ff    	fstps  -0x3fc(%ebp)
                send(pid,ppid,(void*)&val);
 3b0:	50                   	push   %eax
 3b1:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
 3b7:	ff b5 e0 fb ff ff    	pushl  -0x420(%ebp)
 3bd:	e8 80 07 00 00       	call   b42 <send>
                recv((void*)&cmd);
 3c2:	8d 85 08 fc ff ff    	lea    -0x3f8(%ebp),%eax
 3c8:	89 04 24             	mov    %eax,(%esp)
 3cb:	e8 7a 07 00 00       	call   b4a <recv>
                if((int)cmd==0)
 3d0:	8b 8d 08 fc ff ff    	mov    -0x3f8(%ebp),%ecx
 3d6:	83 c4 10             	add    $0x10,%esp
 3d9:	85 c9                	test   %ecx,%ecx
 3db:	0f 84 1a 03 00 00    	je     6fb <main+0x6fb>
 3e1:	8b 8d 9c fb ff ff    	mov    -0x464(%ebp),%ecx
 3e7:	8b 9d a8 fb ff ff    	mov    -0x458(%ebp),%ebx
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	8d 51 24             	lea    0x24(%ecx),%edx
 3f3:	89 c8                	mov    %ecx,%eax
 3f5:	8d 76 00             	lea    0x0(%esi),%esi
                    for (j =1; j< N-1; j++) u[i][j] = w[i][j];
 3f8:	d9 04 06             	flds   (%esi,%eax,1)
 3fb:	83 c0 04             	add    $0x4,%eax
 3fe:	d9 5c 38 fc          	fstps  -0x4(%eax,%edi,1)
 402:	39 d0                	cmp    %edx,%eax
 404:	75 f2                	jne    3f8 <main+0x3f8>
 406:	83 c1 2c             	add    $0x2c,%ecx
                for (i =s; i< e; i++)	
 409:	39 d9                	cmp    %ebx,%ecx
 40b:	75 e3                	jne    3f0 <main+0x3f0>
                    if(k==0){
 40d:	8b 85 b4 fb ff ff    	mov    -0x44c(%ebp),%eax
 413:	85 c0                	test   %eax,%eax
 415:	0f 84 71 01 00 00    	je     58c <main+0x58c>
                    else if(k==P-1){
 41b:	83 bd b4 fb ff ff 02 	cmpl   $0x2,-0x44c(%ebp)
 422:	0f 84 04 02 00 00    	je     62c <main+0x62c>
 428:	8b 85 14 fc ff ff    	mov    -0x3ec(%ebp),%eax
 42e:	8b 9d 94 fb ff ff    	mov    -0x46c(%ebp),%ebx
 434:	89 85 d8 fb ff ff    	mov    %eax,-0x428(%ebp)
 43a:	8d 85 0c fc ff ff    	lea    -0x3f4(%ebp),%eax
 440:	89 85 ec fb ff ff    	mov    %eax,-0x414(%ebp)
 446:	8d 76 00             	lea    0x0(%esi),%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                            msg1.senderid=pid;
 450:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
                            send(pid,recids[k-1],(void*)&msg1);
 456:	83 ec 04             	sub    $0x4,%esp
                            msg1.val=u[s][j];
 459:	d9 03                	flds   (%ebx)
                            send(pid,recids[k-1],(void*)&msg1);
 45b:	ff b5 ec fb ff ff    	pushl  -0x414(%ebp)
 461:	ff b5 d8 fb ff ff    	pushl  -0x428(%ebp)
 467:	83 c3 04             	add    $0x4,%ebx
                            msg1.val=u[s][j];
 46a:	d9 9d 10 fc ff ff    	fstps  -0x3f0(%ebp)
                            send(pid,recids[k-1],(void*)&msg1);
 470:	50                   	push   %eax
                            msg1.senderid=pid;
 471:	89 85 0c fc ff ff    	mov    %eax,-0x3f4(%ebp)
                            send(pid,recids[k-1],(void*)&msg1);
 477:	e8 c6 06 00 00       	call   b42 <send>
                        for(j=1;j<N-1;j++)
 47c:	83 c4 10             	add    $0x10,%esp
 47f:	3b 9d c8 fb ff ff    	cmp    -0x438(%ebp),%ebx
 485:	75 c9                	jne    450 <main+0x450>
                        int t=0;
 487:	c7 85 dc fb ff ff 00 	movl   $0x0,-0x424(%ebp)
 48e:	00 00 00 
                        for(j=0;j<2*N-4;j++)
 491:	31 db                	xor    %ebx,%ebx
                    int other_id=-1;
 493:	c7 85 e8 fb ff ff ff 	movl   $0xffffffff,-0x418(%ebp)
 49a:	ff ff ff 
 49d:	eb 3f                	jmp    4de <main+0x4de>
 49f:	90                   	nop
                            if(msg1.senderid==recids[k-1])
 4a0:	8b 85 d8 fb ff ff    	mov    -0x428(%ebp),%eax
 4a6:	39 85 0c fc ff ff    	cmp    %eax,-0x3f4(%ebp)
 4ac:	74 62                	je     510 <main+0x510>
                                u[e][j-t+1]=msg1.val;
 4ae:	8b 85 d0 fb ff ff    	mov    -0x430(%ebp),%eax
 4b4:	8b 95 c4 fb ff ff    	mov    -0x43c(%ebp),%edx
 4ba:	89 d9                	mov    %ebx,%ecx
 4bc:	2b 8d dc fb ff ff    	sub    -0x424(%ebp),%ecx
 4c2:	d9 85 10 fc ff ff    	flds   -0x3f0(%ebp)
                        for(j=0;j<2*N-4;j++)
 4c8:	83 c3 01             	add    $0x1,%ebx
 4cb:	83 fb 12             	cmp    $0x12,%ebx
                                u[e][j-t+1]=msg1.val;
 4ce:	8d 04 50             	lea    (%eax,%edx,2),%eax
 4d1:	8d 44 01 01          	lea    0x1(%ecx,%eax,1),%eax
 4d5:	d9 9c 85 20 fc ff ff 	fstps  -0x3e0(%ebp,%eax,4)
                        for(j=0;j<2*N-4;j++)
 4dc:	74 62                	je     540 <main+0x540>
                            recv((void*)&msg1);
 4de:	83 ec 0c             	sub    $0xc,%esp
 4e1:	ff b5 ec fb ff ff    	pushl  -0x414(%ebp)
 4e7:	e8 5e 06 00 00       	call   b4a <recv>
                            if(other_id==-1&&msg1.senderid!=recids[k-1])
 4ec:	83 c4 10             	add    $0x10,%esp
 4ef:	83 bd e8 fb ff ff ff 	cmpl   $0xffffffff,-0x418(%ebp)
 4f6:	75 a8                	jne    4a0 <main+0x4a0>
 4f8:	8b 85 0c fc ff ff    	mov    -0x3f4(%ebp),%eax
 4fe:	3b 85 d8 fb ff ff    	cmp    -0x428(%ebp),%eax
 504:	74 0a                	je     510 <main+0x510>
 506:	89 85 e8 fb ff ff    	mov    %eax,-0x418(%ebp)
 50c:	eb a0                	jmp    4ae <main+0x4ae>
 50e:	66 90                	xchg   %ax,%ax
                                u[s-1][t+1]=msg1.val;
 510:	8b 95 bc fb ff ff    	mov    -0x444(%ebp),%edx
 516:	83 85 dc fb ff ff 01 	addl   $0x1,-0x424(%ebp)
                        for(j=0;j<2*N-4;j++)
 51d:	83 c3 01             	add    $0x1,%ebx
                                u[s-1][t+1]=msg1.val;
 520:	8b 8d dc fb ff ff    	mov    -0x424(%ebp),%ecx
 526:	d9 85 10 fc ff ff    	flds   -0x3f0(%ebp)
 52c:	8d 04 92             	lea    (%edx,%edx,4),%eax
 52f:	8d 04 42             	lea    (%edx,%eax,2),%eax
 532:	01 c8                	add    %ecx,%eax
                        for(j=0;j<2*N-4;j++)
 534:	83 fb 12             	cmp    $0x12,%ebx
                                u[s-1][t+1]=msg1.val;
 537:	d9 9c 85 20 fc ff ff 	fstps  -0x3e0(%ebp,%eax,4)
                        for(j=0;j<2*N-4;j++)
 53e:	75 9e                	jne    4de <main+0x4de>
 540:	8b 95 98 fb ff ff    	mov    -0x468(%ebp),%edx
 546:	89 d3                	mov    %edx,%ebx
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                            msg1.senderid=pid;
 550:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
                            send(pid,other_id,(void*)&msg1);
 556:	83 ec 04             	sub    $0x4,%esp
                            msg1.val=u[e-1][j];
 559:	d9 03                	flds   (%ebx)
                            send(pid,other_id,(void*)&msg1);
 55b:	ff b5 ec fb ff ff    	pushl  -0x414(%ebp)
 561:	ff b5 e8 fb ff ff    	pushl  -0x418(%ebp)
 567:	83 c3 04             	add    $0x4,%ebx
                            msg1.val=u[e-1][j];
 56a:	d9 9d 10 fc ff ff    	fstps  -0x3f0(%ebp)
                            send(pid,other_id,(void*)&msg1);
 570:	50                   	push   %eax
                            msg1.senderid=pid;
 571:	89 85 0c fc ff ff    	mov    %eax,-0x3f4(%ebp)
                            send(pid,other_id,(void*)&msg1);
 577:	e8 c6 05 00 00       	call   b42 <send>
                        for(j=1;j<N-1;j++)
 57c:	83 c4 10             	add    $0x10,%esp
 57f:	3b 9d d4 fb ff ff    	cmp    -0x42c(%ebp),%ebx
 585:	75 c9                	jne    550 <main+0x550>
 587:	e9 3c fd ff ff       	jmp    2c8 <main+0x2c8>
 58c:	8d 85 0c fc ff ff    	lea    -0x3f4(%ebp),%eax
 592:	8b 95 90 fb ff ff    	mov    -0x470(%ebp),%edx
                    int other_id=-1;
 598:	83 cb ff             	or     $0xffffffff,%ebx
 59b:	89 85 ec fb ff ff    	mov    %eax,-0x414(%ebp)
 5a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                            recv((void*)&msg1);
 5a8:	83 ec 0c             	sub    $0xc,%esp
 5ab:	ff b5 ec fb ff ff    	pushl  -0x414(%ebp)
 5b1:	89 95 e8 fb ff ff    	mov    %edx,-0x418(%ebp)
 5b7:	e8 8e 05 00 00       	call   b4a <recv>
                            u[e][j]=msg1.val;
 5bc:	8b 95 e8 fb ff ff    	mov    -0x418(%ebp),%edx
 5c2:	d9 85 10 fc ff ff    	flds   -0x3f0(%ebp)
                            if(other_id==-1)
 5c8:	83 c4 10             	add    $0x10,%esp
                                other_id=msg1.senderid;
 5cb:	83 fb ff             	cmp    $0xffffffff,%ebx
 5ce:	0f 44 9d 0c fc ff ff 	cmove  -0x3f4(%ebp),%ebx
                            u[e][j]=msg1.val;
 5d5:	d9 1a                	fstps  (%edx)
 5d7:	83 c2 04             	add    $0x4,%edx
                        for(j=1;j<N-1;j++)
 5da:	3b 95 c0 fb ff ff    	cmp    -0x440(%ebp),%edx
 5e0:	75 c6                	jne    5a8 <main+0x5a8>
 5e2:	8b 95 98 fb ff ff    	mov    -0x468(%ebp),%edx
 5e8:	89 9d e8 fb ff ff    	mov    %ebx,-0x418(%ebp)
 5ee:	89 d3                	mov    %edx,%ebx
                            msg1.senderid=pid;
 5f0:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
                            send(pid,other_id,(void*)&msg1);
 5f6:	83 ec 04             	sub    $0x4,%esp
                            msg1.val=u[e-1][j];
 5f9:	d9 03                	flds   (%ebx)
                            send(pid,other_id,(void*)&msg1);
 5fb:	ff b5 ec fb ff ff    	pushl  -0x414(%ebp)
 601:	ff b5 e8 fb ff ff    	pushl  -0x418(%ebp)
 607:	83 c3 04             	add    $0x4,%ebx
                            msg1.val=u[e-1][j];
 60a:	d9 9d 10 fc ff ff    	fstps  -0x3f0(%ebp)
                            send(pid,other_id,(void*)&msg1);
 610:	50                   	push   %eax
                            msg1.senderid=pid;
 611:	89 85 0c fc ff ff    	mov    %eax,-0x3f4(%ebp)
                            send(pid,other_id,(void*)&msg1);
 617:	e8 26 05 00 00       	call   b42 <send>
                        for(j=1;j<N-1;j++)
 61c:	83 c4 10             	add    $0x10,%esp
 61f:	3b 9d d4 fb ff ff    	cmp    -0x42c(%ebp),%ebx
 625:	75 c9                	jne    5f0 <main+0x5f0>
 627:	e9 9c fc ff ff       	jmp    2c8 <main+0x2c8>
 62c:	8b 85 18 fc ff ff    	mov    -0x3e8(%ebp),%eax
                    else if(k==P-1){
 632:	8b 9d 94 fb ff ff    	mov    -0x46c(%ebp),%ebx
 638:	89 85 e8 fb ff ff    	mov    %eax,-0x418(%ebp)
 63e:	8d 85 0c fc ff ff    	lea    -0x3f4(%ebp),%eax
 644:	89 85 ec fb ff ff    	mov    %eax,-0x414(%ebp)
 64a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                            msg1.senderid=pid;
 650:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
                            send(pid,recids[k-1],(void*)&msg1);
 656:	83 ec 04             	sub    $0x4,%esp
                            msg1.val=u[s][j];
 659:	d9 03                	flds   (%ebx)
                            send(pid,recids[k-1],(void*)&msg1);
 65b:	ff b5 ec fb ff ff    	pushl  -0x414(%ebp)
 661:	ff b5 e8 fb ff ff    	pushl  -0x418(%ebp)
 667:	83 c3 04             	add    $0x4,%ebx
                            msg1.val=u[s][j];
 66a:	d9 9d 10 fc ff ff    	fstps  -0x3f0(%ebp)
                            send(pid,recids[k-1],(void*)&msg1);
 670:	50                   	push   %eax
                            msg1.senderid=pid;
 671:	89 85 0c fc ff ff    	mov    %eax,-0x3f4(%ebp)
                            send(pid,recids[k-1],(void*)&msg1);
 677:	e8 c6 04 00 00       	call   b42 <send>
                        for(j=1;j<N-1;j++)
 67c:	83 c4 10             	add    $0x10,%esp
 67f:	3b 9d c8 fb ff ff    	cmp    -0x438(%ebp),%ebx
 685:	75 c9                	jne    650 <main+0x650>
 687:	8b 9d 8c fb ff ff    	mov    -0x474(%ebp),%ebx
 68d:	8d 76 00             	lea    0x0(%esi),%esi
                            recv((void*)&msg1);
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	ff b5 ec fb ff ff    	pushl  -0x414(%ebp)
 699:	83 c3 04             	add    $0x4,%ebx
 69c:	e8 a9 04 00 00       	call   b4a <recv>
                            u[s-1][j]=msg1.val;
 6a1:	d9 85 10 fc ff ff    	flds   -0x3f0(%ebp)
                        for(j=1;j<N-1;j++)
 6a7:	83 c4 10             	add    $0x10,%esp
                            u[s-1][j]=msg1.val;
 6aa:	d9 5b fc             	fstps  -0x4(%ebx)
                        for(j=1;j<N-1;j++)
 6ad:	3b 9d b8 fb ff ff    	cmp    -0x448(%ebp),%ebx
 6b3:	75 db                	jne    690 <main+0x690>
 6b5:	e9 0e fc ff ff       	jmp    2c8 <main+0x2c8>
                send(pid,ppid,(void*)&val);
 6ba:	8d 85 04 fc ff ff    	lea    -0x3fc(%ebp),%eax
 6c0:	52                   	push   %edx
                float val=diff;
 6c1:	c7 85 04 fc ff ff 00 	movl   $0x0,-0x3fc(%ebp)
 6c8:	00 00 00 
                send(pid,ppid,(void*)&val);
 6cb:	50                   	push   %eax
 6cc:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
 6d2:	ff b5 e0 fb ff ff    	pushl  -0x420(%ebp)
 6d8:	e8 65 04 00 00       	call   b42 <send>
                recv((void*)&cmd);
 6dd:	8d 85 08 fc ff ff    	lea    -0x3f8(%ebp),%eax
 6e3:	89 04 24             	mov    %eax,(%esp)
 6e6:	e8 5f 04 00 00       	call   b4a <recv>
                if((int)cmd==0)
 6eb:	83 c4 10             	add    $0x10,%esp
 6ee:	83 bd 08 fc ff ff 00 	cmpl   $0x0,-0x3f8(%ebp)
 6f5:	0f 85 12 fd ff ff    	jne    40d <main+0x40d>
                    if(k==0)
 6fb:	83 bd b4 fb ff ff 00 	cmpl   $0x0,-0x44c(%ebp)
 702:	0f 85 9e 00 00 00    	jne    7a6 <main+0x7a6>
                        ns=ns-1;
 708:	8b 85 bc fb ff ff    	mov    -0x444(%ebp),%eax
 70e:	89 85 b0 fb ff ff    	mov    %eax,-0x450(%ebp)
                    for(i =ns; i <ne; i++){
 714:	8b 85 d0 fb ff ff    	mov    -0x430(%ebp),%eax
 71a:	8b b5 b0 fb ff ff    	mov    -0x450(%ebp),%esi
 720:	39 f0                	cmp    %esi,%eax
 722:	0f 8e 9e fa ff ff    	jle    1c6 <main+0x1c6>
 728:	6b de 2c             	imul   $0x2c,%esi,%ebx
 72b:	6b c0 2c             	imul   $0x2c,%eax,%eax
 72e:	01 fb                	add    %edi,%ebx
 730:	01 c7                	add    %eax,%edi
 732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 738:	8d 73 2c             	lea    0x2c(%ebx),%esi
 73b:	90                   	nop
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                            printf(1,"%d ",((int)u[i][j]));
 740:	d9 03                	flds   (%ebx)
 742:	d9 bd f6 fb ff ff    	fnstcw -0x40a(%ebp)
 748:	0f b7 85 f6 fb ff ff 	movzwl -0x40a(%ebp),%eax
 74f:	83 ec 04             	sub    $0x4,%esp
 752:	83 c3 04             	add    $0x4,%ebx
 755:	80 cc 0c             	or     $0xc,%ah
 758:	66 89 85 f4 fb ff ff 	mov    %ax,-0x40c(%ebp)
 75f:	d9 ad f4 fb ff ff    	fldcw  -0x40c(%ebp)
 765:	db 9d f0 fb ff ff    	fistpl -0x410(%ebp)
 76b:	d9 ad f6 fb ff ff    	fldcw  -0x40a(%ebp)
 771:	8b 85 f0 fb ff ff    	mov    -0x410(%ebp),%eax
 777:	50                   	push   %eax
 778:	68 78 0f 00 00       	push   $0xf78
 77d:	6a 01                	push   $0x1
 77f:	e8 9c 04 00 00       	call   c20 <printf>
                        for(j = 0; j<N; j++)
 784:	83 c4 10             	add    $0x10,%esp
 787:	39 f3                	cmp    %esi,%ebx
 789:	75 b5                	jne    740 <main+0x740>
                        printf(1,"\n");
 78b:	83 ec 08             	sub    $0x8,%esp
 78e:	68 7c 0f 00 00       	push   $0xf7c
 793:	6a 01                	push   $0x1
 795:	e8 86 04 00 00       	call   c20 <printf>
                    for(i =ns; i <ne; i++){
 79a:	83 c4 10             	add    $0x10,%esp
 79d:	39 df                	cmp    %ebx,%edi
 79f:	75 97                	jne    738 <main+0x738>
 7a1:	e9 20 fa ff ff       	jmp    1c6 <main+0x1c6>
                    if(k==P-1)
 7a6:	83 bd b4 fb ff ff 02 	cmpl   $0x2,-0x44c(%ebp)
 7ad:	0f 85 61 ff ff ff    	jne    714 <main+0x714>
                        ne=ne+1;
 7b3:	83 85 d0 fb ff ff 01 	addl   $0x1,-0x430(%ebp)
 7ba:	e9 55 ff ff ff       	jmp    714 <main+0x714>
 7bf:	90                   	nop

000007c0 <fabsm>:
float fabsm(float a){
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	d9 45 08             	flds   0x8(%ebp)
	if(a<0)
 7c6:	d9 ee                	fldz   
 7c8:	df e9                	fucomip %st(1),%st
 7ca:	77 04                	ja     7d0 <fabsm+0x10>
}
 7cc:	5d                   	pop    %ebp
 7cd:	c3                   	ret    
 7ce:	66 90                	xchg   %ax,%ax
	return -1*a;
 7d0:	d9 e0                	fchs   
}
 7d2:	5d                   	pop    %ebp
 7d3:	c3                   	ret    
 7d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007e0 <scheduler>:
void scheduler() {
 7e0:	55                   	push   %ebp
    nWorkers = P;
 7e1:	c7 05 a8 12 00 00 03 	movl   $0x3,0x12a8
 7e8:	00 00 00 
        works[i][0]=i*slice+1;
 7eb:	c7 05 ac 12 00 00 01 	movl   $0x1,0x12ac
 7f2:	00 00 00 
        works[i][1]=(i+1)*slice+1;
 7f5:	c7 05 b0 12 00 00 04 	movl   $0x4,0x12b0
 7fc:	00 00 00 
void scheduler() {
 7ff:	89 e5                	mov    %esp,%ebp
        works[i][0]=i*slice+1;
 801:	c7 05 b4 12 00 00 04 	movl   $0x4,0x12b4
 808:	00 00 00 
        works[i][1]=(i+1)*slice+1;
 80b:	c7 05 b8 12 00 00 07 	movl   $0x7,0x12b8
 812:	00 00 00 
        works[i][0]=i*slice+1;
 815:	c7 05 bc 12 00 00 07 	movl   $0x7,0x12bc
 81c:	00 00 00 
        works[i][1]=(i+1)*slice+1;
 81f:	c7 05 c0 12 00 00 0a 	movl   $0xa,0x12c0
 826:	00 00 00 
}
 829:	5d                   	pop    %ebp
 82a:	c3                   	ret    
 82b:	66 90                	xchg   %ax,%ax
 82d:	66 90                	xchg   %ax,%ax
 82f:	90                   	nop

00000830 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	53                   	push   %ebx
 834:	8b 45 08             	mov    0x8(%ebp),%eax
 837:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 83a:	89 c2                	mov    %eax,%edx
 83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 840:	83 c1 01             	add    $0x1,%ecx
 843:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 847:	83 c2 01             	add    $0x1,%edx
 84a:	84 db                	test   %bl,%bl
 84c:	88 5a ff             	mov    %bl,-0x1(%edx)
 84f:	75 ef                	jne    840 <strcpy+0x10>
    ;
  return os;
}
 851:	5b                   	pop    %ebx
 852:	5d                   	pop    %ebp
 853:	c3                   	ret    
 854:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 85a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000860 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	53                   	push   %ebx
 864:	8b 55 08             	mov    0x8(%ebp),%edx
 867:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 86a:	0f b6 02             	movzbl (%edx),%eax
 86d:	0f b6 19             	movzbl (%ecx),%ebx
 870:	84 c0                	test   %al,%al
 872:	75 1c                	jne    890 <strcmp+0x30>
 874:	eb 2a                	jmp    8a0 <strcmp+0x40>
 876:	8d 76 00             	lea    0x0(%esi),%esi
 879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 880:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 883:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 886:	83 c1 01             	add    $0x1,%ecx
 889:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 88c:	84 c0                	test   %al,%al
 88e:	74 10                	je     8a0 <strcmp+0x40>
 890:	38 d8                	cmp    %bl,%al
 892:	74 ec                	je     880 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 894:	29 d8                	sub    %ebx,%eax
}
 896:	5b                   	pop    %ebx
 897:	5d                   	pop    %ebp
 898:	c3                   	ret    
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 8a2:	29 d8                	sub    %ebx,%eax
}
 8a4:	5b                   	pop    %ebx
 8a5:	5d                   	pop    %ebp
 8a6:	c3                   	ret    
 8a7:	89 f6                	mov    %esi,%esi
 8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008b0 <strlen>:

uint
strlen(const char *s)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 8b6:	80 39 00             	cmpb   $0x0,(%ecx)
 8b9:	74 15                	je     8d0 <strlen+0x20>
 8bb:	31 d2                	xor    %edx,%edx
 8bd:	8d 76 00             	lea    0x0(%esi),%esi
 8c0:	83 c2 01             	add    $0x1,%edx
 8c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 8c7:	89 d0                	mov    %edx,%eax
 8c9:	75 f5                	jne    8c0 <strlen+0x10>
    ;
  return n;
}
 8cb:	5d                   	pop    %ebp
 8cc:	c3                   	ret    
 8cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 8d0:	31 c0                	xor    %eax,%eax
}
 8d2:	5d                   	pop    %ebp
 8d3:	c3                   	ret    
 8d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000008e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	57                   	push   %edi
 8e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 8e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 8ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 8ed:	89 d7                	mov    %edx,%edi
 8ef:	fc                   	cld    
 8f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 8f2:	89 d0                	mov    %edx,%eax
 8f4:	5f                   	pop    %edi
 8f5:	5d                   	pop    %ebp
 8f6:	c3                   	ret    
 8f7:	89 f6                	mov    %esi,%esi
 8f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000900 <strchr>:

char*
strchr(const char *s, char c)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	53                   	push   %ebx
 904:	8b 45 08             	mov    0x8(%ebp),%eax
 907:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 90a:	0f b6 10             	movzbl (%eax),%edx
 90d:	84 d2                	test   %dl,%dl
 90f:	74 1d                	je     92e <strchr+0x2e>
    if(*s == c)
 911:	38 d3                	cmp    %dl,%bl
 913:	89 d9                	mov    %ebx,%ecx
 915:	75 0d                	jne    924 <strchr+0x24>
 917:	eb 17                	jmp    930 <strchr+0x30>
 919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 920:	38 ca                	cmp    %cl,%dl
 922:	74 0c                	je     930 <strchr+0x30>
  for(; *s; s++)
 924:	83 c0 01             	add    $0x1,%eax
 927:	0f b6 10             	movzbl (%eax),%edx
 92a:	84 d2                	test   %dl,%dl
 92c:	75 f2                	jne    920 <strchr+0x20>
      return (char*)s;
  return 0;
 92e:	31 c0                	xor    %eax,%eax
}
 930:	5b                   	pop    %ebx
 931:	5d                   	pop    %ebp
 932:	c3                   	ret    
 933:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000940 <gets>:

char*
gets(char *buf, int max)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	57                   	push   %edi
 944:	56                   	push   %esi
 945:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 946:	31 f6                	xor    %esi,%esi
 948:	89 f3                	mov    %esi,%ebx
{
 94a:	83 ec 1c             	sub    $0x1c,%esp
 94d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 950:	eb 2f                	jmp    981 <gets+0x41>
 952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 958:	8d 45 e7             	lea    -0x19(%ebp),%eax
 95b:	83 ec 04             	sub    $0x4,%esp
 95e:	6a 01                	push   $0x1
 960:	50                   	push   %eax
 961:	6a 00                	push   $0x0
 963:	e8 32 01 00 00       	call   a9a <read>
    if(cc < 1)
 968:	83 c4 10             	add    $0x10,%esp
 96b:	85 c0                	test   %eax,%eax
 96d:	7e 1c                	jle    98b <gets+0x4b>
      break;
    buf[i++] = c;
 96f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 973:	83 c7 01             	add    $0x1,%edi
 976:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 979:	3c 0a                	cmp    $0xa,%al
 97b:	74 23                	je     9a0 <gets+0x60>
 97d:	3c 0d                	cmp    $0xd,%al
 97f:	74 1f                	je     9a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 981:	83 c3 01             	add    $0x1,%ebx
 984:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 987:	89 fe                	mov    %edi,%esi
 989:	7c cd                	jl     958 <gets+0x18>
 98b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 98d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 990:	c6 03 00             	movb   $0x0,(%ebx)
}
 993:	8d 65 f4             	lea    -0xc(%ebp),%esp
 996:	5b                   	pop    %ebx
 997:	5e                   	pop    %esi
 998:	5f                   	pop    %edi
 999:	5d                   	pop    %ebp
 99a:	c3                   	ret    
 99b:	90                   	nop
 99c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9a0:	8b 75 08             	mov    0x8(%ebp),%esi
 9a3:	8b 45 08             	mov    0x8(%ebp),%eax
 9a6:	01 de                	add    %ebx,%esi
 9a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 9aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 9ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9b0:	5b                   	pop    %ebx
 9b1:	5e                   	pop    %esi
 9b2:	5f                   	pop    %edi
 9b3:	5d                   	pop    %ebp
 9b4:	c3                   	ret    
 9b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	56                   	push   %esi
 9c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9c5:	83 ec 08             	sub    $0x8,%esp
 9c8:	6a 00                	push   $0x0
 9ca:	ff 75 08             	pushl  0x8(%ebp)
 9cd:	e8 f0 00 00 00       	call   ac2 <open>
  if(fd < 0)
 9d2:	83 c4 10             	add    $0x10,%esp
 9d5:	85 c0                	test   %eax,%eax
 9d7:	78 27                	js     a00 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 9d9:	83 ec 08             	sub    $0x8,%esp
 9dc:	ff 75 0c             	pushl  0xc(%ebp)
 9df:	89 c3                	mov    %eax,%ebx
 9e1:	50                   	push   %eax
 9e2:	e8 f3 00 00 00       	call   ada <fstat>
  close(fd);
 9e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 9ea:	89 c6                	mov    %eax,%esi
  close(fd);
 9ec:	e8 b9 00 00 00       	call   aaa <close>
  return r;
 9f1:	83 c4 10             	add    $0x10,%esp
}
 9f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 9f7:	89 f0                	mov    %esi,%eax
 9f9:	5b                   	pop    %ebx
 9fa:	5e                   	pop    %esi
 9fb:	5d                   	pop    %ebp
 9fc:	c3                   	ret    
 9fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 a00:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a05:	eb ed                	jmp    9f4 <stat+0x34>
 a07:	89 f6                	mov    %esi,%esi
 a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a10 <atoi>:

int
atoi(const char *s)
{
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
 a13:	53                   	push   %ebx
 a14:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a17:	0f be 11             	movsbl (%ecx),%edx
 a1a:	8d 42 d0             	lea    -0x30(%edx),%eax
 a1d:	3c 09                	cmp    $0x9,%al
  n = 0;
 a1f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 a24:	77 1f                	ja     a45 <atoi+0x35>
 a26:	8d 76 00             	lea    0x0(%esi),%esi
 a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 a30:	8d 04 80             	lea    (%eax,%eax,4),%eax
 a33:	83 c1 01             	add    $0x1,%ecx
 a36:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 a3a:	0f be 11             	movsbl (%ecx),%edx
 a3d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 a40:	80 fb 09             	cmp    $0x9,%bl
 a43:	76 eb                	jbe    a30 <atoi+0x20>
  return n;
}
 a45:	5b                   	pop    %ebx
 a46:	5d                   	pop    %ebp
 a47:	c3                   	ret    
 a48:	90                   	nop
 a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a50 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	56                   	push   %esi
 a54:	53                   	push   %ebx
 a55:	8b 5d 10             	mov    0x10(%ebp),%ebx
 a58:	8b 45 08             	mov    0x8(%ebp),%eax
 a5b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 a5e:	85 db                	test   %ebx,%ebx
 a60:	7e 14                	jle    a76 <memmove+0x26>
 a62:	31 d2                	xor    %edx,%edx
 a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 a68:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 a6c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 a6f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 a72:	39 d3                	cmp    %edx,%ebx
 a74:	75 f2                	jne    a68 <memmove+0x18>
  return vdst;
}
 a76:	5b                   	pop    %ebx
 a77:	5e                   	pop    %esi
 a78:	5d                   	pop    %ebp
 a79:	c3                   	ret    

00000a7a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 a7a:	b8 01 00 00 00       	mov    $0x1,%eax
 a7f:	cd 40                	int    $0x40
 a81:	c3                   	ret    

00000a82 <exit>:
SYSCALL(exit)
 a82:	b8 02 00 00 00       	mov    $0x2,%eax
 a87:	cd 40                	int    $0x40
 a89:	c3                   	ret    

00000a8a <wait>:
SYSCALL(wait)
 a8a:	b8 03 00 00 00       	mov    $0x3,%eax
 a8f:	cd 40                	int    $0x40
 a91:	c3                   	ret    

00000a92 <pipe>:
SYSCALL(pipe)
 a92:	b8 04 00 00 00       	mov    $0x4,%eax
 a97:	cd 40                	int    $0x40
 a99:	c3                   	ret    

00000a9a <read>:
SYSCALL(read)
 a9a:	b8 05 00 00 00       	mov    $0x5,%eax
 a9f:	cd 40                	int    $0x40
 aa1:	c3                   	ret    

00000aa2 <write>:
SYSCALL(write)
 aa2:	b8 10 00 00 00       	mov    $0x10,%eax
 aa7:	cd 40                	int    $0x40
 aa9:	c3                   	ret    

00000aaa <close>:
SYSCALL(close)
 aaa:	b8 15 00 00 00       	mov    $0x15,%eax
 aaf:	cd 40                	int    $0x40
 ab1:	c3                   	ret    

00000ab2 <kill>:
SYSCALL(kill)
 ab2:	b8 06 00 00 00       	mov    $0x6,%eax
 ab7:	cd 40                	int    $0x40
 ab9:	c3                   	ret    

00000aba <exec>:
SYSCALL(exec)
 aba:	b8 07 00 00 00       	mov    $0x7,%eax
 abf:	cd 40                	int    $0x40
 ac1:	c3                   	ret    

00000ac2 <open>:
SYSCALL(open)
 ac2:	b8 0f 00 00 00       	mov    $0xf,%eax
 ac7:	cd 40                	int    $0x40
 ac9:	c3                   	ret    

00000aca <mknod>:
SYSCALL(mknod)
 aca:	b8 11 00 00 00       	mov    $0x11,%eax
 acf:	cd 40                	int    $0x40
 ad1:	c3                   	ret    

00000ad2 <unlink>:
SYSCALL(unlink)
 ad2:	b8 12 00 00 00       	mov    $0x12,%eax
 ad7:	cd 40                	int    $0x40
 ad9:	c3                   	ret    

00000ada <fstat>:
SYSCALL(fstat)
 ada:	b8 08 00 00 00       	mov    $0x8,%eax
 adf:	cd 40                	int    $0x40
 ae1:	c3                   	ret    

00000ae2 <link>:
SYSCALL(link)
 ae2:	b8 13 00 00 00       	mov    $0x13,%eax
 ae7:	cd 40                	int    $0x40
 ae9:	c3                   	ret    

00000aea <mkdir>:
SYSCALL(mkdir)
 aea:	b8 14 00 00 00       	mov    $0x14,%eax
 aef:	cd 40                	int    $0x40
 af1:	c3                   	ret    

00000af2 <chdir>:
SYSCALL(chdir)
 af2:	b8 09 00 00 00       	mov    $0x9,%eax
 af7:	cd 40                	int    $0x40
 af9:	c3                   	ret    

00000afa <dup>:
SYSCALL(dup)
 afa:	b8 0a 00 00 00       	mov    $0xa,%eax
 aff:	cd 40                	int    $0x40
 b01:	c3                   	ret    

00000b02 <getpid>:
SYSCALL(getpid)
 b02:	b8 0b 00 00 00       	mov    $0xb,%eax
 b07:	cd 40                	int    $0x40
 b09:	c3                   	ret    

00000b0a <sbrk>:
SYSCALL(sbrk)
 b0a:	b8 0c 00 00 00       	mov    $0xc,%eax
 b0f:	cd 40                	int    $0x40
 b11:	c3                   	ret    

00000b12 <sleep>:
SYSCALL(sleep)
 b12:	b8 0d 00 00 00       	mov    $0xd,%eax
 b17:	cd 40                	int    $0x40
 b19:	c3                   	ret    

00000b1a <uptime>:
SYSCALL(uptime)
 b1a:	b8 0e 00 00 00       	mov    $0xe,%eax
 b1f:	cd 40                	int    $0x40
 b21:	c3                   	ret    

00000b22 <toggle>:
SYSCALL(toggle)
 b22:	b8 16 00 00 00       	mov    $0x16,%eax
 b27:	cd 40                	int    $0x40
 b29:	c3                   	ret    

00000b2a <print_count>:
SYSCALL(print_count)
 b2a:	b8 17 00 00 00       	mov    $0x17,%eax
 b2f:	cd 40                	int    $0x40
 b31:	c3                   	ret    

00000b32 <add>:
SYSCALL(add)
 b32:	b8 18 00 00 00       	mov    $0x18,%eax
 b37:	cd 40                	int    $0x40
 b39:	c3                   	ret    

00000b3a <ps>:
SYSCALL(ps)
 b3a:	b8 19 00 00 00       	mov    $0x19,%eax
 b3f:	cd 40                	int    $0x40
 b41:	c3                   	ret    

00000b42 <send>:
SYSCALL(send)
 b42:	b8 1a 00 00 00       	mov    $0x1a,%eax
 b47:	cd 40                	int    $0x40
 b49:	c3                   	ret    

00000b4a <recv>:
SYSCALL(recv)
 b4a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 b4f:	cd 40                	int    $0x40
 b51:	c3                   	ret    

00000b52 <sigset>:
SYSCALL(sigset)
 b52:	b8 1c 00 00 00       	mov    $0x1c,%eax
 b57:	cd 40                	int    $0x40
 b59:	c3                   	ret    

00000b5a <sigsend>:
SYSCALL(sigsend)
 b5a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 b5f:	cd 40                	int    $0x40
 b61:	c3                   	ret    

00000b62 <sigret>:
SYSCALL(sigret)
 b62:	b8 1e 00 00 00       	mov    $0x1e,%eax
 b67:	cd 40                	int    $0x40
 b69:	c3                   	ret    

00000b6a <sigpause>:
SYSCALL(sigpause)
 b6a:	b8 1f 00 00 00       	mov    $0x1f,%eax
 b6f:	cd 40                	int    $0x40
 b71:	c3                   	ret    

00000b72 <send_multi>:
SYSCALL(send_multi)
 b72:	b8 20 00 00 00       	mov    $0x20,%eax
 b77:	cd 40                	int    $0x40
 b79:	c3                   	ret    
 b7a:	66 90                	xchg   %ax,%ax
 b7c:	66 90                	xchg   %ax,%ax
 b7e:	66 90                	xchg   %ax,%ax

00000b80 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 b80:	55                   	push   %ebp
 b81:	89 e5                	mov    %esp,%ebp
 b83:	57                   	push   %edi
 b84:	56                   	push   %esi
 b85:	53                   	push   %ebx
 b86:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 b89:	85 d2                	test   %edx,%edx
{
 b8b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 b8e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 b90:	79 76                	jns    c08 <printint+0x88>
 b92:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 b96:	74 70                	je     c08 <printint+0x88>
    x = -xx;
 b98:	f7 d8                	neg    %eax
    neg = 1;
 b9a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 ba1:	31 f6                	xor    %esi,%esi
 ba3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 ba6:	eb 0a                	jmp    bb2 <printint+0x32>
 ba8:	90                   	nop
 ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 bb0:	89 fe                	mov    %edi,%esi
 bb2:	31 d2                	xor    %edx,%edx
 bb4:	8d 7e 01             	lea    0x1(%esi),%edi
 bb7:	f7 f1                	div    %ecx
 bb9:	0f b6 92 a0 0f 00 00 	movzbl 0xfa0(%edx),%edx
  }while((x /= base) != 0);
 bc0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 bc2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 bc5:	75 e9                	jne    bb0 <printint+0x30>
  if(neg)
 bc7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 bca:	85 c0                	test   %eax,%eax
 bcc:	74 08                	je     bd6 <printint+0x56>
    buf[i++] = '-';
 bce:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 bd3:	8d 7e 02             	lea    0x2(%esi),%edi
 bd6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 bda:	8b 7d c0             	mov    -0x40(%ebp),%edi
 bdd:	8d 76 00             	lea    0x0(%esi),%esi
 be0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 be3:	83 ec 04             	sub    $0x4,%esp
 be6:	83 ee 01             	sub    $0x1,%esi
 be9:	6a 01                	push   $0x1
 beb:	53                   	push   %ebx
 bec:	57                   	push   %edi
 bed:	88 45 d7             	mov    %al,-0x29(%ebp)
 bf0:	e8 ad fe ff ff       	call   aa2 <write>

  while(--i >= 0)
 bf5:	83 c4 10             	add    $0x10,%esp
 bf8:	39 de                	cmp    %ebx,%esi
 bfa:	75 e4                	jne    be0 <printint+0x60>
    putc(fd, buf[i]);
}
 bfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bff:	5b                   	pop    %ebx
 c00:	5e                   	pop    %esi
 c01:	5f                   	pop    %edi
 c02:	5d                   	pop    %ebp
 c03:	c3                   	ret    
 c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 c08:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 c0f:	eb 90                	jmp    ba1 <printint+0x21>
 c11:	eb 0d                	jmp    c20 <printf>
 c13:	90                   	nop
 c14:	90                   	nop
 c15:	90                   	nop
 c16:	90                   	nop
 c17:	90                   	nop
 c18:	90                   	nop
 c19:	90                   	nop
 c1a:	90                   	nop
 c1b:	90                   	nop
 c1c:	90                   	nop
 c1d:	90                   	nop
 c1e:	90                   	nop
 c1f:	90                   	nop

00000c20 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 c20:	55                   	push   %ebp
 c21:	89 e5                	mov    %esp,%ebp
 c23:	57                   	push   %edi
 c24:	56                   	push   %esi
 c25:	53                   	push   %ebx
 c26:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c29:	8b 75 0c             	mov    0xc(%ebp),%esi
 c2c:	0f b6 1e             	movzbl (%esi),%ebx
 c2f:	84 db                	test   %bl,%bl
 c31:	0f 84 b3 00 00 00    	je     cea <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 c37:	8d 45 10             	lea    0x10(%ebp),%eax
 c3a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 c3d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 c3f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 c42:	eb 2f                	jmp    c73 <printf+0x53>
 c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 c48:	83 f8 25             	cmp    $0x25,%eax
 c4b:	0f 84 a7 00 00 00    	je     cf8 <printf+0xd8>
  write(fd, &c, 1);
 c51:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 c54:	83 ec 04             	sub    $0x4,%esp
 c57:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 c5a:	6a 01                	push   $0x1
 c5c:	50                   	push   %eax
 c5d:	ff 75 08             	pushl  0x8(%ebp)
 c60:	e8 3d fe ff ff       	call   aa2 <write>
 c65:	83 c4 10             	add    $0x10,%esp
 c68:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 c6b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 c6f:	84 db                	test   %bl,%bl
 c71:	74 77                	je     cea <printf+0xca>
    if(state == 0){
 c73:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 c75:	0f be cb             	movsbl %bl,%ecx
 c78:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 c7b:	74 cb                	je     c48 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 c7d:	83 ff 25             	cmp    $0x25,%edi
 c80:	75 e6                	jne    c68 <printf+0x48>
      if(c == 'd'){
 c82:	83 f8 64             	cmp    $0x64,%eax
 c85:	0f 84 05 01 00 00    	je     d90 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 c8b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 c91:	83 f9 70             	cmp    $0x70,%ecx
 c94:	74 72                	je     d08 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 c96:	83 f8 73             	cmp    $0x73,%eax
 c99:	0f 84 99 00 00 00    	je     d38 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 c9f:	83 f8 63             	cmp    $0x63,%eax
 ca2:	0f 84 08 01 00 00    	je     db0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 ca8:	83 f8 25             	cmp    $0x25,%eax
 cab:	0f 84 ef 00 00 00    	je     da0 <printf+0x180>
  write(fd, &c, 1);
 cb1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 cb4:	83 ec 04             	sub    $0x4,%esp
 cb7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 cbb:	6a 01                	push   $0x1
 cbd:	50                   	push   %eax
 cbe:	ff 75 08             	pushl  0x8(%ebp)
 cc1:	e8 dc fd ff ff       	call   aa2 <write>
 cc6:	83 c4 0c             	add    $0xc,%esp
 cc9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 ccc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 ccf:	6a 01                	push   $0x1
 cd1:	50                   	push   %eax
 cd2:	ff 75 08             	pushl  0x8(%ebp)
 cd5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 cd8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 cda:	e8 c3 fd ff ff       	call   aa2 <write>
  for(i = 0; fmt[i]; i++){
 cdf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 ce3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 ce6:	84 db                	test   %bl,%bl
 ce8:	75 89                	jne    c73 <printf+0x53>
    }
  }
}
 cea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ced:	5b                   	pop    %ebx
 cee:	5e                   	pop    %esi
 cef:	5f                   	pop    %edi
 cf0:	5d                   	pop    %ebp
 cf1:	c3                   	ret    
 cf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 cf8:	bf 25 00 00 00       	mov    $0x25,%edi
 cfd:	e9 66 ff ff ff       	jmp    c68 <printf+0x48>
 d02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 d08:	83 ec 0c             	sub    $0xc,%esp
 d0b:	b9 10 00 00 00       	mov    $0x10,%ecx
 d10:	6a 00                	push   $0x0
 d12:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 d15:	8b 45 08             	mov    0x8(%ebp),%eax
 d18:	8b 17                	mov    (%edi),%edx
 d1a:	e8 61 fe ff ff       	call   b80 <printint>
        ap++;
 d1f:	89 f8                	mov    %edi,%eax
 d21:	83 c4 10             	add    $0x10,%esp
      state = 0;
 d24:	31 ff                	xor    %edi,%edi
        ap++;
 d26:	83 c0 04             	add    $0x4,%eax
 d29:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 d2c:	e9 37 ff ff ff       	jmp    c68 <printf+0x48>
 d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 d38:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 d3b:	8b 08                	mov    (%eax),%ecx
        ap++;
 d3d:	83 c0 04             	add    $0x4,%eax
 d40:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 d43:	85 c9                	test   %ecx,%ecx
 d45:	0f 84 8e 00 00 00    	je     dd9 <printf+0x1b9>
        while(*s != 0){
 d4b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 d4e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 d50:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 d52:	84 c0                	test   %al,%al
 d54:	0f 84 0e ff ff ff    	je     c68 <printf+0x48>
 d5a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 d5d:	89 de                	mov    %ebx,%esi
 d5f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 d62:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 d65:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 d68:	83 ec 04             	sub    $0x4,%esp
          s++;
 d6b:	83 c6 01             	add    $0x1,%esi
 d6e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 d71:	6a 01                	push   $0x1
 d73:	57                   	push   %edi
 d74:	53                   	push   %ebx
 d75:	e8 28 fd ff ff       	call   aa2 <write>
        while(*s != 0){
 d7a:	0f b6 06             	movzbl (%esi),%eax
 d7d:	83 c4 10             	add    $0x10,%esp
 d80:	84 c0                	test   %al,%al
 d82:	75 e4                	jne    d68 <printf+0x148>
 d84:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 d87:	31 ff                	xor    %edi,%edi
 d89:	e9 da fe ff ff       	jmp    c68 <printf+0x48>
 d8e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 d90:	83 ec 0c             	sub    $0xc,%esp
 d93:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d98:	6a 01                	push   $0x1
 d9a:	e9 73 ff ff ff       	jmp    d12 <printf+0xf2>
 d9f:	90                   	nop
  write(fd, &c, 1);
 da0:	83 ec 04             	sub    $0x4,%esp
 da3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 da6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 da9:	6a 01                	push   $0x1
 dab:	e9 21 ff ff ff       	jmp    cd1 <printf+0xb1>
        putc(fd, *ap);
 db0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 db3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 db6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 db8:	6a 01                	push   $0x1
        ap++;
 dba:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 dbd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 dc0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 dc3:	50                   	push   %eax
 dc4:	ff 75 08             	pushl  0x8(%ebp)
 dc7:	e8 d6 fc ff ff       	call   aa2 <write>
        ap++;
 dcc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 dcf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 dd2:	31 ff                	xor    %edi,%edi
 dd4:	e9 8f fe ff ff       	jmp    c68 <printf+0x48>
          s = "(null)";
 dd9:	bb 98 0f 00 00       	mov    $0xf98,%ebx
        while(*s != 0){
 dde:	b8 28 00 00 00       	mov    $0x28,%eax
 de3:	e9 72 ff ff ff       	jmp    d5a <printf+0x13a>
 de8:	66 90                	xchg   %ax,%ax
 dea:	66 90                	xchg   %ax,%ax
 dec:	66 90                	xchg   %ax,%ax
 dee:	66 90                	xchg   %ax,%ax

00000df0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 df0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 df1:	a1 9c 12 00 00       	mov    0x129c,%eax
{
 df6:	89 e5                	mov    %esp,%ebp
 df8:	57                   	push   %edi
 df9:	56                   	push   %esi
 dfa:	53                   	push   %ebx
 dfb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 dfe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e08:	39 c8                	cmp    %ecx,%eax
 e0a:	8b 10                	mov    (%eax),%edx
 e0c:	73 32                	jae    e40 <free+0x50>
 e0e:	39 d1                	cmp    %edx,%ecx
 e10:	72 04                	jb     e16 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e12:	39 d0                	cmp    %edx,%eax
 e14:	72 32                	jb     e48 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 e16:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e19:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e1c:	39 fa                	cmp    %edi,%edx
 e1e:	74 30                	je     e50 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e20:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e23:	8b 50 04             	mov    0x4(%eax),%edx
 e26:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e29:	39 f1                	cmp    %esi,%ecx
 e2b:	74 3a                	je     e67 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 e2d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 e2f:	a3 9c 12 00 00       	mov    %eax,0x129c
}
 e34:	5b                   	pop    %ebx
 e35:	5e                   	pop    %esi
 e36:	5f                   	pop    %edi
 e37:	5d                   	pop    %ebp
 e38:	c3                   	ret    
 e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e40:	39 d0                	cmp    %edx,%eax
 e42:	72 04                	jb     e48 <free+0x58>
 e44:	39 d1                	cmp    %edx,%ecx
 e46:	72 ce                	jb     e16 <free+0x26>
{
 e48:	89 d0                	mov    %edx,%eax
 e4a:	eb bc                	jmp    e08 <free+0x18>
 e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 e50:	03 72 04             	add    0x4(%edx),%esi
 e53:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 e56:	8b 10                	mov    (%eax),%edx
 e58:	8b 12                	mov    (%edx),%edx
 e5a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e5d:	8b 50 04             	mov    0x4(%eax),%edx
 e60:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e63:	39 f1                	cmp    %esi,%ecx
 e65:	75 c6                	jne    e2d <free+0x3d>
    p->s.size += bp->s.size;
 e67:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 e6a:	a3 9c 12 00 00       	mov    %eax,0x129c
    p->s.size += bp->s.size;
 e6f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 e72:	8b 53 f8             	mov    -0x8(%ebx),%edx
 e75:	89 10                	mov    %edx,(%eax)
}
 e77:	5b                   	pop    %ebx
 e78:	5e                   	pop    %esi
 e79:	5f                   	pop    %edi
 e7a:	5d                   	pop    %ebp
 e7b:	c3                   	ret    
 e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 e80:	55                   	push   %ebp
 e81:	89 e5                	mov    %esp,%ebp
 e83:	57                   	push   %edi
 e84:	56                   	push   %esi
 e85:	53                   	push   %ebx
 e86:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e89:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 e8c:	8b 15 9c 12 00 00    	mov    0x129c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e92:	8d 78 07             	lea    0x7(%eax),%edi
 e95:	c1 ef 03             	shr    $0x3,%edi
 e98:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 e9b:	85 d2                	test   %edx,%edx
 e9d:	0f 84 9d 00 00 00    	je     f40 <malloc+0xc0>
 ea3:	8b 02                	mov    (%edx),%eax
 ea5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ea8:	39 cf                	cmp    %ecx,%edi
 eaa:	76 6c                	jbe    f18 <malloc+0x98>
 eac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 eb2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 eb7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 eba:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 ec1:	eb 0e                	jmp    ed1 <malloc+0x51>
 ec3:	90                   	nop
 ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ec8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 eca:	8b 48 04             	mov    0x4(%eax),%ecx
 ecd:	39 f9                	cmp    %edi,%ecx
 ecf:	73 47                	jae    f18 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ed1:	39 05 9c 12 00 00    	cmp    %eax,0x129c
 ed7:	89 c2                	mov    %eax,%edx
 ed9:	75 ed                	jne    ec8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 edb:	83 ec 0c             	sub    $0xc,%esp
 ede:	56                   	push   %esi
 edf:	e8 26 fc ff ff       	call   b0a <sbrk>
  if(p == (char*)-1)
 ee4:	83 c4 10             	add    $0x10,%esp
 ee7:	83 f8 ff             	cmp    $0xffffffff,%eax
 eea:	74 1c                	je     f08 <malloc+0x88>
  hp->s.size = nu;
 eec:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 eef:	83 ec 0c             	sub    $0xc,%esp
 ef2:	83 c0 08             	add    $0x8,%eax
 ef5:	50                   	push   %eax
 ef6:	e8 f5 fe ff ff       	call   df0 <free>
  return freep;
 efb:	8b 15 9c 12 00 00    	mov    0x129c,%edx
      if((p = morecore(nunits)) == 0)
 f01:	83 c4 10             	add    $0x10,%esp
 f04:	85 d2                	test   %edx,%edx
 f06:	75 c0                	jne    ec8 <malloc+0x48>
        return 0;
  }
}
 f08:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 f0b:	31 c0                	xor    %eax,%eax
}
 f0d:	5b                   	pop    %ebx
 f0e:	5e                   	pop    %esi
 f0f:	5f                   	pop    %edi
 f10:	5d                   	pop    %ebp
 f11:	c3                   	ret    
 f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 f18:	39 cf                	cmp    %ecx,%edi
 f1a:	74 54                	je     f70 <malloc+0xf0>
        p->s.size -= nunits;
 f1c:	29 f9                	sub    %edi,%ecx
 f1e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f21:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f24:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 f27:	89 15 9c 12 00 00    	mov    %edx,0x129c
}
 f2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 f30:	83 c0 08             	add    $0x8,%eax
}
 f33:	5b                   	pop    %ebx
 f34:	5e                   	pop    %esi
 f35:	5f                   	pop    %edi
 f36:	5d                   	pop    %ebp
 f37:	c3                   	ret    
 f38:	90                   	nop
 f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 f40:	c7 05 9c 12 00 00 a0 	movl   $0x12a0,0x129c
 f47:	12 00 00 
 f4a:	c7 05 a0 12 00 00 a0 	movl   $0x12a0,0x12a0
 f51:	12 00 00 
    base.s.size = 0;
 f54:	b8 a0 12 00 00       	mov    $0x12a0,%eax
 f59:	c7 05 a4 12 00 00 00 	movl   $0x0,0x12a4
 f60:	00 00 00 
 f63:	e9 44 ff ff ff       	jmp    eac <malloc+0x2c>
 f68:	90                   	nop
 f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 f70:	8b 08                	mov    (%eax),%ecx
 f72:	89 0a                	mov    %ecx,(%edx)
 f74:	eb b1                	jmp    f27 <malloc+0xa7>
