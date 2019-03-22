
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
  11:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
  17:	53                   	push   %ebx
  18:	51                   	push   %ecx
  19:	8d 85 04 fe ff ff    	lea    -0x1fc(%ebp),%eax
  1f:	8d 95 c8 fe ff ff    	lea    -0x138(%ebp),%edx
  25:	8d 8d 04 ff ff ff    	lea    -0xfc(%ebp),%ecx
  2b:	81 ec 28 02 00 00    	sub    $0x228,%esp
  31:	89 bd d4 fd ff ff    	mov    %edi,-0x22c(%ebp)
  37:	89 f6                	mov    %esi,%esi
  39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	for (i = 0; i < N; i++){
		u[i][0] =T;
  40:	d9 05 a0 09 00 00    	flds   0x9a0
  46:	83 c0 20             	add    $0x20,%eax
  49:	83 c2 04             	add    $0x4,%edx
  4c:	d9 50 c4             	fsts   -0x3c(%eax)
		 u[i][N-1] =T;
  4f:	d9 50 e0             	fsts   -0x20(%eax)
		  u[0][i] = T;
  52:	d9 92 1c ff ff ff    	fsts   -0xe4(%edx)
		u[N-1][i] = 0.0;
  58:	d9 ee                	fldz   
  5a:	d9 52 fc             	fsts   -0x4(%edx)
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
  5d:	d9 40 c4             	flds   -0x3c(%eax)
  60:	d8 40 e0             	fadds  -0x20(%eax)
	for (i = 0; i < N; i++){
  63:	39 c8                	cmp    %ecx,%eax
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
  65:	de c2                	faddp  %st,%st(2)
  67:	de c1                	faddp  %st,%st(1)
  69:	de c1                	faddp  %st,%st(1)
	for (i = 0; i < N; i++){
  6b:	75 d3                	jne    40 <main+0x40>
	}
	mean /= (4.0 * N);
  6d:	d8 0d a4 09 00 00    	fmuls  0x9a4
  73:	8d 85 0c fe ff ff    	lea    -0x1f4(%ebp),%eax
  79:	8d 95 cc fe ff ff    	lea    -0x134(%ebp),%edx
  7f:	90                   	nop
	for (i = 1; i < N-1; i++ )
		for ( j= 1; j < N-1; j++) u[i][j] = mean;
  80:	d9 10                	fsts   (%eax)
  82:	83 c0 20             	add    $0x20,%eax
  85:	d9 50 e4             	fsts   -0x1c(%eax)
  88:	d9 50 e8             	fsts   -0x18(%eax)
  8b:	d9 50 ec             	fsts   -0x14(%eax)
  8e:	d9 50 f0             	fsts   -0x10(%eax)
  91:	d9 50 f4             	fsts   -0xc(%eax)
	for (i = 1; i < N-1; i++ )
  94:	39 c2                	cmp    %eax,%edx
  96:	75 e8                	jne    80 <main+0x80>
  98:	dd d8                	fstp   %st(0)
  9a:	c7 85 d8 fd ff ff 41 	movl   $0x30d41,-0x228(%ebp)
  a1:	0d 03 00 
  a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	for(;;){
		diff = 0.0;
  a8:	d9 ee                	fldz   
		for(i =1 ; i < N-1; i++){
			for(j =1 ; j < N-1; j++){
				w[i][j] = ( u[i-1][j] + u[i+1][j]+
					    u[i][j-1] + u[i][j+1])/4.0;
				if( fabsm(w[i][j] - u[i][j]) > diff )
					diff = fabsm(w[i][j]- u[i][j]);	
  aa:	bf 01 00 00 08       	mov    $0x8000001,%edi
  af:	be ff ff ff 07       	mov    $0x7ffffff,%esi
  b4:	ba 38 00 00 00       	mov    $0x38,%edx
  b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  c0:	8d 42 e8             	lea    -0x18(%edx),%eax
  c3:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
  c9:	89 f3                	mov    %esi,%ebx
  cb:	c1 e3 05             	shl    $0x5,%ebx
  ce:	d9 84 15 d4 fd ff ff 	flds   -0x22c(%ebp,%edx,1)
  d5:	89 85 dc fd ff ff    	mov    %eax,-0x224(%ebp)
  db:	01 cb                	add    %ecx,%ebx
  dd:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
  e3:	89 f9                	mov    %edi,%ecx
  e5:	c1 e1 05             	shl    $0x5,%ecx
  e8:	01 c1                	add    %eax,%ecx
  ea:	8b 85 dc fd ff ff    	mov    -0x224(%ebp),%eax
					    u[i][j-1] + u[i][j+1])/4.0;
  f0:	d9 84 05 f0 fd ff ff 	flds   -0x210(%ebp,%eax,1)
				w[i][j] = ( u[i-1][j] + u[i+1][j]+
  f7:	d9 44 03 04          	flds   0x4(%ebx,%eax,1)
  fb:	d8 44 01 04          	fadds  0x4(%ecx,%eax,1)
  ff:	d8 84 05 e8 fd ff ff 	fadds  -0x218(%ebp,%eax,1)
					    u[i][j-1] + u[i][j+1])/4.0;
 106:	d8 c1                	fadd   %st(1),%st
				w[i][j] = ( u[i-1][j] + u[i+1][j]+
 108:	d8 0d a8 09 00 00    	fmuls  0x9a8
 10e:	d9 94 05 ec fe ff ff 	fsts   -0x114(%ebp,%eax,1)
				if( fabsm(w[i][j] - u[i][j]) > diff )
 115:	de e2                	fsubp  %st,%st(2)
	if(a<0)
 117:	d9 ee                	fldz   
 119:	df ea                	fucomip %st(2),%st
 11b:	76 0b                	jbe    128 <main+0x128>
 11d:	d9 c9                	fxch   %st(1)
	return -1*a;
 11f:	d9 e0                	fchs   
 121:	eb 07                	jmp    12a <main+0x12a>
 123:	90                   	nop
 124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 128:	d9 c9                	fxch   %st(1)
					diff = fabsm(w[i][j]- u[i][j]);	
 12a:	db ea                	fucomi %st(2),%st
 12c:	da d2                	fcmovbe %st(2),%st
 12e:	dd da                	fstp   %st(2)
 130:	83 c0 04             	add    $0x4,%eax
			for(j =1 ; j < N-1; j++){
 133:	39 c2                	cmp    %eax,%edx
 135:	75 b9                	jne    f0 <main+0xf0>
 137:	dd d8                	fstp   %st(0)
 139:	81 c6 00 00 00 08    	add    $0x8000000,%esi
 13f:	83 c2 20             	add    $0x20,%edx
 142:	81 c7 00 00 00 08    	add    $0x8000000,%edi
		for(i =1 ; i < N-1; i++){
 148:	81 fe ff ff ff 37    	cmp    $0x37ffffff,%esi
 14e:	0f 85 6c ff ff ff    	jne    c0 <main+0xc0>
			}
		}
	    count++;
	       
		if(diff<= E || count > L){ 
 154:	dd 05 b0 09 00 00    	fldl   0x9b0
 15a:	df e9                	fucomip %st(1),%st
 15c:	dd d8                	fstp   %st(0)
 15e:	73 3d                	jae    19d <main+0x19d>
 160:	83 ad d8 fd ff ff 01 	subl   $0x1,-0x228(%ebp)
 167:	74 34                	je     19d <main+0x19d>
 169:	b9 20 00 00 00       	mov    $0x20,%ecx
 16e:	66 90                	xchg   %ax,%ax
 170:	8d 51 18             	lea    0x18(%ecx),%edx
		diff = 0.0;
 173:	89 c8                	mov    %ecx,%eax
 175:	8d 76 00             	lea    0x0(%esi),%esi

			break;
		}
	
		for (i =1; i< N-1; i++)	
			for (j =1; j< N-1; j++) u[i][j] = w[i][j];
 178:	d9 84 05 ec fe ff ff 	flds   -0x114(%ebp,%eax,1)
 17f:	d9 9c 05 ec fd ff ff 	fstps  -0x214(%ebp,%eax,1)
 186:	83 c0 04             	add    $0x4,%eax
 189:	39 c2                	cmp    %eax,%edx
 18b:	75 eb                	jne    178 <main+0x178>
 18d:	83 c1 20             	add    $0x20,%ecx
		for (i =1; i< N-1; i++)	
 190:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
 196:	75 d8                	jne    170 <main+0x170>
 198:	e9 0b ff ff ff       	jmp    a8 <main+0xa8>
 19d:	8b bd d4 fd ff ff    	mov    -0x22c(%ebp),%edi
 1a3:	8d 9d e8 fe ff ff    	lea    -0x118(%ebp),%ebx
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	}
	for(i =0; i <N; i++){
		for(j = 0; j<N; j++)
 1b0:	31 f6                	xor    %esi,%esi
 1b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			printf(1,"%d ",((int)u[i][j]));
 1b8:	d9 04 b7             	flds   (%edi,%esi,4)
 1bb:	d9 bd e6 fd ff ff    	fnstcw -0x21a(%ebp)
 1c1:	0f b7 85 e6 fd ff ff 	movzwl -0x21a(%ebp),%eax
 1c8:	83 ec 04             	sub    $0x4,%esp
		for(j = 0; j<N; j++)
 1cb:	83 c6 01             	add    $0x1,%esi
			printf(1,"%d ",((int)u[i][j]));
 1ce:	80 cc 0c             	or     $0xc,%ah
 1d1:	66 89 85 e4 fd ff ff 	mov    %ax,-0x21c(%ebp)
 1d8:	d9 ad e4 fd ff ff    	fldcw  -0x21c(%ebp)
 1de:	db 9d e0 fd ff ff    	fistpl -0x220(%ebp)
 1e4:	d9 ad e6 fd ff ff    	fldcw  -0x21a(%ebp)
 1ea:	8b 85 e0 fd ff ff    	mov    -0x220(%ebp),%eax
 1f0:	50                   	push   %eax
 1f1:	68 98 09 00 00       	push   $0x998
 1f6:	6a 01                	push   $0x1
 1f8:	e8 43 04 00 00       	call   640 <printf>
		for(j = 0; j<N; j++)
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	83 fe 08             	cmp    $0x8,%esi
 203:	75 b3                	jne    1b8 <main+0x1b8>
		printf(1,"\n");
 205:	83 ec 08             	sub    $0x8,%esp
 208:	83 c7 20             	add    $0x20,%edi
 20b:	68 9c 09 00 00       	push   $0x99c
 210:	6a 01                	push   $0x1
 212:	e8 29 04 00 00       	call   640 <printf>
	for(i =0; i <N; i++){
 217:	83 c4 10             	add    $0x10,%esp
 21a:	39 fb                	cmp    %edi,%ebx
 21c:	75 92                	jne    1b0 <main+0x1b0>
	}
	exit();
 21e:	e8 7f 02 00 00       	call   4a2 <exit>
 223:	66 90                	xchg   %ax,%ax
 225:	66 90                	xchg   %ax,%ax
 227:	66 90                	xchg   %ax,%ax
 229:	66 90                	xchg   %ax,%ax
 22b:	66 90                	xchg   %ax,%ax
 22d:	66 90                	xchg   %ax,%ax
 22f:	90                   	nop

00000230 <fabsm>:
float fabsm(float a){
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	d9 45 08             	flds   0x8(%ebp)
	if(a<0)
 236:	d9 ee                	fldz   
 238:	df e9                	fucomip %st(1),%st
 23a:	77 04                	ja     240 <fabsm+0x10>
}
 23c:	5d                   	pop    %ebp
 23d:	c3                   	ret    
 23e:	66 90                	xchg   %ax,%ax
	return -1*a;
 240:	d9 e0                	fchs   
}
 242:	5d                   	pop    %ebp
 243:	c3                   	ret    
 244:	66 90                	xchg   %ax,%ax
 246:	66 90                	xchg   %ax,%ax
 248:	66 90                	xchg   %ax,%ax
 24a:	66 90                	xchg   %ax,%ax
 24c:	66 90                	xchg   %ax,%ax
 24e:	66 90                	xchg   %ax,%ax

00000250 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 25a:	89 c2                	mov    %eax,%edx
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 260:	83 c1 01             	add    $0x1,%ecx
 263:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 267:	83 c2 01             	add    $0x1,%edx
 26a:	84 db                	test   %bl,%bl
 26c:	88 5a ff             	mov    %bl,-0x1(%edx)
 26f:	75 ef                	jne    260 <strcpy+0x10>
    ;
  return os;
}
 271:	5b                   	pop    %ebx
 272:	5d                   	pop    %ebp
 273:	c3                   	ret    
 274:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 27a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000280 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	53                   	push   %ebx
 284:	8b 55 08             	mov    0x8(%ebp),%edx
 287:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 28a:	0f b6 02             	movzbl (%edx),%eax
 28d:	0f b6 19             	movzbl (%ecx),%ebx
 290:	84 c0                	test   %al,%al
 292:	75 1c                	jne    2b0 <strcmp+0x30>
 294:	eb 2a                	jmp    2c0 <strcmp+0x40>
 296:	8d 76 00             	lea    0x0(%esi),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2a0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 2a3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2a6:	83 c1 01             	add    $0x1,%ecx
 2a9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 2ac:	84 c0                	test   %al,%al
 2ae:	74 10                	je     2c0 <strcmp+0x40>
 2b0:	38 d8                	cmp    %bl,%al
 2b2:	74 ec                	je     2a0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 2b4:	29 d8                	sub    %ebx,%eax
}
 2b6:	5b                   	pop    %ebx
 2b7:	5d                   	pop    %ebp
 2b8:	c3                   	ret    
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2c0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 2c2:	29 d8                	sub    %ebx,%eax
}
 2c4:	5b                   	pop    %ebx
 2c5:	5d                   	pop    %ebp
 2c6:	c3                   	ret    
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <strlen>:

uint
strlen(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2d6:	80 39 00             	cmpb   $0x0,(%ecx)
 2d9:	74 15                	je     2f0 <strlen+0x20>
 2db:	31 d2                	xor    %edx,%edx
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
 2e0:	83 c2 01             	add    $0x1,%edx
 2e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2e7:	89 d0                	mov    %edx,%eax
 2e9:	75 f5                	jne    2e0 <strlen+0x10>
    ;
  return n;
}
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret    
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 2f0:	31 c0                	xor    %eax,%eax
}
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret    
 2f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000300 <memset>:

