
_temp:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	if(a<0)
	return -1*a;
return a;
}
int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
	float mean;
	float u[N][N];
	float w[N][N];

	int count=0;
	mean = 0.0;
   7:	d9 ee                	fldz   
{
   9:	ff 71 fc             	pushl  -0x4(%ecx)
   c:	55                   	push   %ebp
   d:	89 e5                	mov    %esp,%ebp
   f:	57                   	push   %edi
  10:	56                   	push   %esi
  11:	8d 7d c4             	lea    -0x3c(%ebp),%edi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	8d 55 e8             	lea    -0x18(%ebp),%edx
  19:	83 ec 48             	sub    $0x48,%esp
  1c:	89 f8                	mov    %edi,%eax
  1e:	89 fe                	mov    %edi,%esi
	for (i = 0; i < N; i++){
		u[i][0] =T;
  20:	d9 05 90 08 00 00    	flds   0x890
  26:	83 c6 0c             	add    $0xc,%esi
  29:	83 c0 04             	add    $0x4,%eax
  2c:	d9 56 f4             	fsts   -0xc(%esi)
		 u[i][N-1] =T;
  2f:	d9 56 fc             	fsts   -0x4(%esi)
		  u[0][i] = T;
  32:	d9 50 fc             	fsts   -0x4(%eax)
		u[N-1][i] = 0.0;
  35:	d9 ee                	fldz   
  37:	d9 50 14             	fsts   0x14(%eax)
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
  3a:	d9 46 f4             	flds   -0xc(%esi)
  3d:	d8 46 fc             	fadds  -0x4(%esi)
	for (i = 0; i < N; i++){
  40:	39 f2                	cmp    %esi,%edx
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
  42:	de c2                	faddp  %st,%st(2)
  44:	de c1                	faddp  %st,%st(1)
  46:	de c1                	faddp  %st,%st(1)
	for (i = 0; i < N; i++){
  48:	75 d6                	jne    20 <main+0x20>
	}
	mean /= (4.0 * N);
  4a:	d8 35 94 08 00 00    	fdivs  0x894
		for ( j= 1; j < N-1; j++) u[i][j] = mean;
	for(;;){
		diff = 0.0;
		for(i =1 ; i < N-1; i++){
			for(j =1 ; j < N-1; j++){
				w[i][j] = ( u[i-1][j] + u[i+1][j]+
  50:	ba 41 0d 03 00       	mov    $0x30d41,%edx
  55:	31 c0                	xor    %eax,%eax
		for ( j= 1; j < N-1; j++) u[i][j] = mean;
  57:	d9 55 d4             	fsts   -0x2c(%ebp)
				w[i][j] = ( u[i-1][j] + u[i+1][j]+
  5a:	d9 45 c8             	flds   -0x38(%ebp)
  5d:	d8 45 e0             	fadds  -0x20(%ebp)
  60:	d8 45 d0             	fadds  -0x30(%ebp)
					    u[i][j-1] + u[i][j+1])/4.0;
  63:	d8 45 d8             	fadds  -0x28(%ebp)
				w[i][j] = ( u[i-1][j] + u[i+1][j]+
  66:	d8 0d 98 08 00 00    	fmuls  0x898
				if( fabsm(w[i][j] - u[i][j]) > diff )
  6c:	d9 c0                	fld    %st(0)
  6e:	d8 e2                	fsub   %st(2),%st
	if(a<0)
  70:	d9 ee                	fldz   
  72:	df e9                	fucomip %st(1),%st
  74:	76 02                	jbe    78 <main+0x78>
	return -1*a;
  76:	d9 e0                	fchs   
				if( fabsm(w[i][j] - u[i][j]) > diff )
  78:	d9 ee                	fldz   
  7a:	d9 c9                	fxch   %st(1)
  7c:	db e9                	fucomi %st(1),%st
  7e:	dd d9                	fstp   %st(1)
  80:	76 10                	jbe    92 <main+0x92>
					diff = fabsm(w[i][j]- u[i][j]);	
			}
		}
	    count++;
	       
		if(diff<= E || count > L){ 
  82:	dd 05 a0 08 00 00    	fldl   0x8a0
  88:	df e9                	fucomip %st(1),%st
  8a:	dd d8                	fstp   %st(0)
  8c:	72 70                	jb     fe <main+0xfe>
  8e:	dd d8                	fstp   %st(0)
  90:	eb 0e                	jmp    a0 <main+0xa0>
  92:	dd d8                	fstp   %st(0)
  94:	dd d8                	fstp   %st(0)
  96:	eb 08                	jmp    a0 <main+0xa0>
  98:	dd d8                	fstp   %st(0)
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a0:	84 c0                	test   %al,%al
  a2:	75 6d                	jne    111 <main+0x111>
  a4:	dd d8                	fstp   %st(0)
	
		for (i =1; i< N-1; i++)	
			for (j =1; j< N-1; j++) u[i][j] = w[i][j];
	}
	for(i =0; i <N; i++){
		for(j = 0; j<N; j++)
  a6:	31 db                	xor    %ebx,%ebx
			printf(1,"%d ",((int)u[i][j]));
  a8:	d9 04 9f             	flds   (%edi,%ebx,4)
  ab:	d9 7d b6             	fnstcw -0x4a(%ebp)
  ae:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
  b2:	83 ec 04             	sub    $0x4,%esp
		for(j = 0; j<N; j++)
  b5:	83 c3 01             	add    $0x1,%ebx
			printf(1,"%d ",((int)u[i][j]));
  b8:	80 cc 0c             	or     $0xc,%ah
  bb:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
  bf:	d9 6d b4             	fldcw  -0x4c(%ebp)
  c2:	db 5d b0             	fistpl -0x50(%ebp)
  c5:	d9 6d b6             	fldcw  -0x4a(%ebp)
  c8:	8b 45 b0             	mov    -0x50(%ebp),%eax
  cb:	50                   	push   %eax
  cc:	68 88 08 00 00       	push   $0x888
  d1:	6a 01                	push   $0x1
  d3:	e8 58 04 00 00       	call   530 <printf>
		for(j = 0; j<N; j++)
  d8:	83 c4 10             	add    $0x10,%esp
  db:	83 fb 03             	cmp    $0x3,%ebx
  de:	75 c8                	jne    a8 <main+0xa8>
		printf(1,"\n");
  e0:	83 ec 08             	sub    $0x8,%esp
  e3:	83 c7 0c             	add    $0xc,%edi
  e6:	68 8c 08 00 00       	push   $0x88c
  eb:	6a 01                	push   $0x1
  ed:	e8 3e 04 00 00       	call   530 <printf>
	for(i =0; i <N; i++){
  f2:	83 c4 10             	add    $0x10,%esp
  f5:	39 f7                	cmp    %esi,%edi
  f7:	75 ad                	jne    a6 <main+0xa6>
	}
	exit();
  f9:	e8 94 02 00 00       	call   392 <exit>
		if(diff<= E || count > L){ 
  fe:	83 ea 01             	sub    $0x1,%edx
 101:	74 95                	je     98 <main+0x98>
 103:	dd d9                	fstp   %st(1)
 105:	b8 01 00 00 00       	mov    $0x1,%eax
			for (j =1; j< N-1; j++) u[i][j] = w[i][j];
 10a:	d9 c0                	fld    %st(0)
 10c:	e9 5b ff ff ff       	jmp    6c <main+0x6c>
 111:	d9 5d d4             	fstps  -0x2c(%ebp)
 114:	eb 90                	jmp    a6 <main+0xa6>
 116:	66 90                	xchg   %ax,%ax
 118:	66 90                	xchg   %ax,%ax
 11a:	66 90                	xchg   %ax,%ax
 11c:	66 90                	xchg   %ax,%ax
 11e:	66 90                	xchg   %ax,%ax

00000120 <fabsm>:
float fabsm(float a){
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	d9 45 08             	flds   0x8(%ebp)
	if(a<0)
 126:	d9 ee                	fldz   
 128:	df e9                	fucomip %st(1),%st
 12a:	77 04                	ja     130 <fabsm+0x10>
}
 12c:	5d                   	pop    %ebp
 12d:	c3                   	ret    
 12e:	66 90                	xchg   %ax,%ax
	return -1*a;
 130:	d9 e0                	fchs   
}
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    
 134:	66 90                	xchg   %ax,%ax
 136:	66 90                	xchg   %ax,%ax
 138:	66 90                	xchg   %ax,%ax
 13a:	66 90                	xchg   %ax,%ax
 13c:	66 90                	xchg   %ax,%ax
 13e:	66 90                	xchg   %ax,%ax

00000140 <strcpy>:
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 14a:	89 c2                	mov    %eax,%edx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	83 c1 01             	add    $0x1,%ecx
 153:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 157:	83 c2 01             	add    $0x1,%edx
 15a:	84 db                	test   %bl,%bl
 15c:	88 5a ff             	mov    %bl,-0x1(%edx)
 15f:	75 ef                	jne    150 <strcpy+0x10>
 161:	5b                   	pop    %ebx
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 16a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000170 <strcmp>:
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 55 08             	mov    0x8(%ebp),%edx
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 17a:	0f b6 02             	movzbl (%edx),%eax
 17d:	0f b6 19             	movzbl (%ecx),%ebx
 180:	84 c0                	test   %al,%al
 182:	75 1c                	jne    1a0 <strcmp+0x30>
 184:	eb 2a                	jmp    1b0 <strcmp+0x40>
 186:	8d 76 00             	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 190:	83 c2 01             	add    $0x1,%edx
 193:	0f b6 02             	movzbl (%edx),%eax
 196:	83 c1 01             	add    $0x1,%ecx
 199:	0f b6 19             	movzbl (%ecx),%ebx
 19c:	84 c0                	test   %al,%al
 19e:	74 10                	je     1b0 <strcmp+0x40>
 1a0:	38 d8                	cmp    %bl,%al
 1a2:	74 ec                	je     190 <strcmp+0x20>
 1a4:	29 d8                	sub    %ebx,%eax
 1a6:	5b                   	pop    %ebx
 1a7:	5d                   	pop    %ebp
 1a8:	c3                   	ret    
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1b0:	31 c0                	xor    %eax,%eax
 1b2:	29 d8                	sub    %ebx,%eax
 1b4:	5b                   	pop    %ebx
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strlen>:
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c6:	80 39 00             	cmpb   $0x0,(%ecx)
 1c9:	74 15                	je     1e0 <strlen+0x20>
 1cb:	31 d2                	xor    %edx,%edx
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	83 c2 01             	add    $0x1,%edx
 1d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1d7:	89 d0                	mov    %edx,%eax
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	31 c0                	xor    %eax,%eax
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <memset>:
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <strchr>:
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 21a:	0f b6 10             	movzbl (%eax),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	74 1d                	je     23e <strchr+0x2e>
 221:	38 d3                	cmp    %dl,%bl
 223:	89 d9                	mov    %ebx,%ecx
 225:	75 0d                	jne    234 <strchr+0x24>
 227:	eb 17                	jmp    240 <strchr+0x30>
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 230:	38 ca                	cmp    %cl,%dl
 232:	74 0c                	je     240 <strchr+0x30>
 234:	83 c0 01             	add    $0x1,%eax
 237:	0f b6 10             	movzbl (%eax),%edx
 23a:	84 d2                	test   %dl,%dl
 23c:	75 f2                	jne    230 <strchr+0x20>
 23e:	31 c0                	xor    %eax,%eax
 240:	5b                   	pop    %ebx
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <gets>:
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
 255:	53                   	push   %ebx
 256:	31 f6                	xor    %esi,%esi
 258:	89 f3                	mov    %esi,%ebx
 25a:	83 ec 1c             	sub    $0x1c,%esp
 25d:	8b 7d 08             	mov    0x8(%ebp),%edi
 260:	eb 2f                	jmp    291 <gets+0x41>
 262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 268:	8d 45 e7             	lea    -0x19(%ebp),%eax
 26b:	83 ec 04             	sub    $0x4,%esp
 26e:	6a 01                	push   $0x1
 270:	50                   	push   %eax
 271:	6a 00                	push   $0x0
 273:	e8 32 01 00 00       	call   3aa <read>
 278:	83 c4 10             	add    $0x10,%esp
 27b:	85 c0                	test   %eax,%eax
 27d:	7e 1c                	jle    29b <gets+0x4b>
 27f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 283:	83 c7 01             	add    $0x1,%edi
 286:	88 47 ff             	mov    %al,-0x1(%edi)
 289:	3c 0a                	cmp    $0xa,%al
 28b:	74 23                	je     2b0 <gets+0x60>
 28d:	3c 0d                	cmp    $0xd,%al
 28f:	74 1f                	je     2b0 <gets+0x60>
 291:	83 c3 01             	add    $0x1,%ebx
 294:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 297:	89 fe                	mov    %edi,%esi
 299:	7c cd                	jl     268 <gets+0x18>
 29b:	89 f3                	mov    %esi,%ebx
 29d:	8b 45 08             	mov    0x8(%ebp),%eax
 2a0:	c6 03 00             	movb   $0x0,(%ebx)
 2a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5f                   	pop    %edi
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret    
 2ab:	90                   	nop
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b0:	8b 75 08             	mov    0x8(%ebp),%esi
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	01 de                	add    %ebx,%esi
 2b8:	89 f3                	mov    %esi,%ebx
 2ba:	c6 03 00             	movb   $0x0,(%ebx)
 2bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c0:	5b                   	pop    %ebx
 2c1:	5e                   	pop    %esi
 2c2:	5f                   	pop    %edi
 2c3:	5d                   	pop    %ebp
 2c4:	c3                   	ret    
 2c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <stat>:
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	6a 00                	push   $0x0
 2da:	ff 75 08             	pushl  0x8(%ebp)
 2dd:	e8 f0 00 00 00       	call   3d2 <open>
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 27                	js     310 <stat+0x40>
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	pushl  0xc(%ebp)
 2ef:	89 c3                	mov    %eax,%ebx
 2f1:	50                   	push   %eax
 2f2:	e8 f3 00 00 00       	call   3ea <fstat>
 2f7:	89 1c 24             	mov    %ebx,(%esp)
 2fa:	89 c6                	mov    %eax,%esi
 2fc:	e8 b9 00 00 00       	call   3ba <close>
 301:	83 c4 10             	add    $0x10,%esp
 304:	8d 65 f8             	lea    -0x8(%ebp),%esp
 307:	89 f0                	mov    %esi,%eax
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb ed                	jmp    304 <stat+0x34>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <atoi>:
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 4d 08             	mov    0x8(%ebp),%ecx
 327:	0f be 11             	movsbl (%ecx),%edx
 32a:	8d 42 d0             	lea    -0x30(%edx),%eax
 32d:	3c 09                	cmp    $0x9,%al
 32f:	b8 00 00 00 00       	mov    $0x0,%eax
 334:	77 1f                	ja     355 <atoi+0x35>
 336:	8d 76 00             	lea    0x0(%esi),%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 340:	8d 04 80             	lea    (%eax,%eax,4),%eax
 343:	83 c1 01             	add    $0x1,%ecx
 346:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 34a:	0f be 11             	movsbl (%ecx),%edx
 34d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
 355:	5b                   	pop    %ebx
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	90                   	nop
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
 365:	8b 5d 10             	mov    0x10(%ebp),%ebx
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
 36e:	85 db                	test   %ebx,%ebx
 370:	7e 14                	jle    386 <memmove+0x26>
 372:	31 d2                	xor    %edx,%edx
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 378:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 37c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 37f:	83 c2 01             	add    $0x1,%edx
 382:	39 d3                	cmp    %edx,%ebx
 384:	75 f2                	jne    378 <memmove+0x18>
 386:	5b                   	pop    %ebx
 387:	5e                   	pop    %esi
 388:	5d                   	pop    %ebp
 389:	c3                   	ret    

0000038a <fork>:
 38a:	b8 01 00 00 00       	mov    $0x1,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <exit>:
 392:	b8 02 00 00 00       	mov    $0x2,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <wait>:
 39a:	b8 03 00 00 00       	mov    $0x3,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <pipe>:
 3a2:	b8 04 00 00 00       	mov    $0x4,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <read>:
 3aa:	b8 05 00 00 00       	mov    $0x5,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <write>:
 3b2:	b8 10 00 00 00       	mov    $0x10,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <close>:
 3ba:	b8 15 00 00 00       	mov    $0x15,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <kill>:
 3c2:	b8 06 00 00 00       	mov    $0x6,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <exec>:
 3ca:	b8 07 00 00 00       	mov    $0x7,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <open>:
 3d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <mknod>:
 3da:	b8 11 00 00 00       	mov    $0x11,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <unlink>:
 3e2:	b8 12 00 00 00       	mov    $0x12,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <fstat>:
 3ea:	b8 08 00 00 00       	mov    $0x8,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <link>:
 3f2:	b8 13 00 00 00       	mov    $0x13,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mkdir>:
 3fa:	b8 14 00 00 00       	mov    $0x14,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <chdir>:
 402:	b8 09 00 00 00       	mov    $0x9,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <dup>:
 40a:	b8 0a 00 00 00       	mov    $0xa,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <getpid>:
 412:	b8 0b 00 00 00       	mov    $0xb,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <sbrk>:
 41a:	b8 0c 00 00 00       	mov    $0xc,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <sleep>:
 422:	b8 0d 00 00 00       	mov    $0xd,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <uptime>:
 42a:	b8 0e 00 00 00       	mov    $0xe,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <toggle>:
 432:	b8 16 00 00 00       	mov    $0x16,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <print_count>:
 43a:	b8 17 00 00 00       	mov    $0x17,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <add>:
 442:	b8 18 00 00 00       	mov    $0x18,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <ps>:
 44a:	b8 19 00 00 00       	mov    $0x19,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <send>:
 452:	b8 1a 00 00 00       	mov    $0x1a,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <recv>:
 45a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <sigset>:
 462:	b8 1c 00 00 00       	mov    $0x1c,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <sigsend>:
 46a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <sigret>:
 472:	b8 1e 00 00 00       	mov    $0x1e,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <sigpause>:
 47a:	b8 1f 00 00 00       	mov    $0x1f,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <send_multi>:
 482:	b8 20 00 00 00       	mov    $0x20,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    
 48a:	66 90                	xchg   %ax,%ax
 48c:	66 90                	xchg   %ax,%ax
 48e:	66 90                	xchg   %ax,%ax

00000490 <printint>:
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 3c             	sub    $0x3c,%esp
 499:	85 d2                	test   %edx,%edx
 49b:	89 45 c0             	mov    %eax,-0x40(%ebp)
 49e:	89 d0                	mov    %edx,%eax
 4a0:	79 76                	jns    518 <printint+0x88>
 4a2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4a6:	74 70                	je     518 <printint+0x88>
 4a8:	f7 d8                	neg    %eax
 4aa:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4b1:	31 f6                	xor    %esi,%esi
 4b3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4b6:	eb 0a                	jmp    4c2 <printint+0x32>
 4b8:	90                   	nop
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4c0:	89 fe                	mov    %edi,%esi
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	8d 7e 01             	lea    0x1(%esi),%edi
 4c7:	f7 f1                	div    %ecx
 4c9:	0f b6 92 b0 08 00 00 	movzbl 0x8b0(%edx),%edx
 4d0:	85 c0                	test   %eax,%eax
 4d2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 4d5:	75 e9                	jne    4c0 <printint+0x30>
 4d7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4da:	85 c0                	test   %eax,%eax
 4dc:	74 08                	je     4e6 <printint+0x56>
 4de:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4e3:	8d 7e 02             	lea    0x2(%esi),%edi
 4e6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 4ea:	8b 7d c0             	mov    -0x40(%ebp),%edi
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
 4f0:	0f b6 06             	movzbl (%esi),%eax
 4f3:	83 ec 04             	sub    $0x4,%esp
 4f6:	83 ee 01             	sub    $0x1,%esi
 4f9:	6a 01                	push   $0x1
 4fb:	53                   	push   %ebx
 4fc:	57                   	push   %edi
 4fd:	88 45 d7             	mov    %al,-0x29(%ebp)
 500:	e8 ad fe ff ff       	call   3b2 <write>
 505:	83 c4 10             	add    $0x10,%esp
 508:	39 de                	cmp    %ebx,%esi
 50a:	75 e4                	jne    4f0 <printint+0x60>
 50c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50f:	5b                   	pop    %ebx
 510:	5e                   	pop    %esi
 511:	5f                   	pop    %edi
 512:	5d                   	pop    %ebp
 513:	c3                   	ret    
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 518:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 51f:	eb 90                	jmp    4b1 <printint+0x21>
 521:	eb 0d                	jmp    530 <printf>
 523:	90                   	nop
 524:	90                   	nop
 525:	90                   	nop
 526:	90                   	nop
 527:	90                   	nop
 528:	90                   	nop
 529:	90                   	nop
 52a:	90                   	nop
 52b:	90                   	nop
 52c:	90                   	nop
 52d:	90                   	nop
 52e:	90                   	nop
 52f:	90                   	nop

00000530 <printf>:
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	83 ec 2c             	sub    $0x2c,%esp
 539:	8b 75 0c             	mov    0xc(%ebp),%esi
 53c:	0f b6 1e             	movzbl (%esi),%ebx
 53f:	84 db                	test   %bl,%bl
 541:	0f 84 b3 00 00 00    	je     5fa <printf+0xca>
 547:	8d 45 10             	lea    0x10(%ebp),%eax
 54a:	83 c6 01             	add    $0x1,%esi
 54d:	31 ff                	xor    %edi,%edi
 54f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 552:	eb 2f                	jmp    583 <printf+0x53>
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 558:	83 f8 25             	cmp    $0x25,%eax
 55b:	0f 84 a7 00 00 00    	je     608 <printf+0xd8>
 561:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 564:	83 ec 04             	sub    $0x4,%esp
 567:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 56a:	6a 01                	push   $0x1
 56c:	50                   	push   %eax
 56d:	ff 75 08             	pushl  0x8(%ebp)
 570:	e8 3d fe ff ff       	call   3b2 <write>
 575:	83 c4 10             	add    $0x10,%esp
 578:	83 c6 01             	add    $0x1,%esi
 57b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 57f:	84 db                	test   %bl,%bl
 581:	74 77                	je     5fa <printf+0xca>
 583:	85 ff                	test   %edi,%edi
 585:	0f be cb             	movsbl %bl,%ecx
 588:	0f b6 c3             	movzbl %bl,%eax
 58b:	74 cb                	je     558 <printf+0x28>
 58d:	83 ff 25             	cmp    $0x25,%edi
 590:	75 e6                	jne    578 <printf+0x48>
 592:	83 f8 64             	cmp    $0x64,%eax
 595:	0f 84 05 01 00 00    	je     6a0 <printf+0x170>
 59b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5a1:	83 f9 70             	cmp    $0x70,%ecx
 5a4:	74 72                	je     618 <printf+0xe8>
 5a6:	83 f8 73             	cmp    $0x73,%eax
 5a9:	0f 84 99 00 00 00    	je     648 <printf+0x118>
 5af:	83 f8 63             	cmp    $0x63,%eax
 5b2:	0f 84 08 01 00 00    	je     6c0 <printf+0x190>
 5b8:	83 f8 25             	cmp    $0x25,%eax
 5bb:	0f 84 ef 00 00 00    	je     6b0 <printf+0x180>
 5c1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5c4:	83 ec 04             	sub    $0x4,%esp
 5c7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5cb:	6a 01                	push   $0x1
 5cd:	50                   	push   %eax
 5ce:	ff 75 08             	pushl  0x8(%ebp)
 5d1:	e8 dc fd ff ff       	call   3b2 <write>
 5d6:	83 c4 0c             	add    $0xc,%esp
 5d9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5dc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5df:	6a 01                	push   $0x1
 5e1:	50                   	push   %eax
 5e2:	ff 75 08             	pushl  0x8(%ebp)
 5e5:	83 c6 01             	add    $0x1,%esi
 5e8:	31 ff                	xor    %edi,%edi
 5ea:	e8 c3 fd ff ff       	call   3b2 <write>
 5ef:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5f3:	83 c4 10             	add    $0x10,%esp
 5f6:	84 db                	test   %bl,%bl
 5f8:	75 89                	jne    583 <printf+0x53>
 5fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5fd:	5b                   	pop    %ebx
 5fe:	5e                   	pop    %esi
 5ff:	5f                   	pop    %edi
 600:	5d                   	pop    %ebp
 601:	c3                   	ret    
 602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 608:	bf 25 00 00 00       	mov    $0x25,%edi
 60d:	e9 66 ff ff ff       	jmp    578 <printf+0x48>
 612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 618:	83 ec 0c             	sub    $0xc,%esp
 61b:	b9 10 00 00 00       	mov    $0x10,%ecx
 620:	6a 00                	push   $0x0
 622:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 625:	8b 45 08             	mov    0x8(%ebp),%eax
 628:	8b 17                	mov    (%edi),%edx
 62a:	e8 61 fe ff ff       	call   490 <printint>
 62f:	89 f8                	mov    %edi,%eax
 631:	83 c4 10             	add    $0x10,%esp
 634:	31 ff                	xor    %edi,%edi
 636:	83 c0 04             	add    $0x4,%eax
 639:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 63c:	e9 37 ff ff ff       	jmp    578 <printf+0x48>
 641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 648:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 64b:	8b 08                	mov    (%eax),%ecx
 64d:	83 c0 04             	add    $0x4,%eax
 650:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 653:	85 c9                	test   %ecx,%ecx
 655:	0f 84 8e 00 00 00    	je     6e9 <printf+0x1b9>
 65b:	0f b6 01             	movzbl (%ecx),%eax
 65e:	31 ff                	xor    %edi,%edi
 660:	89 cb                	mov    %ecx,%ebx
 662:	84 c0                	test   %al,%al
 664:	0f 84 0e ff ff ff    	je     578 <printf+0x48>
 66a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 66d:	89 de                	mov    %ebx,%esi
 66f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 672:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 675:	8d 76 00             	lea    0x0(%esi),%esi
 678:	83 ec 04             	sub    $0x4,%esp
 67b:	83 c6 01             	add    $0x1,%esi
 67e:	88 45 e3             	mov    %al,-0x1d(%ebp)
 681:	6a 01                	push   $0x1
 683:	57                   	push   %edi
 684:	53                   	push   %ebx
 685:	e8 28 fd ff ff       	call   3b2 <write>
 68a:	0f b6 06             	movzbl (%esi),%eax
 68d:	83 c4 10             	add    $0x10,%esp
 690:	84 c0                	test   %al,%al
 692:	75 e4                	jne    678 <printf+0x148>
 694:	8b 75 d0             	mov    -0x30(%ebp),%esi
 697:	31 ff                	xor    %edi,%edi
 699:	e9 da fe ff ff       	jmp    578 <printf+0x48>
 69e:	66 90                	xchg   %ax,%ax
 6a0:	83 ec 0c             	sub    $0xc,%esp
 6a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6a8:	6a 01                	push   $0x1
 6aa:	e9 73 ff ff ff       	jmp    622 <printf+0xf2>
 6af:	90                   	nop
 6b0:	83 ec 04             	sub    $0x4,%esp
 6b3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6b6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6b9:	6a 01                	push   $0x1
 6bb:	e9 21 ff ff ff       	jmp    5e1 <printf+0xb1>
 6c0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6c3:	83 ec 04             	sub    $0x4,%esp
 6c6:	8b 07                	mov    (%edi),%eax
 6c8:	6a 01                	push   $0x1
 6ca:	83 c7 04             	add    $0x4,%edi
 6cd:	88 45 e4             	mov    %al,-0x1c(%ebp)
 6d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6d3:	50                   	push   %eax
 6d4:	ff 75 08             	pushl  0x8(%ebp)
 6d7:	e8 d6 fc ff ff       	call   3b2 <write>
 6dc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 6df:	83 c4 10             	add    $0x10,%esp
 6e2:	31 ff                	xor    %edi,%edi
 6e4:	e9 8f fe ff ff       	jmp    578 <printf+0x48>
 6e9:	bb a8 08 00 00       	mov    $0x8a8,%ebx
 6ee:	b8 28 00 00 00       	mov    $0x28,%eax
 6f3:	e9 72 ff ff ff       	jmp    66a <printf+0x13a>
 6f8:	66 90                	xchg   %ax,%ax
 6fa:	66 90                	xchg   %ax,%ax
 6fc:	66 90                	xchg   %ax,%ax
 6fe:	66 90                	xchg   %ax,%ax

00000700 <free>:
 700:	55                   	push   %ebp
 701:	a1 8c 0b 00 00       	mov    0xb8c,%eax
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 70e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 718:	39 c8                	cmp    %ecx,%eax
 71a:	8b 10                	mov    (%eax),%edx
 71c:	73 32                	jae    750 <free+0x50>
 71e:	39 d1                	cmp    %edx,%ecx
 720:	72 04                	jb     726 <free+0x26>
 722:	39 d0                	cmp    %edx,%eax
 724:	72 32                	jb     758 <free+0x58>
 726:	8b 73 fc             	mov    -0x4(%ebx),%esi
 729:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 72c:	39 fa                	cmp    %edi,%edx
 72e:	74 30                	je     760 <free+0x60>
 730:	89 53 f8             	mov    %edx,-0x8(%ebx)
 733:	8b 50 04             	mov    0x4(%eax),%edx
 736:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 739:	39 f1                	cmp    %esi,%ecx
 73b:	74 3a                	je     777 <free+0x77>
 73d:	89 08                	mov    %ecx,(%eax)
 73f:	a3 8c 0b 00 00       	mov    %eax,0xb8c
 744:	5b                   	pop    %ebx
 745:	5e                   	pop    %esi
 746:	5f                   	pop    %edi
 747:	5d                   	pop    %ebp
 748:	c3                   	ret    
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 750:	39 d0                	cmp    %edx,%eax
 752:	72 04                	jb     758 <free+0x58>
 754:	39 d1                	cmp    %edx,%ecx
 756:	72 ce                	jb     726 <free+0x26>
 758:	89 d0                	mov    %edx,%eax
 75a:	eb bc                	jmp    718 <free+0x18>
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 760:	03 72 04             	add    0x4(%edx),%esi
 763:	89 73 fc             	mov    %esi,-0x4(%ebx)
 766:	8b 10                	mov    (%eax),%edx
 768:	8b 12                	mov    (%edx),%edx
 76a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 76d:	8b 50 04             	mov    0x4(%eax),%edx
 770:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 773:	39 f1                	cmp    %esi,%ecx
 775:	75 c6                	jne    73d <free+0x3d>
 777:	03 53 fc             	add    -0x4(%ebx),%edx
 77a:	a3 8c 0b 00 00       	mov    %eax,0xb8c
 77f:	89 50 04             	mov    %edx,0x4(%eax)
 782:	8b 53 f8             	mov    -0x8(%ebx),%edx
 785:	89 10                	mov    %edx,(%eax)
 787:	5b                   	pop    %ebx
 788:	5e                   	pop    %esi
 789:	5f                   	pop    %edi
 78a:	5d                   	pop    %ebp
 78b:	c3                   	ret    
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000790 <malloc>:
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 0c             	sub    $0xc,%esp
 799:	8b 45 08             	mov    0x8(%ebp),%eax
 79c:	8b 15 8c 0b 00 00    	mov    0xb8c,%edx
 7a2:	8d 78 07             	lea    0x7(%eax),%edi
 7a5:	c1 ef 03             	shr    $0x3,%edi
 7a8:	83 c7 01             	add    $0x1,%edi
 7ab:	85 d2                	test   %edx,%edx
 7ad:	0f 84 9d 00 00 00    	je     850 <malloc+0xc0>
 7b3:	8b 02                	mov    (%edx),%eax
 7b5:	8b 48 04             	mov    0x4(%eax),%ecx
 7b8:	39 cf                	cmp    %ecx,%edi
 7ba:	76 6c                	jbe    828 <malloc+0x98>
 7bc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7c2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7c7:	0f 43 df             	cmovae %edi,%ebx
 7ca:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7d1:	eb 0e                	jmp    7e1 <malloc+0x51>
 7d3:	90                   	nop
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7d8:	8b 02                	mov    (%edx),%eax
 7da:	8b 48 04             	mov    0x4(%eax),%ecx
 7dd:	39 f9                	cmp    %edi,%ecx
 7df:	73 47                	jae    828 <malloc+0x98>
 7e1:	39 05 8c 0b 00 00    	cmp    %eax,0xb8c
 7e7:	89 c2                	mov    %eax,%edx
 7e9:	75 ed                	jne    7d8 <malloc+0x48>
 7eb:	83 ec 0c             	sub    $0xc,%esp
 7ee:	56                   	push   %esi
 7ef:	e8 26 fc ff ff       	call   41a <sbrk>
 7f4:	83 c4 10             	add    $0x10,%esp
 7f7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7fa:	74 1c                	je     818 <malloc+0x88>
 7fc:	89 58 04             	mov    %ebx,0x4(%eax)
 7ff:	83 ec 0c             	sub    $0xc,%esp
 802:	83 c0 08             	add    $0x8,%eax
 805:	50                   	push   %eax
 806:	e8 f5 fe ff ff       	call   700 <free>
 80b:	8b 15 8c 0b 00 00    	mov    0xb8c,%edx
 811:	83 c4 10             	add    $0x10,%esp
 814:	85 d2                	test   %edx,%edx
 816:	75 c0                	jne    7d8 <malloc+0x48>
 818:	8d 65 f4             	lea    -0xc(%ebp),%esp
 81b:	31 c0                	xor    %eax,%eax
 81d:	5b                   	pop    %ebx
 81e:	5e                   	pop    %esi
 81f:	5f                   	pop    %edi
 820:	5d                   	pop    %ebp
 821:	c3                   	ret    
 822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 828:	39 cf                	cmp    %ecx,%edi
 82a:	74 54                	je     880 <malloc+0xf0>
 82c:	29 f9                	sub    %edi,%ecx
 82e:	89 48 04             	mov    %ecx,0x4(%eax)
 831:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 834:	89 78 04             	mov    %edi,0x4(%eax)
 837:	89 15 8c 0b 00 00    	mov    %edx,0xb8c
 83d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 840:	83 c0 08             	add    $0x8,%eax
 843:	5b                   	pop    %ebx
 844:	5e                   	pop    %esi
 845:	5f                   	pop    %edi
 846:	5d                   	pop    %ebp
 847:	c3                   	ret    
 848:	90                   	nop
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 850:	c7 05 8c 0b 00 00 90 	movl   $0xb90,0xb8c
 857:	0b 00 00 
 85a:	c7 05 90 0b 00 00 90 	movl   $0xb90,0xb90
 861:	0b 00 00 
 864:	b8 90 0b 00 00       	mov    $0xb90,%eax
 869:	c7 05 94 0b 00 00 00 	movl   $0x0,0xb94
 870:	00 00 00 
 873:	e9 44 ff ff ff       	jmp    7bc <malloc+0x2c>
 878:	90                   	nop
 879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 880:	8b 08                	mov    (%eax),%ecx
 882:	89 0a                	mov    %ecx,(%edx)
 884:	eb b1                	jmp    837 <malloc+0xa7>