void*
memset(void *dst, int c, uint n)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 307:	8b 4d 10             	mov    0x10(%ebp),%ecx
 30a:	8b 45 0c             	mov    0xc(%ebp),%eax
 30d:	89 d7                	mov    %edx,%edi
 30f:	fc                   	cld    
 310:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 312:	89 d0                	mov    %edx,%eax
 314:	5f                   	pop    %edi
 315:	5d                   	pop    %ebp
 316:	c3                   	ret    
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <strchr>:

char*
strchr(const char *s, char c)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 32a:	0f b6 10             	movzbl (%eax),%edx
 32d:	84 d2                	test   %dl,%dl
 32f:	74 1d                	je     34e <strchr+0x2e>
    if(*s == c)
 331:	38 d3                	cmp    %dl,%bl
 333:	89 d9                	mov    %ebx,%ecx
 335:	75 0d                	jne    344 <strchr+0x24>
 337:	eb 17                	jmp    350 <strchr+0x30>
 339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 340:	38 ca                	cmp    %cl,%dl
 342:	74 0c                	je     350 <strchr+0x30>
  for(; *s; s++)
 344:	83 c0 01             	add    $0x1,%eax
 347:	0f b6 10             	movzbl (%eax),%edx
 34a:	84 d2                	test   %dl,%dl
 34c:	75 f2                	jne    340 <strchr+0x20>
      return (char*)s;
  return 0;
 34e:	31 c0                	xor    %eax,%eax
}
 350:	5b                   	pop    %ebx
 351:	5d                   	pop    %ebp
 352:	c3                   	ret    
 353:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <gets>:

char*
gets(char *buf, int max)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 366:	31 f6                	xor    %esi,%esi
 368:	89 f3                	mov    %esi,%ebx
{
 36a:	83 ec 1c             	sub    $0x1c,%esp
 36d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 370:	eb 2f                	jmp    3a1 <gets+0x41>
 372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 378:	8d 45 e7             	lea    -0x19(%ebp),%eax
 37b:	83 ec 04             	sub    $0x4,%esp
 37e:	6a 01                	push   $0x1
 380:	50                   	push   %eax
 381:	6a 00                	push   $0x0
 383:	e8 32 01 00 00       	call   4ba <read>
    if(cc < 1)
 388:	83 c4 10             	add    $0x10,%esp
 38b:	85 c0                	test   %eax,%eax
 38d:	7e 1c                	jle    3ab <gets+0x4b>
      break;
    buf[i++] = c;
 38f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 393:	83 c7 01             	add    $0x1,%edi
 396:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 399:	3c 0a                	cmp    $0xa,%al
 39b:	74 23                	je     3c0 <gets+0x60>
 39d:	3c 0d                	cmp    $0xd,%al
 39f:	74 1f                	je     3c0 <gets+0x60>
  for(i=0; i+1 < max; ){
 3a1:	83 c3 01             	add    $0x1,%ebx
 3a4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3a7:	89 fe                	mov    %edi,%esi
 3a9:	7c cd                	jl     378 <gets+0x18>
 3ab:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 3ad:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 3b0:	c6 03 00             	movb   $0x0,(%ebx)
}
 3b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3b6:	5b                   	pop    %ebx
 3b7:	5e                   	pop    %esi
 3b8:	5f                   	pop    %edi
 3b9:	5d                   	pop    %ebp
 3ba:	c3                   	ret    
 3bb:	90                   	nop
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3c0:	8b 75 08             	mov    0x8(%ebp),%esi
 3c3:	8b 45 08             	mov    0x8(%ebp),%eax
 3c6:	01 de                	add    %ebx,%esi
 3c8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 3ca:	c6 03 00             	movb   $0x0,(%ebx)
}
 3cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d0:	5b                   	pop    %ebx
 3d1:	5e                   	pop    %esi
 3d2:	5f                   	pop    %edi
 3d3:	5d                   	pop    %ebp
 3d4:	c3                   	ret    
 3d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	56                   	push   %esi
 3e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3e5:	83 ec 08             	sub    $0x8,%esp
 3e8:	6a 00                	push   $0x0
 3ea:	ff 75 08             	pushl  0x8(%ebp)
 3ed:	e8 f0 00 00 00       	call   4e2 <open>
  if(fd < 0)
 3f2:	83 c4 10             	add    $0x10,%esp
 3f5:	85 c0                	test   %eax,%eax
 3f7:	78 27                	js     420 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3f9:	83 ec 08             	sub    $0x8,%esp
 3fc:	ff 75 0c             	pushl  0xc(%ebp)
 3ff:	89 c3                	mov    %eax,%ebx
 401:	50                   	push   %eax
 402:	e8 f3 00 00 00       	call   4fa <fstat>
  close(fd);
 407:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 40a:	89 c6                	mov    %eax,%esi
  close(fd);
 40c:	e8 b9 00 00 00       	call   4ca <close>
  return r;
 411:	83 c4 10             	add    $0x10,%esp
}
 414:	8d 65 f8             	lea    -0x8(%ebp),%esp
 417:	89 f0                	mov    %esi,%eax
 419:	5b                   	pop    %ebx
 41a:	5e                   	pop    %esi
 41b:	5d                   	pop    %ebp
 41c:	c3                   	ret    
 41d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 420:	be ff ff ff ff       	mov    $0xffffffff,%esi
 425:	eb ed                	jmp    414 <stat+0x34>
 427:	89 f6                	mov    %esi,%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <atoi>:

int
atoi(const char *s)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	53                   	push   %ebx
 434:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 437:	0f be 11             	movsbl (%ecx),%edx
 43a:	8d 42 d0             	lea    -0x30(%edx),%eax
 43d:	3c 09                	cmp    $0x9,%al
  n = 0;
 43f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 444:	77 1f                	ja     465 <atoi+0x35>
 446:	8d 76 00             	lea    0x0(%esi),%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 450:	8d 04 80             	lea    (%eax,%eax,4),%eax
 453:	83 c1 01             	add    $0x1,%ecx
 456:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 45a:	0f be 11             	movsbl (%ecx),%edx
 45d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 460:	80 fb 09             	cmp    $0x9,%bl
 463:	76 eb                	jbe    450 <atoi+0x20>
  return n;
}
 465:	5b                   	pop    %ebx
 466:	5d                   	pop    %ebp
 467:	c3                   	ret    
 468:	90                   	nop
 469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000470 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	56                   	push   %esi
 474:	53                   	push   %ebx
 475:	8b 5d 10             	mov    0x10(%ebp),%ebx
 478:	8b 45 08             	mov    0x8(%ebp),%eax
 47b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 47e:	85 db                	test   %ebx,%ebx
 480:	7e 14                	jle    496 <memmove+0x26>
 482:	31 d2                	xor    %edx,%edx
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 488:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 48c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 48f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 492:	39 d3                	cmp    %edx,%ebx
 494:	75 f2                	jne    488 <memmove+0x18>
  return vdst;
}
 496:	5b                   	pop    %ebx
 497:	5e                   	pop    %esi
 498:	5d                   	pop    %ebp
 499:	c3                   	ret    

0000049a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 49a:	b8 01 00 00 00       	mov    $0x1,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <exit>:
SYSCALL(exit)
 4a2:	b8 02 00 00 00       	mov    $0x2,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <wait>:
SYSCALL(wait)
 4aa:	b8 03 00 00 00       	mov    $0x3,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <pipe>:
SYSCALL(pipe)
 4b2:	b8 04 00 00 00       	mov    $0x4,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <read>:
SYSCALL(read)
 4ba:	b8 05 00 00 00       	mov    $0x5,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <write>:
SYSCALL(write)
 4c2:	b8 10 00 00 00       	mov    $0x10,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <close>:
SYSCALL(close)
 4ca:	b8 15 00 00 00       	mov    $0x15,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <kill>:
SYSCALL(kill)
 4d2:	b8 06 00 00 00       	mov    $0x6,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <exec>:
SYSCALL(exec)
 4da:	b8 07 00 00 00       	mov    $0x7,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <open>:
SYSCALL(open)
 4e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <mknod>:
SYSCALL(mknod)
 4ea:	b8 11 00 00 00       	mov    $0x11,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <unlink>:
SYSCALL(unlink)
 4f2:	b8 12 00 00 00       	mov    $0x12,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <fstat>:
SYSCALL(fstat)
 4fa:	b8 08 00 00 00       	mov    $0x8,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <link>:
SYSCALL(link)
 502:	b8 13 00 00 00       	mov    $0x13,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <mkdir>:
SYSCALL(mkdir)
 50a:	b8 14 00 00 00       	mov    $0x14,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <chdir>:
SYSCALL(chdir)
 512:	b8 09 00 00 00       	mov    $0x9,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <dup>:
SYSCALL(dup)
 51a:	b8 0a 00 00 00       	mov    $0xa,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <getpid>:
SYSCALL(getpid)
 522:	b8 0b 00 00 00       	mov    $0xb,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <sbrk>:
SYSCALL(sbrk)
 52a:	b8 0c 00 00 00       	mov    $0xc,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <sleep>:
SYSCALL(sleep)
 532:	b8 0d 00 00 00       	mov    $0xd,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <uptime>:
SYSCALL(uptime)
 53a:	b8 0e 00 00 00       	mov    $0xe,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <toggle>:
SYSCALL(toggle)
 542:	b8 16 00 00 00       	mov    $0x16,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <print_count>:
SYSCALL(print_count)
 54a:	b8 17 00 00 00       	mov    $0x17,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <add>:
SYSCALL(add)
 552:	b8 18 00 00 00       	mov    $0x18,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <ps>:
SYSCALL(ps)
 55a:	b8 19 00 00 00       	mov    $0x19,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <send>:
SYSCALL(send)
 562:	b8 1a 00 00 00       	mov    $0x1a,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <recv>:
SYSCALL(recv)
 56a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <sigset>:
SYSCALL(sigset)
 572:	b8 1c 00 00 00       	mov    $0x1c,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <sigsend>:
SYSCALL(sigsend)
 57a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <sigret>:
SYSCALL(sigret)
 582:	b8 1e 00 00 00       	mov    $0x1e,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <sigpause>:
SYSCALL(sigpause)
 58a:	b8 1f 00 00 00       	mov    $0x1f,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <send_multi>:
SYSCALL(send_multi)
 592:	b8 20 00 00 00       	mov    $0x20,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    
 59a:	66 90                	xchg   %ax,%ax
 59c:	66 90                	xchg   %ax,%ax
 59e:	66 90                	xchg   %ax,%ax

000005a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
 5a6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5a9:	85 d2                	test   %edx,%edx
{
 5ab:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 5ae:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 5b0:	79 76                	jns    628 <printint+0x88>
 5b2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 5b6:	74 70                	je     628 <printint+0x88>
    x = -xx;
 5b8:	f7 d8                	neg    %eax
    neg = 1;
 5ba:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5c1:	31 f6                	xor    %esi,%esi
 5c3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5c6:	eb 0a                	jmp    5d2 <printint+0x32>
 5c8:	90                   	nop
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 5d0:	89 fe                	mov    %edi,%esi
 5d2:	31 d2                	xor    %edx,%edx
 5d4:	8d 7e 01             	lea    0x1(%esi),%edi
 5d7:	f7 f1                	div    %ecx
 5d9:	0f b6 92 c0 09 00 00 	movzbl 0x9c0(%edx),%edx
  }while((x /= base) != 0);
 5e0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 5e2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 5e5:	75 e9                	jne    5d0 <printint+0x30>
  if(neg)
 5e7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5ea:	85 c0                	test   %eax,%eax
 5ec:	74 08                	je     5f6 <printint+0x56>
    buf[i++] = '-';
 5ee:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 5f3:	8d 7e 02             	lea    0x2(%esi),%edi
 5f6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 5fa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
 600:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 603:	83 ec 04             	sub    $0x4,%esp
 606:	83 ee 01             	sub    $0x1,%esi
 609:	6a 01                	push   $0x1
 60b:	53                   	push   %ebx
 60c:	57                   	push   %edi
 60d:	88 45 d7             	mov    %al,-0x29(%ebp)
 610:	e8 ad fe ff ff       	call   4c2 <write>

  while(--i >= 0)
 615:	83 c4 10             	add    $0x10,%esp
 618:	39 de                	cmp    %ebx,%esi
 61a:	75 e4                	jne    600 <printint+0x60>
    putc(fd, buf[i]);
}
 61c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 61f:	5b                   	pop    %ebx
 620:	5e                   	pop    %esi
 621:	5f                   	pop    %edi
 622:	5d                   	pop    %ebp
 623:	c3                   	ret    
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 628:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 62f:	eb 90                	jmp    5c1 <printint+0x21>
 631:	eb 0d                	jmp    640 <printf>
 633:	90                   	nop
 634:	90                   	nop
 635:	90                   	nop
 636:	90                   	nop
 637:	90                   	nop
 638:	90                   	nop
 639:	90                   	nop
 63a:	90                   	nop
 63b:	90                   	nop
 63c:	90                   	nop
 63d:	90                   	nop
 63e:	90                   	nop
 63f:	90                   	nop

00000640 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 649:	8b 75 0c             	mov    0xc(%ebp),%esi
 64c:	0f b6 1e             	movzbl (%esi),%ebx
 64f:	84 db                	test   %bl,%bl
 651:	0f 84 b3 00 00 00    	je     70a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 657:	8d 45 10             	lea    0x10(%ebp),%eax
 65a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 65d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 65f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 662:	eb 2f                	jmp    693 <printf+0x53>
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 668:	83 f8 25             	cmp    $0x25,%eax
 66b:	0f 84 a7 00 00 00    	je     718 <printf+0xd8>
  write(fd, &c, 1);
 671:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 674:	83 ec 04             	sub    $0x4,%esp
 677:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 67a:	6a 01                	push   $0x1
 67c:	50                   	push   %eax
 67d:	ff 75 08             	pushl  0x8(%ebp)
 680:	e8 3d fe ff ff       	call   4c2 <write>
 685:	83 c4 10             	add    $0x10,%esp
 688:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 68b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 68f:	84 db                	test   %bl,%bl
 691:	74 77                	je     70a <printf+0xca>
    if(state == 0){
 693:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 695:	0f be cb             	movsbl %bl,%ecx
 698:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 69b:	74 cb                	je     668 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 69d:	83 ff 25             	cmp    $0x25,%edi
 6a0:	75 e6                	jne    688 <printf+0x48>
      if(c == 'd'){
 6a2:	83 f8 64             	cmp    $0x64,%eax
 6a5:	0f 84 05 01 00 00    	je     7b0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6ab:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6b1:	83 f9 70             	cmp    $0x70,%ecx
 6b4:	74 72                	je     728 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6b6:	83 f8 73             	cmp    $0x73,%eax
 6b9:	0f 84 99 00 00 00    	je     758 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6bf:	83 f8 63             	cmp    $0x63,%eax
 6c2:	0f 84 08 01 00 00    	je     7d0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6c8:	83 f8 25             	cmp    $0x25,%eax
 6cb:	0f 84 ef 00 00 00    	je     7c0 <printf+0x180>
  write(fd, &c, 1);
 6d1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6d4:	83 ec 04             	sub    $0x4,%esp
 6d7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6db:	6a 01                	push   $0x1
 6dd:	50                   	push   %eax
 6de:	ff 75 08             	pushl  0x8(%ebp)
 6e1:	e8 dc fd ff ff       	call   4c2 <write>
 6e6:	83 c4 0c             	add    $0xc,%esp
 6e9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6ec:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 6ef:	6a 01                	push   $0x1
 6f1:	50                   	push   %eax
 6f2:	ff 75 08             	pushl  0x8(%ebp)
 6f5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6f8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 6fa:	e8 c3 fd ff ff       	call   4c2 <write>
  for(i = 0; fmt[i]; i++){
 6ff:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 703:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 706:	84 db                	test   %bl,%bl
 708:	75 89                	jne    693 <printf+0x53>
    }
  }
}
 70a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 70d:	5b                   	pop    %ebx
 70e:	5e                   	pop    %esi
 70f:	5f                   	pop    %edi
 710:	5d                   	pop    %ebp
 711:	c3                   	ret    
 712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 718:	bf 25 00 00 00       	mov    $0x25,%edi
 71d:	e9 66 ff ff ff       	jmp    688 <printf+0x48>
 722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 728:	83 ec 0c             	sub    $0xc,%esp
 72b:	b9 10 00 00 00       	mov    $0x10,%ecx
 730:	6a 00                	push   $0x0
 732:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 735:	8b 45 08             	mov    0x8(%ebp),%eax
 738:	8b 17                	mov    (%edi),%edx
 73a:	e8 61 fe ff ff       	call   5a0 <printint>
        ap++;
 73f:	89 f8                	mov    %edi,%eax
 741:	83 c4 10             	add    $0x10,%esp
      state = 0;
 744:	31 ff                	xor    %edi,%edi
        ap++;
 746:	83 c0 04             	add    $0x4,%eax
 749:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 74c:	e9 37 ff ff ff       	jmp    688 <printf+0x48>
 751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 758:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 75b:	8b 08                	mov    (%eax),%ecx
        ap++;
 75d:	83 c0 04             	add    $0x4,%eax
 760:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 763:	85 c9                	test   %ecx,%ecx
 765:	0f 84 8e 00 00 00    	je     7f9 <printf+0x1b9>
        while(*s != 0){
 76b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 76e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 770:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 772:	84 c0                	test   %al,%al
 774:	0f 84 0e ff ff ff    	je     688 <printf+0x48>
 77a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 77d:	89 de                	mov    %ebx,%esi
 77f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 782:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 785:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 788:	83 ec 04             	sub    $0x4,%esp
          s++;
 78b:	83 c6 01             	add    $0x1,%esi
 78e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 791:	6a 01                	push   $0x1
 793:	57                   	push   %edi
 794:	53                   	push   %ebx
 795:	e8 28 fd ff ff       	call   4c2 <write>
        while(*s != 0){
 79a:	0f b6 06             	movzbl (%esi),%eax
 79d:	83 c4 10             	add    $0x10,%esp
 7a0:	84 c0                	test   %al,%al
 7a2:	75 e4                	jne    788 <printf+0x148>
 7a4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 7a7:	31 ff                	xor    %edi,%edi
 7a9:	e9 da fe ff ff       	jmp    688 <printf+0x48>
 7ae:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 7b0:	83 ec 0c             	sub    $0xc,%esp
 7b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7b8:	6a 01                	push   $0x1
 7ba:	e9 73 ff ff ff       	jmp    732 <printf+0xf2>
 7bf:	90                   	nop
  write(fd, &c, 1);
 7c0:	83 ec 04             	sub    $0x4,%esp
 7c3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7c6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7c9:	6a 01                	push   $0x1
 7cb:	e9 21 ff ff ff       	jmp    6f1 <printf+0xb1>
        putc(fd, *ap);
 7d0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 7d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 7d6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 7d8:	6a 01                	push   $0x1
        ap++;
 7da:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 7dd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 7e0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7e3:	50                   	push   %eax
 7e4:	ff 75 08             	pushl  0x8(%ebp)
 7e7:	e8 d6 fc ff ff       	call   4c2 <write>
        ap++;
 7ec:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 7ef:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7f2:	31 ff                	xor    %edi,%edi
 7f4:	e9 8f fe ff ff       	jmp    688 <printf+0x48>
          s = "(null)";
 7f9:	bb b8 09 00 00       	mov    $0x9b8,%ebx
        while(*s != 0){
 7fe:	b8 28 00 00 00       	mov    $0x28,%eax
 803:	e9 72 ff ff ff       	jmp    77a <printf+0x13a>
 808:	66 90                	xchg   %ax,%ax
 80a:	66 90                	xchg   %ax,%ax
 80c:	66 90                	xchg   %ax,%ax
 80e:	66 90                	xchg   %ax,%ax

00000810 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 810:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 811:	a1 9c 0c 00 00       	mov    0xc9c,%eax
{
 816:	89 e5                	mov    %esp,%ebp
 818:	57                   	push   %edi
 819:	56                   	push   %esi
 81a:	53                   	push   %ebx
 81b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 81e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 828:	39 c8                	cmp    %ecx,%eax
 82a:	8b 10                	mov    (%eax),%edx
 82c:	73 32                	jae    860 <free+0x50>
 82e:	39 d1                	cmp    %edx,%ecx
 830:	72 04                	jb     836 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 832:	39 d0                	cmp    %edx,%eax
 834:	72 32                	jb     868 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 836:	8b 73 fc             	mov    -0x4(%ebx),%esi
 839:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 83c:	39 fa                	cmp    %edi,%edx
 83e:	74 30                	je     870 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 840:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 843:	8b 50 04             	mov    0x4(%eax),%edx
 846:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 849:	39 f1                	cmp    %esi,%ecx
 84b:	74 3a                	je     887 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 84d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 84f:	a3 9c 0c 00 00       	mov    %eax,0xc9c
}
 854:	5b                   	pop    %ebx
 855:	5e                   	pop    %esi
 856:	5f                   	pop    %edi
 857:	5d                   	pop    %ebp
 858:	c3                   	ret    
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 860:	39 d0                	cmp    %edx,%eax
 862:	72 04                	jb     868 <free+0x58>
 864:	39 d1                	cmp    %edx,%ecx
 866:	72 ce                	jb     836 <free+0x26>
{
 868:	89 d0                	mov    %edx,%eax
 86a:	eb bc                	jmp    828 <free+0x18>
 86c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 870:	03 72 04             	add    0x4(%edx),%esi
 873:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 876:	8b 10                	mov    (%eax),%edx
 878:	8b 12                	mov    (%edx),%edx
 87a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 87d:	8b 50 04             	mov    0x4(%eax),%edx
 880:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 883:	39 f1                	cmp    %esi,%ecx
 885:	75 c6                	jne    84d <free+0x3d>
    p->s.size += bp->s.size;
 887:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 88a:	a3 9c 0c 00 00       	mov    %eax,0xc9c
    p->s.size += bp->s.size;
 88f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 892:	8b 53 f8             	mov    -0x8(%ebx),%edx
 895:	89 10                	mov    %edx,(%eax)
}
 897:	5b                   	pop    %ebx
 898:	5e                   	pop    %esi
 899:	5f                   	pop    %edi
 89a:	5d                   	pop    %ebp
 89b:	c3                   	ret    
 89c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	56                   	push   %esi
 8a5:	53                   	push   %ebx
 8a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8ac:	8b 15 9c 0c 00 00    	mov    0xc9c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b2:	8d 78 07             	lea    0x7(%eax),%edi
 8b5:	c1 ef 03             	shr    $0x3,%edi
 8b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8bb:	85 d2                	test   %edx,%edx
 8bd:	0f 84 9d 00 00 00    	je     960 <malloc+0xc0>
 8c3:	8b 02                	mov    (%edx),%eax
 8c5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8c8:	39 cf                	cmp    %ecx,%edi
 8ca:	76 6c                	jbe    938 <malloc+0x98>
 8cc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 8d7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 8da:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 8e1:	eb 0e                	jmp    8f1 <malloc+0x51>
 8e3:	90                   	nop
 8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8ea:	8b 48 04             	mov    0x4(%eax),%ecx
 8ed:	39 f9                	cmp    %edi,%ecx
 8ef:	73 47                	jae    938 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f1:	39 05 9c 0c 00 00    	cmp    %eax,0xc9c
 8f7:	89 c2                	mov    %eax,%edx
 8f9:	75 ed                	jne    8e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 8fb:	83 ec 0c             	sub    $0xc,%esp
 8fe:	56                   	push   %esi
 8ff:	e8 26 fc ff ff       	call   52a <sbrk>
  if(p == (char*)-1)
 904:	83 c4 10             	add    $0x10,%esp
 907:	83 f8 ff             	cmp    $0xffffffff,%eax
 90a:	74 1c                	je     928 <malloc+0x88>
  hp->s.size = nu;
 90c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 90f:	83 ec 0c             	sub    $0xc,%esp
 912:	83 c0 08             	add    $0x8,%eax
 915:	50                   	push   %eax
 916:	e8 f5 fe ff ff       	call   810 <free>
  return freep;
 91b:	8b 15 9c 0c 00 00    	mov    0xc9c,%edx
      if((p = morecore(nunits)) == 0)
 921:	83 c4 10             	add    $0x10,%esp
 924:	85 d2                	test   %edx,%edx
 926:	75 c0                	jne    8e8 <malloc+0x48>
        return 0;
  }
}
 928:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 92b:	31 c0                	xor    %eax,%eax
}
 92d:	5b                   	pop    %ebx
 92e:	5e                   	pop    %esi
 92f:	5f                   	pop    %edi
 930:	5d                   	pop    %ebp
 931:	c3                   	ret    
 932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 938:	39 cf                	cmp    %ecx,%edi
 93a:	74 54                	je     990 <malloc+0xf0>
        p->s.size -= nunits;
 93c:	29 f9                	sub    %edi,%ecx
 93e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 941:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 944:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 947:	89 15 9c 0c 00 00    	mov    %edx,0xc9c
}
 94d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 950:	83 c0 08             	add    $0x8,%eax
}
 953:	5b                   	pop    %ebx
 954:	5e                   	pop    %esi
 955:	5f                   	pop    %edi
 956:	5d                   	pop    %ebp
 957:	c3                   	ret    
 958:	90                   	nop
 959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 960:	c7 05 9c 0c 00 00 a0 	movl   $0xca0,0xc9c
 967:	0c 00 00 
 96a:	c7 05 a0 0c 00 00 a0 	movl   $0xca0,0xca0
 971:	0c 00 00 
    base.s.size = 0;
 974:	b8 a0 0c 00 00       	mov    $0xca0,%eax
 979:	c7 05 a4 0c 00 00 00 	movl   $0x0,0xca4
 980:	00 00 00 
 983:	e9 44 ff ff ff       	jmp    8cc <malloc+0x2c>
 988:	90                   	nop
 989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 990:	8b 08                	mov    (%eax),%ecx
 992:	89 0a                	mov    %ecx,(%edx)
 994:	eb b1                	jmp    947 <malloc+0xa7>
