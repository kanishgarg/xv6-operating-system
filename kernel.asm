
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 70 c8 10 80       	mov    $0x8010c870,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 b0 2e 10 80       	mov    $0x80102eb0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb b4 c8 10 80       	mov    $0x8010c8b4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 40 77 10 80       	push   $0x80107740
80100051:	68 80 c8 10 80       	push   $0x8010c880
80100056:	e8 15 49 00 00       	call   80104970 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 cc 0f 11 80 7c 	movl   $0x80110f7c,0x80110fcc
80100062:	0f 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 d0 0f 11 80 7c 	movl   $0x80110f7c,0x80110fd0
8010006c:	0f 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba 7c 0f 11 80       	mov    $0x80110f7c,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 7c 0f 11 80 	movl   $0x80110f7c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 47 77 10 80       	push   $0x80107747
80100097:	50                   	push   %eax
80100098:	e8 a3 47 00 00       	call   80104840 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 d0 0f 11 80       	mov    0x80110fd0,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d d0 0f 11 80    	mov    %ebx,0x80110fd0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d 7c 0f 11 80       	cmp    $0x80110f7c,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 80 c8 10 80       	push   $0x8010c880
801000e4:	e8 c7 49 00 00       	call   80104ab0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d d0 0f 11 80    	mov    0x80110fd0,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 7c 0f 11 80    	cmp    $0x80110f7c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 7c 0f 11 80    	cmp    $0x80110f7c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d cc 0f 11 80    	mov    0x80110fcc,%ebx
80100126:	81 fb 7c 0f 11 80    	cmp    $0x80110f7c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 7c 0f 11 80    	cmp    $0x80110f7c,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 80 c8 10 80       	push   $0x8010c880
80100162:	e8 09 4a 00 00       	call   80104b70 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 0e 47 00 00       	call   80104880 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 ad 1f 00 00       	call   80102130 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 4e 77 10 80       	push   $0x8010774e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 6d 47 00 00       	call   80104920 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 67 1f 00 00       	jmp    80102130 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 5f 77 10 80       	push   $0x8010775f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 2c 47 00 00       	call   80104920 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 dc 46 00 00       	call   801048e0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 80 c8 10 80 	movl   $0x8010c880,(%esp)
8010020b:	e8 a0 48 00 00       	call   80104ab0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 d0 0f 11 80       	mov    0x80110fd0,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 7c 0f 11 80 	movl   $0x80110f7c,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 d0 0f 11 80       	mov    0x80110fd0,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d d0 0f 11 80    	mov    %ebx,0x80110fd0
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 80 c8 10 80 	movl   $0x8010c880,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 0f 49 00 00       	jmp    80104b70 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 66 77 10 80       	push   $0x80107766
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 eb 14 00 00       	call   80101770 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 c0 b7 10 80 	movl   $0x8010b7c0,(%esp)
8010028c:	e8 1f 48 00 00       	call   80104ab0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 60 12 11 80    	mov    0x80111260,%edx
801002a7:	39 15 64 12 11 80    	cmp    %edx,0x80111264
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 c0 b7 10 80       	push   $0x8010b7c0
801002c0:	68 60 12 11 80       	push   $0x80111260
801002c5:	e8 56 40 00 00       	call   80104320 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 60 12 11 80    	mov    0x80111260,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 64 12 11 80    	cmp    0x80111264,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 80 38 00 00       	call   80103b60 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 c0 b7 10 80       	push   $0x8010b7c0
801002ef:	e8 7c 48 00 00       	call   80104b70 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 94 13 00 00       	call   80101690 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 60 12 11 80       	mov    %eax,0x80111260
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 e0 11 11 80 	movsbl -0x7feeee20(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 c0 b7 10 80       	push   $0x8010b7c0
8010034d:	e8 1e 48 00 00       	call   80104b70 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 36 13 00 00       	call   80101690 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 60 12 11 80    	mov    %edx,0x80111260
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 f4 b7 10 80 00 	movl   $0x0,0x8010b7f4
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 92 23 00 00       	call   80102740 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 6d 77 10 80       	push   $0x8010776d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 43 81 10 80 	movl   $0x80108143,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 b3 45 00 00       	call   80104990 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 81 77 10 80       	push   $0x80107781
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 f8 b7 10 80 01 	movl   $0x1,0x8010b7f8
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d f8 b7 10 80    	mov    0x8010b7f8,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 11 5f 00 00       	call   80106350 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 5f 5e 00 00       	call   80106350 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 53 5e 00 00       	call   80106350 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 47 5e 00 00       	call   80106350 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 47 47 00 00       	call   80104c70 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 7a 46 00 00       	call   80104bc0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 85 77 10 80       	push   $0x80107785
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 b0 77 10 80 	movzbl -0x7fef8850(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 5c 11 00 00       	call   80101770 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 c0 b7 10 80 	movl   $0x8010b7c0,(%esp)
8010061b:	e8 90 44 00 00       	call   80104ab0 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 c0 b7 10 80       	push   $0x8010b7c0
80100647:	e8 24 45 00 00       	call   80104b70 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 3b 10 00 00       	call   80101690 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 f4 b7 10 80       	mov    0x8010b7f4,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 c0 b7 10 80       	push   $0x8010b7c0
8010071f:	e8 4c 44 00 00       	call   80104b70 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 98 77 10 80       	mov    $0x80107798,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 c0 b7 10 80       	push   $0x8010b7c0
801007f0:	e8 bb 42 00 00       	call   80104ab0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 9f 77 10 80       	push   $0x8010779f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 c0 b7 10 80       	push   $0x8010b7c0
80100823:	e8 88 42 00 00       	call   80104ab0 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 68 12 11 80       	mov    0x80111268,%eax
80100856:	3b 05 64 12 11 80    	cmp    0x80111264,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 68 12 11 80       	mov    %eax,0x80111268
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 c0 b7 10 80       	push   $0x8010b7c0
80100888:	e8 e3 42 00 00       	call   80104b70 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 68 12 11 80       	mov    0x80111268,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 60 12 11 80    	sub    0x80111260,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 68 12 11 80    	mov    %edx,0x80111268
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 e0 11 11 80    	mov    %cl,-0x7feeee20(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 60 12 11 80       	mov    0x80111260,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 68 12 11 80    	cmp    %eax,0x80111268
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 64 12 11 80       	mov    %eax,0x80111264
          wakeup(&input.r);
80100911:	68 60 12 11 80       	push   $0x80111260
80100916:	e8 c5 3b 00 00       	call   801044e0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 68 12 11 80       	mov    0x80111268,%eax
8010093d:	39 05 64 12 11 80    	cmp    %eax,0x80111264
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 68 12 11 80       	mov    %eax,0x80111268
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 68 12 11 80       	mov    0x80111268,%eax
80100964:	3b 05 64 12 11 80    	cmp    0x80111264,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba e0 11 11 80 0a 	cmpb   $0xa,-0x7feeee20(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 24 3c 00 00       	jmp    801045c0 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 e0 11 11 80 0a 	movb   $0xa,-0x7feeee20(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 68 12 11 80       	mov    0x80111268,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 a8 77 10 80       	push   $0x801077a8
801009cb:	68 c0 b7 10 80       	push   $0x8010b7c0
801009d0:	e8 9b 3f 00 00       	call   80104970 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 2c 1c 11 80 00 	movl   $0x80100600,0x80111c2c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 28 1c 11 80 70 	movl   $0x80100270,0x80111c28
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 f4 b7 10 80 01 	movl   $0x1,0x8010b7f4
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 e2 18 00 00       	call   801022e0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 3f 31 00 00       	call   80103b60 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 84 21 00 00       	call   80102bb0 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 b9 14 00 00       	call   80101ef0 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 43 0c 00 00       	call   80101690 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 12 0f 00 00       	call   80101970 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 b1 0e 00 00       	call   80101920 <iunlockput>
    end_op();
80100a6f:	e8 ac 21 00 00       	call   80102c20 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 07 6a 00 00       	call   801074a0 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 93 02 00 00    	je     80100d52 <exec+0x342>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 c5 67 00 00       	call   801072c0 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 d3 66 00 00       	call   80107200 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 13 0e 00 00       	call   80101970 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 a9 68 00 00       	call   80107420 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 86 0d 00 00       	call   80101920 <iunlockput>
  end_op();
80100b9a:	e8 81 20 00 00       	call   80102c20 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 11 67 00 00       	call   801072c0 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 5a 68 00 00       	call   80107420 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 48 20 00 00       	call   80102c20 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 c1 77 10 80       	push   $0x801077c1
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 35 69 00 00       	call   80107540 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 a2 41 00 00       	call   80104de0 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 8f 41 00 00       	call   80104de0 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 3e 6a 00 00       	call   801076a0 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 d4 69 00 00       	call   801076a0 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	83 c0 6c             	add    $0x6c,%eax
80100d09:	50                   	push   %eax
80100d0a:	e8 91 40 00 00       	call   80104da0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d0f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d15:	89 f9                	mov    %edi,%ecx
80100d17:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1d:	89 31                	mov    %esi,(%ecx)
  curproc->sighandler = (sig_handler)-1;
80100d1f:	c7 41 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%ecx)
  curproc->pgdir = pgdir;
80100d26:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d29:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d2f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d32:	8b 41 18             	mov    0x18(%ecx),%eax
80100d35:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d38:	89 0c 24             	mov    %ecx,(%esp)
80100d3b:	e8 30 63 00 00       	call   80107070 <switchuvm>
  freevm(oldpgdir);
80100d40:	89 3c 24             	mov    %edi,(%esp)
80100d43:	e8 d8 66 00 00       	call   80107420 <freevm>
  return 0;
80100d48:	83 c4 10             	add    $0x10,%esp
80100d4b:	31 c0                	xor    %eax,%eax
80100d4d:	e9 2a fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d52:	be 00 20 00 00       	mov    $0x2000,%esi
80100d57:	e9 35 fe ff ff       	jmp    80100b91 <exec+0x181>
80100d5c:	66 90                	xchg   %ax,%ax
80100d5e:	66 90                	xchg   %ax,%ax

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 cd 77 10 80       	push   $0x801077cd
80100d6b:	68 80 12 11 80       	push   $0x80111280
80100d70:	e8 fb 3b 00 00       	call   80104970 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb b4 12 11 80       	mov    $0x801112b4,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 80 12 11 80       	push   $0x80111280
80100d91:	e8 1a 3d 00 00       	call   80104ab0 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 14 1c 11 80    	cmp    $0x80111c14,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 80 12 11 80       	push   $0x80111280
80100dc1:	e8 aa 3d 00 00       	call   80104b70 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 80 12 11 80       	push   $0x80111280
80100dda:	e8 91 3d 00 00       	call   80104b70 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 80 12 11 80       	push   $0x80111280
80100dff:	e8 ac 3c 00 00       	call   80104ab0 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 80 12 11 80       	push   $0x80111280
80100e1c:	e8 4f 3d 00 00       	call   80104b70 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 d4 77 10 80       	push   $0x801077d4
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 80 12 11 80       	push   $0x80111280
80100e51:	e8 5a 3c 00 00       	call   80104ab0 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 80 12 11 80 	movl   $0x80111280,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 ef 3c 00 00       	jmp    80104b70 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 80 12 11 80       	push   $0x80111280
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 c3 3c 00 00       	call   80104b70 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 8a 24 00 00       	call   80103360 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 cb 1c 00 00       	call   80102bb0 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 d0 08 00 00       	call   801017c0 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 21 1d 00 00       	jmp    80102c20 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 dc 77 10 80       	push   $0x801077dc
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 66 07 00 00       	call   80101690 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 09 0a 00 00       	call   80101940 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 30 08 00 00       	call   80101770 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 01 07 00 00       	call   80101690 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 d4 09 00 00       	call   80101970 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 bd 07 00 00       	call   80101770 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 3e 25 00 00       	jmp    80103510 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 e6 77 10 80       	push   $0x801077e6
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 27 07 00 00       	call   80101770 <iunlock>
      end_op();
80101049:	e8 d2 1b 00 00       	call   80102c20 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 06 00 00       	mov    $0x600,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 35 1b 00 00       	call   80102bb0 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 0a 06 00 00       	call   80101690 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 d8 09 00 00       	call   80101a70 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 c3 06 00 00       	call   80101770 <iunlock>
      end_op();
801010ad:	e8 6e 1b 00 00       	call   80102c20 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 0e 23 00 00       	jmp    80103400 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 ef 77 10 80       	push   $0x801077ef
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 f5 77 10 80       	push   $0x801077f5
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	57                   	push   %edi
80101114:	56                   	push   %esi
80101115:	53                   	push   %ebx
80101116:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101119:	8b 0d 80 1c 11 80    	mov    0x80111c80,%ecx
{
8010111f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101122:	85 c9                	test   %ecx,%ecx
80101124:	0f 84 87 00 00 00    	je     801011b1 <balloc+0xa1>
8010112a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101131:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101134:	83 ec 08             	sub    $0x8,%esp
80101137:	89 f0                	mov    %esi,%eax
80101139:	c1 f8 0c             	sar    $0xc,%eax
8010113c:	03 05 98 1c 11 80    	add    0x80111c98,%eax
80101142:	50                   	push   %eax
80101143:	ff 75 d8             	pushl  -0x28(%ebp)
80101146:	e8 85 ef ff ff       	call   801000d0 <bread>
8010114b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010114e:	a1 80 1c 11 80       	mov    0x80111c80,%eax
80101153:	83 c4 10             	add    $0x10,%esp
80101156:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101159:	31 c0                	xor    %eax,%eax
8010115b:	eb 2f                	jmp    8010118c <balloc+0x7c>
8010115d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101160:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101162:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101165:	bb 01 00 00 00       	mov    $0x1,%ebx
8010116a:	83 e1 07             	and    $0x7,%ecx
8010116d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010116f:	89 c1                	mov    %eax,%ecx
80101171:	c1 f9 03             	sar    $0x3,%ecx
80101174:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101179:	85 df                	test   %ebx,%edi
8010117b:	89 fa                	mov    %edi,%edx
8010117d:	74 41                	je     801011c0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010117f:	83 c0 01             	add    $0x1,%eax
80101182:	83 c6 01             	add    $0x1,%esi
80101185:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010118a:	74 05                	je     80101191 <balloc+0x81>
8010118c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010118f:	77 cf                	ja     80101160 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101191:	83 ec 0c             	sub    $0xc,%esp
80101194:	ff 75 e4             	pushl  -0x1c(%ebp)
80101197:	e8 44 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010119c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011a3:	83 c4 10             	add    $0x10,%esp
801011a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011a9:	39 05 80 1c 11 80    	cmp    %eax,0x80111c80
801011af:	77 80                	ja     80101131 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011b1:	83 ec 0c             	sub    $0xc,%esp
801011b4:	68 ff 77 10 80       	push   $0x801077ff
801011b9:	e8 d2 f1 ff ff       	call   80100390 <panic>
801011be:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801011c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011c3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801011c6:	09 da                	or     %ebx,%edx
801011c8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011cc:	57                   	push   %edi
801011cd:	e8 ae 1b 00 00       	call   80102d80 <log_write>
        brelse(bp);
801011d2:	89 3c 24             	mov    %edi,(%esp)
801011d5:	e8 06 f0 ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011da:	58                   	pop    %eax
801011db:	5a                   	pop    %edx
801011dc:	56                   	push   %esi
801011dd:	ff 75 d8             	pushl  -0x28(%ebp)
801011e0:	e8 eb ee ff ff       	call   801000d0 <bread>
801011e5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ea:	83 c4 0c             	add    $0xc,%esp
801011ed:	68 00 02 00 00       	push   $0x200
801011f2:	6a 00                	push   $0x0
801011f4:	50                   	push   %eax
801011f5:	e8 c6 39 00 00       	call   80104bc0 <memset>
  log_write(bp);
801011fa:	89 1c 24             	mov    %ebx,(%esp)
801011fd:	e8 7e 1b 00 00       	call   80102d80 <log_write>
  brelse(bp);
80101202:	89 1c 24             	mov    %ebx,(%esp)
80101205:	e8 d6 ef ff ff       	call   801001e0 <brelse>
}
8010120a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010120d:	89 f0                	mov    %esi,%eax
8010120f:	5b                   	pop    %ebx
80101210:	5e                   	pop    %esi
80101211:	5f                   	pop    %edi
80101212:	5d                   	pop    %ebp
80101213:	c3                   	ret    
80101214:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010121a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101220 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	57                   	push   %edi
80101224:	56                   	push   %esi
80101225:	53                   	push   %ebx
80101226:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101228:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010122a:	bb d4 1c 11 80       	mov    $0x80111cd4,%ebx
{
8010122f:	83 ec 28             	sub    $0x28,%esp
80101232:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101235:	68 a0 1c 11 80       	push   $0x80111ca0
8010123a:	e8 71 38 00 00       	call   80104ab0 <acquire>
8010123f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101242:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101245:	eb 17                	jmp    8010125e <iget+0x3e>
80101247:	89 f6                	mov    %esi,%esi
80101249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101250:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101256:	81 fb f4 38 11 80    	cmp    $0x801138f4,%ebx
8010125c:	73 22                	jae    80101280 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010125e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101261:	85 c9                	test   %ecx,%ecx
80101263:	7e 04                	jle    80101269 <iget+0x49>
80101265:	39 3b                	cmp    %edi,(%ebx)
80101267:	74 4f                	je     801012b8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101269:	85 f6                	test   %esi,%esi
8010126b:	75 e3                	jne    80101250 <iget+0x30>
8010126d:	85 c9                	test   %ecx,%ecx
8010126f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101272:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101278:	81 fb f4 38 11 80    	cmp    $0x801138f4,%ebx
8010127e:	72 de                	jb     8010125e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101280:	85 f6                	test   %esi,%esi
80101282:	74 5b                	je     801012df <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101284:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101287:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101289:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010128c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101293:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010129a:	68 a0 1c 11 80       	push   $0x80111ca0
8010129f:	e8 cc 38 00 00       	call   80104b70 <release>

  return ip;
801012a4:	83 c4 10             	add    $0x10,%esp
}
801012a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012aa:	89 f0                	mov    %esi,%eax
801012ac:	5b                   	pop    %ebx
801012ad:	5e                   	pop    %esi
801012ae:	5f                   	pop    %edi
801012af:	5d                   	pop    %ebp
801012b0:	c3                   	ret    
801012b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012b8:	39 53 04             	cmp    %edx,0x4(%ebx)
801012bb:	75 ac                	jne    80101269 <iget+0x49>
      release(&icache.lock);
801012bd:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801012c0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012c3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012c5:	68 a0 1c 11 80       	push   $0x80111ca0
      ip->ref++;
801012ca:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012cd:	e8 9e 38 00 00       	call   80104b70 <release>
      return ip;
801012d2:	83 c4 10             	add    $0x10,%esp
}
801012d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012d8:	89 f0                	mov    %esi,%eax
801012da:	5b                   	pop    %ebx
801012db:	5e                   	pop    %esi
801012dc:	5f                   	pop    %edi
801012dd:	5d                   	pop    %ebp
801012de:	c3                   	ret    
    panic("iget: no inodes");
801012df:	83 ec 0c             	sub    $0xc,%esp
801012e2:	68 15 78 10 80       	push   $0x80107815
801012e7:	e8 a4 f0 ff ff       	call   80100390 <panic>
801012ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801012f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	57                   	push   %edi
801012f4:	56                   	push   %esi
801012f5:	53                   	push   %ebx
801012f6:	89 c6                	mov    %eax,%esi
801012f8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012fb:	83 fa 0b             	cmp    $0xb,%edx
801012fe:	77 18                	ja     80101318 <bmap+0x28>
80101300:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101303:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101306:	85 db                	test   %ebx,%ebx
80101308:	74 76                	je     80101380 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010130a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010130d:	89 d8                	mov    %ebx,%eax
8010130f:	5b                   	pop    %ebx
80101310:	5e                   	pop    %esi
80101311:	5f                   	pop    %edi
80101312:	5d                   	pop    %ebp
80101313:	c3                   	ret    
80101314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101318:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010131b:	83 fb 7f             	cmp    $0x7f,%ebx
8010131e:	0f 87 90 00 00 00    	ja     801013b4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101324:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010132a:	8b 00                	mov    (%eax),%eax
8010132c:	85 d2                	test   %edx,%edx
8010132e:	74 70                	je     801013a0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101330:	83 ec 08             	sub    $0x8,%esp
80101333:	52                   	push   %edx
80101334:	50                   	push   %eax
80101335:	e8 96 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010133a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010133e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101341:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101343:	8b 1a                	mov    (%edx),%ebx
80101345:	85 db                	test   %ebx,%ebx
80101347:	75 1d                	jne    80101366 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101349:	8b 06                	mov    (%esi),%eax
8010134b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010134e:	e8 bd fd ff ff       	call   80101110 <balloc>
80101353:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101356:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101359:	89 c3                	mov    %eax,%ebx
8010135b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010135d:	57                   	push   %edi
8010135e:	e8 1d 1a 00 00       	call   80102d80 <log_write>
80101363:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101366:	83 ec 0c             	sub    $0xc,%esp
80101369:	57                   	push   %edi
8010136a:	e8 71 ee ff ff       	call   801001e0 <brelse>
8010136f:	83 c4 10             	add    $0x10,%esp
}
80101372:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101375:	89 d8                	mov    %ebx,%eax
80101377:	5b                   	pop    %ebx
80101378:	5e                   	pop    %esi
80101379:	5f                   	pop    %edi
8010137a:	5d                   	pop    %ebp
8010137b:	c3                   	ret    
8010137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101380:	8b 00                	mov    (%eax),%eax
80101382:	e8 89 fd ff ff       	call   80101110 <balloc>
80101387:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010138a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010138d:	89 c3                	mov    %eax,%ebx
}
8010138f:	89 d8                	mov    %ebx,%eax
80101391:	5b                   	pop    %ebx
80101392:	5e                   	pop    %esi
80101393:	5f                   	pop    %edi
80101394:	5d                   	pop    %ebp
80101395:	c3                   	ret    
80101396:	8d 76 00             	lea    0x0(%esi),%esi
80101399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013a0:	e8 6b fd ff ff       	call   80101110 <balloc>
801013a5:	89 c2                	mov    %eax,%edx
801013a7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013ad:	8b 06                	mov    (%esi),%eax
801013af:	e9 7c ff ff ff       	jmp    80101330 <bmap+0x40>
  panic("bmap: out of range");
801013b4:	83 ec 0c             	sub    $0xc,%esp
801013b7:	68 25 78 10 80       	push   $0x80107825
801013bc:	e8 cf ef ff ff       	call   80100390 <panic>
801013c1:	eb 0d                	jmp    801013d0 <readsb>
801013c3:	90                   	nop
801013c4:	90                   	nop
801013c5:	90                   	nop
801013c6:	90                   	nop
801013c7:	90                   	nop
801013c8:	90                   	nop
801013c9:	90                   	nop
801013ca:	90                   	nop
801013cb:	90                   	nop
801013cc:	90                   	nop
801013cd:	90                   	nop
801013ce:	90                   	nop
801013cf:	90                   	nop

801013d0 <readsb>:
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	56                   	push   %esi
801013d4:	53                   	push   %ebx
801013d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013d8:	83 ec 08             	sub    $0x8,%esp
801013db:	6a 01                	push   $0x1
801013dd:	ff 75 08             	pushl  0x8(%ebp)
801013e0:	e8 eb ec ff ff       	call   801000d0 <bread>
801013e5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ea:	83 c4 0c             	add    $0xc,%esp
801013ed:	6a 1c                	push   $0x1c
801013ef:	50                   	push   %eax
801013f0:	56                   	push   %esi
801013f1:	e8 7a 38 00 00       	call   80104c70 <memmove>
  brelse(bp);
801013f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013f9:	83 c4 10             	add    $0x10,%esp
}
801013fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013ff:	5b                   	pop    %ebx
80101400:	5e                   	pop    %esi
80101401:	5d                   	pop    %ebp
  brelse(bp);
80101402:	e9 d9 ed ff ff       	jmp    801001e0 <brelse>
80101407:	89 f6                	mov    %esi,%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101410 <bfree>:
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	56                   	push   %esi
80101414:	53                   	push   %ebx
80101415:	89 d3                	mov    %edx,%ebx
80101417:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101419:	83 ec 08             	sub    $0x8,%esp
8010141c:	68 80 1c 11 80       	push   $0x80111c80
80101421:	50                   	push   %eax
80101422:	e8 a9 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101427:	58                   	pop    %eax
80101428:	5a                   	pop    %edx
80101429:	89 da                	mov    %ebx,%edx
8010142b:	c1 ea 0c             	shr    $0xc,%edx
8010142e:	03 15 98 1c 11 80    	add    0x80111c98,%edx
80101434:	52                   	push   %edx
80101435:	56                   	push   %esi
80101436:	e8 95 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010143b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010143d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101440:	ba 01 00 00 00       	mov    $0x1,%edx
80101445:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101448:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010144e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101451:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101453:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101458:	85 d1                	test   %edx,%ecx
8010145a:	74 25                	je     80101481 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010145c:	f7 d2                	not    %edx
8010145e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101460:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101463:	21 ca                	and    %ecx,%edx
80101465:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101469:	56                   	push   %esi
8010146a:	e8 11 19 00 00       	call   80102d80 <log_write>
  brelse(bp);
8010146f:	89 34 24             	mov    %esi,(%esp)
80101472:	e8 69 ed ff ff       	call   801001e0 <brelse>
}
80101477:	83 c4 10             	add    $0x10,%esp
8010147a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010147d:	5b                   	pop    %ebx
8010147e:	5e                   	pop    %esi
8010147f:	5d                   	pop    %ebp
80101480:	c3                   	ret    
    panic("freeing free block");
80101481:	83 ec 0c             	sub    $0xc,%esp
80101484:	68 38 78 10 80       	push   $0x80107838
80101489:	e8 02 ef ff ff       	call   80100390 <panic>
8010148e:	66 90                	xchg   %ax,%ax

80101490 <iinit>:
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	53                   	push   %ebx
80101494:	bb e0 1c 11 80       	mov    $0x80111ce0,%ebx
80101499:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010149c:	68 4b 78 10 80       	push   $0x8010784b
801014a1:	68 a0 1c 11 80       	push   $0x80111ca0
801014a6:	e8 c5 34 00 00       	call   80104970 <initlock>
801014ab:	83 c4 10             	add    $0x10,%esp
801014ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014b0:	83 ec 08             	sub    $0x8,%esp
801014b3:	68 52 78 10 80       	push   $0x80107852
801014b8:	53                   	push   %ebx
801014b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014bf:	e8 7c 33 00 00       	call   80104840 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014c4:	83 c4 10             	add    $0x10,%esp
801014c7:	81 fb 00 39 11 80    	cmp    $0x80113900,%ebx
801014cd:	75 e1                	jne    801014b0 <iinit+0x20>
  readsb(dev, &sb);
801014cf:	83 ec 08             	sub    $0x8,%esp
801014d2:	68 80 1c 11 80       	push   $0x80111c80
801014d7:	ff 75 08             	pushl  0x8(%ebp)
801014da:	e8 f1 fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014df:	ff 35 98 1c 11 80    	pushl  0x80111c98
801014e5:	ff 35 94 1c 11 80    	pushl  0x80111c94
801014eb:	ff 35 90 1c 11 80    	pushl  0x80111c90
801014f1:	ff 35 8c 1c 11 80    	pushl  0x80111c8c
801014f7:	ff 35 88 1c 11 80    	pushl  0x80111c88
801014fd:	ff 35 84 1c 11 80    	pushl  0x80111c84
80101503:	ff 35 80 1c 11 80    	pushl  0x80111c80
80101509:	68 b8 78 10 80       	push   $0x801078b8
8010150e:	e8 4d f1 ff ff       	call   80100660 <cprintf>
}
80101513:	83 c4 30             	add    $0x30,%esp
80101516:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101519:	c9                   	leave  
8010151a:	c3                   	ret    
8010151b:	90                   	nop
8010151c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101520 <ialloc>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	57                   	push   %edi
80101524:	56                   	push   %esi
80101525:	53                   	push   %ebx
80101526:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	83 3d 88 1c 11 80 01 	cmpl   $0x1,0x80111c88
{
80101530:	8b 45 0c             	mov    0xc(%ebp),%eax
80101533:	8b 75 08             	mov    0x8(%ebp),%esi
80101536:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101539:	0f 86 91 00 00 00    	jbe    801015d0 <ialloc+0xb0>
8010153f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101544:	eb 21                	jmp    80101567 <ialloc+0x47>
80101546:	8d 76 00             	lea    0x0(%esi),%esi
80101549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101550:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101553:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101556:	57                   	push   %edi
80101557:	e8 84 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010155c:	83 c4 10             	add    $0x10,%esp
8010155f:	39 1d 88 1c 11 80    	cmp    %ebx,0x80111c88
80101565:	76 69                	jbe    801015d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101567:	89 d8                	mov    %ebx,%eax
80101569:	83 ec 08             	sub    $0x8,%esp
8010156c:	c1 e8 03             	shr    $0x3,%eax
8010156f:	03 05 94 1c 11 80    	add    0x80111c94,%eax
80101575:	50                   	push   %eax
80101576:	56                   	push   %esi
80101577:	e8 54 eb ff ff       	call   801000d0 <bread>
8010157c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010157e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101580:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101583:	83 e0 07             	and    $0x7,%eax
80101586:	c1 e0 06             	shl    $0x6,%eax
80101589:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010158d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101591:	75 bd                	jne    80101550 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101593:	83 ec 04             	sub    $0x4,%esp
80101596:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101599:	6a 40                	push   $0x40
8010159b:	6a 00                	push   $0x0
8010159d:	51                   	push   %ecx
8010159e:	e8 1d 36 00 00       	call   80104bc0 <memset>
      dip->type = type;
801015a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015ad:	89 3c 24             	mov    %edi,(%esp)
801015b0:	e8 cb 17 00 00       	call   80102d80 <log_write>
      brelse(bp);
801015b5:	89 3c 24             	mov    %edi,(%esp)
801015b8:	e8 23 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015bd:	83 c4 10             	add    $0x10,%esp
}
801015c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015c3:	89 da                	mov    %ebx,%edx
801015c5:	89 f0                	mov    %esi,%eax
}
801015c7:	5b                   	pop    %ebx
801015c8:	5e                   	pop    %esi
801015c9:	5f                   	pop    %edi
801015ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801015cb:	e9 50 fc ff ff       	jmp    80101220 <iget>
  panic("ialloc: no inodes");
801015d0:	83 ec 0c             	sub    $0xc,%esp
801015d3:	68 58 78 10 80       	push   $0x80107858
801015d8:	e8 b3 ed ff ff       	call   80100390 <panic>
801015dd:	8d 76 00             	lea    0x0(%esi),%esi

801015e0 <iupdate>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	56                   	push   %esi
801015e4:	53                   	push   %ebx
801015e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e8:	83 ec 08             	sub    $0x8,%esp
801015eb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ee:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015f1:	c1 e8 03             	shr    $0x3,%eax
801015f4:	03 05 94 1c 11 80    	add    0x80111c94,%eax
801015fa:	50                   	push   %eax
801015fb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015fe:	e8 cd ea ff ff       	call   801000d0 <bread>
80101603:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101605:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101608:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010160c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010160f:	83 e0 07             	and    $0x7,%eax
80101612:	c1 e0 06             	shl    $0x6,%eax
80101615:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101619:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010161c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101620:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101623:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101627:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010162b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010162f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101633:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101637:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010163a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010163d:	6a 34                	push   $0x34
8010163f:	53                   	push   %ebx
80101640:	50                   	push   %eax
80101641:	e8 2a 36 00 00       	call   80104c70 <memmove>
  log_write(bp);
80101646:	89 34 24             	mov    %esi,(%esp)
80101649:	e8 32 17 00 00       	call   80102d80 <log_write>
  brelse(bp);
8010164e:	89 75 08             	mov    %esi,0x8(%ebp)
80101651:	83 c4 10             	add    $0x10,%esp
}
80101654:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101657:	5b                   	pop    %ebx
80101658:	5e                   	pop    %esi
80101659:	5d                   	pop    %ebp
  brelse(bp);
8010165a:	e9 81 eb ff ff       	jmp    801001e0 <brelse>
8010165f:	90                   	nop

80101660 <idup>:
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	53                   	push   %ebx
80101664:	83 ec 10             	sub    $0x10,%esp
80101667:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010166a:	68 a0 1c 11 80       	push   $0x80111ca0
8010166f:	e8 3c 34 00 00       	call   80104ab0 <acquire>
  ip->ref++;
80101674:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101678:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
8010167f:	e8 ec 34 00 00       	call   80104b70 <release>
}
80101684:	89 d8                	mov    %ebx,%eax
80101686:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101689:	c9                   	leave  
8010168a:	c3                   	ret    
8010168b:	90                   	nop
8010168c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101690 <ilock>:
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	56                   	push   %esi
80101694:	53                   	push   %ebx
80101695:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101698:	85 db                	test   %ebx,%ebx
8010169a:	0f 84 b7 00 00 00    	je     80101757 <ilock+0xc7>
801016a0:	8b 53 08             	mov    0x8(%ebx),%edx
801016a3:	85 d2                	test   %edx,%edx
801016a5:	0f 8e ac 00 00 00    	jle    80101757 <ilock+0xc7>
  acquiresleep(&ip->lock);
801016ab:	8d 43 0c             	lea    0xc(%ebx),%eax
801016ae:	83 ec 0c             	sub    $0xc,%esp
801016b1:	50                   	push   %eax
801016b2:	e8 c9 31 00 00       	call   80104880 <acquiresleep>
  if(ip->valid == 0){
801016b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016ba:	83 c4 10             	add    $0x10,%esp
801016bd:	85 c0                	test   %eax,%eax
801016bf:	74 0f                	je     801016d0 <ilock+0x40>
}
801016c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016c4:	5b                   	pop    %ebx
801016c5:	5e                   	pop    %esi
801016c6:	5d                   	pop    %ebp
801016c7:	c3                   	ret    
801016c8:	90                   	nop
801016c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016d0:	8b 43 04             	mov    0x4(%ebx),%eax
801016d3:	83 ec 08             	sub    $0x8,%esp
801016d6:	c1 e8 03             	shr    $0x3,%eax
801016d9:	03 05 94 1c 11 80    	add    0x80111c94,%eax
801016df:	50                   	push   %eax
801016e0:	ff 33                	pushl  (%ebx)
801016e2:	e8 e9 e9 ff ff       	call   801000d0 <bread>
801016e7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016e9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016ef:	83 e0 07             	and    $0x7,%eax
801016f2:	c1 e0 06             	shl    $0x6,%eax
801016f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101703:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101707:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010170b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010170f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101713:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101717:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010171b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010171e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101721:	6a 34                	push   $0x34
80101723:	50                   	push   %eax
80101724:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101727:	50                   	push   %eax
80101728:	e8 43 35 00 00       	call   80104c70 <memmove>
    brelse(bp);
8010172d:	89 34 24             	mov    %esi,(%esp)
80101730:	e8 ab ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101735:	83 c4 10             	add    $0x10,%esp
80101738:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010173d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101744:	0f 85 77 ff ff ff    	jne    801016c1 <ilock+0x31>
      panic("ilock: no type");
8010174a:	83 ec 0c             	sub    $0xc,%esp
8010174d:	68 70 78 10 80       	push   $0x80107870
80101752:	e8 39 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101757:	83 ec 0c             	sub    $0xc,%esp
8010175a:	68 6a 78 10 80       	push   $0x8010786a
8010175f:	e8 2c ec ff ff       	call   80100390 <panic>
80101764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010176a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101770 <iunlock>:
{
80101770:	55                   	push   %ebp
80101771:	89 e5                	mov    %esp,%ebp
80101773:	56                   	push   %esi
80101774:	53                   	push   %ebx
80101775:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101778:	85 db                	test   %ebx,%ebx
8010177a:	74 28                	je     801017a4 <iunlock+0x34>
8010177c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010177f:	83 ec 0c             	sub    $0xc,%esp
80101782:	56                   	push   %esi
80101783:	e8 98 31 00 00       	call   80104920 <holdingsleep>
80101788:	83 c4 10             	add    $0x10,%esp
8010178b:	85 c0                	test   %eax,%eax
8010178d:	74 15                	je     801017a4 <iunlock+0x34>
8010178f:	8b 43 08             	mov    0x8(%ebx),%eax
80101792:	85 c0                	test   %eax,%eax
80101794:	7e 0e                	jle    801017a4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101796:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101799:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010179c:	5b                   	pop    %ebx
8010179d:	5e                   	pop    %esi
8010179e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010179f:	e9 3c 31 00 00       	jmp    801048e0 <releasesleep>
    panic("iunlock");
801017a4:	83 ec 0c             	sub    $0xc,%esp
801017a7:	68 7f 78 10 80       	push   $0x8010787f
801017ac:	e8 df eb ff ff       	call   80100390 <panic>
801017b1:	eb 0d                	jmp    801017c0 <iput>
801017b3:	90                   	nop
801017b4:	90                   	nop
801017b5:	90                   	nop
801017b6:	90                   	nop
801017b7:	90                   	nop
801017b8:	90                   	nop
801017b9:	90                   	nop
801017ba:	90                   	nop
801017bb:	90                   	nop
801017bc:	90                   	nop
801017bd:	90                   	nop
801017be:	90                   	nop
801017bf:	90                   	nop

801017c0 <iput>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	57                   	push   %edi
801017c4:	56                   	push   %esi
801017c5:	53                   	push   %ebx
801017c6:	83 ec 28             	sub    $0x28,%esp
801017c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017cc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017cf:	57                   	push   %edi
801017d0:	e8 ab 30 00 00       	call   80104880 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017d5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017d8:	83 c4 10             	add    $0x10,%esp
801017db:	85 d2                	test   %edx,%edx
801017dd:	74 07                	je     801017e6 <iput+0x26>
801017df:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017e4:	74 32                	je     80101818 <iput+0x58>
  releasesleep(&ip->lock);
801017e6:	83 ec 0c             	sub    $0xc,%esp
801017e9:	57                   	push   %edi
801017ea:	e8 f1 30 00 00       	call   801048e0 <releasesleep>
  acquire(&icache.lock);
801017ef:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
801017f6:	e8 b5 32 00 00       	call   80104ab0 <acquire>
  ip->ref--;
801017fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ff:	83 c4 10             	add    $0x10,%esp
80101802:	c7 45 08 a0 1c 11 80 	movl   $0x80111ca0,0x8(%ebp)
}
80101809:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010180c:	5b                   	pop    %ebx
8010180d:	5e                   	pop    %esi
8010180e:	5f                   	pop    %edi
8010180f:	5d                   	pop    %ebp
  release(&icache.lock);
80101810:	e9 5b 33 00 00       	jmp    80104b70 <release>
80101815:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101818:	83 ec 0c             	sub    $0xc,%esp
8010181b:	68 a0 1c 11 80       	push   $0x80111ca0
80101820:	e8 8b 32 00 00       	call   80104ab0 <acquire>
    int r = ip->ref;
80101825:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101828:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
8010182f:	e8 3c 33 00 00       	call   80104b70 <release>
    if(r == 1){
80101834:	83 c4 10             	add    $0x10,%esp
80101837:	83 fe 01             	cmp    $0x1,%esi
8010183a:	75 aa                	jne    801017e6 <iput+0x26>
8010183c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101842:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101845:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101848:	89 cf                	mov    %ecx,%edi
8010184a:	eb 0b                	jmp    80101857 <iput+0x97>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101853:	39 fe                	cmp    %edi,%esi
80101855:	74 19                	je     80101870 <iput+0xb0>
    if(ip->addrs[i]){
80101857:	8b 16                	mov    (%esi),%edx
80101859:	85 d2                	test   %edx,%edx
8010185b:	74 f3                	je     80101850 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010185d:	8b 03                	mov    (%ebx),%eax
8010185f:	e8 ac fb ff ff       	call   80101410 <bfree>
      ip->addrs[i] = 0;
80101864:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010186a:	eb e4                	jmp    80101850 <iput+0x90>
8010186c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101870:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101876:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101879:	85 c0                	test   %eax,%eax
8010187b:	75 33                	jne    801018b0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010187d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101880:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101887:	53                   	push   %ebx
80101888:	e8 53 fd ff ff       	call   801015e0 <iupdate>
      ip->type = 0;
8010188d:	31 c0                	xor    %eax,%eax
8010188f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101893:	89 1c 24             	mov    %ebx,(%esp)
80101896:	e8 45 fd ff ff       	call   801015e0 <iupdate>
      ip->valid = 0;
8010189b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018a2:	83 c4 10             	add    $0x10,%esp
801018a5:	e9 3c ff ff ff       	jmp    801017e6 <iput+0x26>
801018aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018b0:	83 ec 08             	sub    $0x8,%esp
801018b3:	50                   	push   %eax
801018b4:	ff 33                	pushl  (%ebx)
801018b6:	e8 15 e8 ff ff       	call   801000d0 <bread>
801018bb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018c1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018c7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018ca:	83 c4 10             	add    $0x10,%esp
801018cd:	89 cf                	mov    %ecx,%edi
801018cf:	eb 0e                	jmp    801018df <iput+0x11f>
801018d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018d8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018db:	39 fe                	cmp    %edi,%esi
801018dd:	74 0f                	je     801018ee <iput+0x12e>
      if(a[j])
801018df:	8b 16                	mov    (%esi),%edx
801018e1:	85 d2                	test   %edx,%edx
801018e3:	74 f3                	je     801018d8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018e5:	8b 03                	mov    (%ebx),%eax
801018e7:	e8 24 fb ff ff       	call   80101410 <bfree>
801018ec:	eb ea                	jmp    801018d8 <iput+0x118>
    brelse(bp);
801018ee:	83 ec 0c             	sub    $0xc,%esp
801018f1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018f4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018f7:	e8 e4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018fc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101902:	8b 03                	mov    (%ebx),%eax
80101904:	e8 07 fb ff ff       	call   80101410 <bfree>
    ip->addrs[NDIRECT] = 0;
80101909:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101910:	00 00 00 
80101913:	83 c4 10             	add    $0x10,%esp
80101916:	e9 62 ff ff ff       	jmp    8010187d <iput+0xbd>
8010191b:	90                   	nop
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <iunlockput>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	53                   	push   %ebx
80101924:	83 ec 10             	sub    $0x10,%esp
80101927:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010192a:	53                   	push   %ebx
8010192b:	e8 40 fe ff ff       	call   80101770 <iunlock>
  iput(ip);
80101930:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101933:	83 c4 10             	add    $0x10,%esp
}
80101936:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101939:	c9                   	leave  
  iput(ip);
8010193a:	e9 81 fe ff ff       	jmp    801017c0 <iput>
8010193f:	90                   	nop

80101940 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	8b 55 08             	mov    0x8(%ebp),%edx
80101946:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101949:	8b 0a                	mov    (%edx),%ecx
8010194b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010194e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101951:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101954:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101958:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010195b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010195f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101963:	8b 52 58             	mov    0x58(%edx),%edx
80101966:	89 50 10             	mov    %edx,0x10(%eax)
}
80101969:	5d                   	pop    %ebp
8010196a:	c3                   	ret    
8010196b:	90                   	nop
8010196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101970 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	57                   	push   %edi
80101974:	56                   	push   %esi
80101975:	53                   	push   %ebx
80101976:	83 ec 1c             	sub    $0x1c,%esp
80101979:	8b 45 08             	mov    0x8(%ebp),%eax
8010197c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010197f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101982:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101987:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010198a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010198d:	8b 75 10             	mov    0x10(%ebp),%esi
80101990:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101993:	0f 84 a7 00 00 00    	je     80101a40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101999:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010199c:	8b 40 58             	mov    0x58(%eax),%eax
8010199f:	39 c6                	cmp    %eax,%esi
801019a1:	0f 87 ba 00 00 00    	ja     80101a61 <readi+0xf1>
801019a7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019aa:	89 f9                	mov    %edi,%ecx
801019ac:	01 f1                	add    %esi,%ecx
801019ae:	0f 82 ad 00 00 00    	jb     80101a61 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019b4:	89 c2                	mov    %eax,%edx
801019b6:	29 f2                	sub    %esi,%edx
801019b8:	39 c8                	cmp    %ecx,%eax
801019ba:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019bd:	31 ff                	xor    %edi,%edi
801019bf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019c1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019c4:	74 6c                	je     80101a32 <readi+0xc2>
801019c6:	8d 76 00             	lea    0x0(%esi),%esi
801019c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019d0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019d3:	89 f2                	mov    %esi,%edx
801019d5:	c1 ea 09             	shr    $0x9,%edx
801019d8:	89 d8                	mov    %ebx,%eax
801019da:	e8 11 f9 ff ff       	call   801012f0 <bmap>
801019df:	83 ec 08             	sub    $0x8,%esp
801019e2:	50                   	push   %eax
801019e3:	ff 33                	pushl  (%ebx)
801019e5:	e8 e6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019ea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019ed:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019ef:	89 f0                	mov    %esi,%eax
801019f1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019f6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019fb:	83 c4 0c             	add    $0xc,%esp
801019fe:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a00:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a04:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a07:	29 fb                	sub    %edi,%ebx
80101a09:	39 d9                	cmp    %ebx,%ecx
80101a0b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a0e:	53                   	push   %ebx
80101a0f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a10:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a12:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a15:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a17:	e8 54 32 00 00       	call   80104c70 <memmove>
    brelse(bp);
80101a1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a1f:	89 14 24             	mov    %edx,(%esp)
80101a22:	e8 b9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a2a:	83 c4 10             	add    $0x10,%esp
80101a2d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a30:	77 9e                	ja     801019d0 <readi+0x60>
  }
  return n;
80101a32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a38:	5b                   	pop    %ebx
80101a39:	5e                   	pop    %esi
80101a3a:	5f                   	pop    %edi
80101a3b:	5d                   	pop    %ebp
80101a3c:	c3                   	ret    
80101a3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a44:	66 83 f8 09          	cmp    $0x9,%ax
80101a48:	77 17                	ja     80101a61 <readi+0xf1>
80101a4a:	8b 04 c5 20 1c 11 80 	mov    -0x7feee3e0(,%eax,8),%eax
80101a51:	85 c0                	test   %eax,%eax
80101a53:	74 0c                	je     80101a61 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a5b:	5b                   	pop    %ebx
80101a5c:	5e                   	pop    %esi
80101a5d:	5f                   	pop    %edi
80101a5e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a5f:	ff e0                	jmp    *%eax
      return -1;
80101a61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a66:	eb cd                	jmp    80101a35 <readi+0xc5>
80101a68:	90                   	nop
80101a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	57                   	push   %edi
80101a74:	56                   	push   %esi
80101a75:	53                   	push   %ebx
80101a76:	83 ec 1c             	sub    $0x1c,%esp
80101a79:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a87:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a90:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a93:	0f 84 b7 00 00 00    	je     80101b50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a9c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a9f:	0f 82 eb 00 00 00    	jb     80101b90 <writei+0x120>
80101aa5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101aa8:	31 d2                	xor    %edx,%edx
80101aaa:	89 f8                	mov    %edi,%eax
80101aac:	01 f0                	add    %esi,%eax
80101aae:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ab1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ab6:	0f 87 d4 00 00 00    	ja     80101b90 <writei+0x120>
80101abc:	85 d2                	test   %edx,%edx
80101abe:	0f 85 cc 00 00 00    	jne    80101b90 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ac4:	85 ff                	test   %edi,%edi
80101ac6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101acd:	74 72                	je     80101b41 <writei+0xd1>
80101acf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ad0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ad3:	89 f2                	mov    %esi,%edx
80101ad5:	c1 ea 09             	shr    $0x9,%edx
80101ad8:	89 f8                	mov    %edi,%eax
80101ada:	e8 11 f8 ff ff       	call   801012f0 <bmap>
80101adf:	83 ec 08             	sub    $0x8,%esp
80101ae2:	50                   	push   %eax
80101ae3:	ff 37                	pushl  (%edi)
80101ae5:	e8 e6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aea:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101aed:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101af2:	89 f0                	mov    %esi,%eax
80101af4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101af9:	83 c4 0c             	add    $0xc,%esp
80101afc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b01:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b03:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b07:	39 d9                	cmp    %ebx,%ecx
80101b09:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b0c:	53                   	push   %ebx
80101b0d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b10:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b12:	50                   	push   %eax
80101b13:	e8 58 31 00 00       	call   80104c70 <memmove>
    log_write(bp);
80101b18:	89 3c 24             	mov    %edi,(%esp)
80101b1b:	e8 60 12 00 00       	call   80102d80 <log_write>
    brelse(bp);
80101b20:	89 3c 24             	mov    %edi,(%esp)
80101b23:	e8 b8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b28:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b2b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b2e:	83 c4 10             	add    $0x10,%esp
80101b31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b34:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b37:	77 97                	ja     80101ad0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b3c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b3f:	77 37                	ja     80101b78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b41:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b47:	5b                   	pop    %ebx
80101b48:	5e                   	pop    %esi
80101b49:	5f                   	pop    %edi
80101b4a:	5d                   	pop    %ebp
80101b4b:	c3                   	ret    
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b54:	66 83 f8 09          	cmp    $0x9,%ax
80101b58:	77 36                	ja     80101b90 <writei+0x120>
80101b5a:	8b 04 c5 24 1c 11 80 	mov    -0x7feee3dc(,%eax,8),%eax
80101b61:	85 c0                	test   %eax,%eax
80101b63:	74 2b                	je     80101b90 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b6b:	5b                   	pop    %ebx
80101b6c:	5e                   	pop    %esi
80101b6d:	5f                   	pop    %edi
80101b6e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b6f:	ff e0                	jmp    *%eax
80101b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b78:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b7b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b7e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b81:	50                   	push   %eax
80101b82:	e8 59 fa ff ff       	call   801015e0 <iupdate>
80101b87:	83 c4 10             	add    $0x10,%esp
80101b8a:	eb b5                	jmp    80101b41 <writei+0xd1>
80101b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b95:	eb ad                	jmp    80101b44 <writei+0xd4>
80101b97:	89 f6                	mov    %esi,%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ba0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ba6:	6a 0e                	push   $0xe
80101ba8:	ff 75 0c             	pushl  0xc(%ebp)
80101bab:	ff 75 08             	pushl  0x8(%ebp)
80101bae:	e8 2d 31 00 00       	call   80104ce0 <strncmp>
}
80101bb3:	c9                   	leave  
80101bb4:	c3                   	ret    
80101bb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 1c             	sub    $0x1c,%esp
80101bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bd1:	0f 85 85 00 00 00    	jne    80101c5c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bda:	31 ff                	xor    %edi,%edi
80101bdc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bdf:	85 d2                	test   %edx,%edx
80101be1:	74 3e                	je     80101c21 <dirlookup+0x61>
80101be3:	90                   	nop
80101be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101be8:	6a 10                	push   $0x10
80101bea:	57                   	push   %edi
80101beb:	56                   	push   %esi
80101bec:	53                   	push   %ebx
80101bed:	e8 7e fd ff ff       	call   80101970 <readi>
80101bf2:	83 c4 10             	add    $0x10,%esp
80101bf5:	83 f8 10             	cmp    $0x10,%eax
80101bf8:	75 55                	jne    80101c4f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101bfa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bff:	74 18                	je     80101c19 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c01:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c04:	83 ec 04             	sub    $0x4,%esp
80101c07:	6a 0e                	push   $0xe
80101c09:	50                   	push   %eax
80101c0a:	ff 75 0c             	pushl  0xc(%ebp)
80101c0d:	e8 ce 30 00 00       	call   80104ce0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c12:	83 c4 10             	add    $0x10,%esp
80101c15:	85 c0                	test   %eax,%eax
80101c17:	74 17                	je     80101c30 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c19:	83 c7 10             	add    $0x10,%edi
80101c1c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c1f:	72 c7                	jb     80101be8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c21:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c24:	31 c0                	xor    %eax,%eax
}
80101c26:	5b                   	pop    %ebx
80101c27:	5e                   	pop    %esi
80101c28:	5f                   	pop    %edi
80101c29:	5d                   	pop    %ebp
80101c2a:	c3                   	ret    
80101c2b:	90                   	nop
80101c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c30:	8b 45 10             	mov    0x10(%ebp),%eax
80101c33:	85 c0                	test   %eax,%eax
80101c35:	74 05                	je     80101c3c <dirlookup+0x7c>
        *poff = off;
80101c37:	8b 45 10             	mov    0x10(%ebp),%eax
80101c3a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c3c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c40:	8b 03                	mov    (%ebx),%eax
80101c42:	e8 d9 f5 ff ff       	call   80101220 <iget>
}
80101c47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c4a:	5b                   	pop    %ebx
80101c4b:	5e                   	pop    %esi
80101c4c:	5f                   	pop    %edi
80101c4d:	5d                   	pop    %ebp
80101c4e:	c3                   	ret    
      panic("dirlookup read");
80101c4f:	83 ec 0c             	sub    $0xc,%esp
80101c52:	68 99 78 10 80       	push   $0x80107899
80101c57:	e8 34 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c5c:	83 ec 0c             	sub    $0xc,%esp
80101c5f:	68 87 78 10 80       	push   $0x80107887
80101c64:	e8 27 e7 ff ff       	call   80100390 <panic>
80101c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	89 cf                	mov    %ecx,%edi
80101c78:	89 c3                	mov    %eax,%ebx
80101c7a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c7d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c80:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c83:	0f 84 67 01 00 00    	je     80101df0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c89:	e8 d2 1e 00 00       	call   80103b60 <myproc>
  acquire(&icache.lock);
80101c8e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101c91:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101c94:	68 a0 1c 11 80       	push   $0x80111ca0
80101c99:	e8 12 2e 00 00       	call   80104ab0 <acquire>
  ip->ref++;
80101c9e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ca2:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80101ca9:	e8 c2 2e 00 00       	call   80104b70 <release>
80101cae:	83 c4 10             	add    $0x10,%esp
80101cb1:	eb 08                	jmp    80101cbb <namex+0x4b>
80101cb3:	90                   	nop
80101cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101cb8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cbb:	0f b6 03             	movzbl (%ebx),%eax
80101cbe:	3c 2f                	cmp    $0x2f,%al
80101cc0:	74 f6                	je     80101cb8 <namex+0x48>
  if(*path == 0)
80101cc2:	84 c0                	test   %al,%al
80101cc4:	0f 84 ee 00 00 00    	je     80101db8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cca:	0f b6 03             	movzbl (%ebx),%eax
80101ccd:	3c 2f                	cmp    $0x2f,%al
80101ccf:	0f 84 b3 00 00 00    	je     80101d88 <namex+0x118>
80101cd5:	84 c0                	test   %al,%al
80101cd7:	89 da                	mov    %ebx,%edx
80101cd9:	75 09                	jne    80101ce4 <namex+0x74>
80101cdb:	e9 a8 00 00 00       	jmp    80101d88 <namex+0x118>
80101ce0:	84 c0                	test   %al,%al
80101ce2:	74 0a                	je     80101cee <namex+0x7e>
    path++;
80101ce4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101ce7:	0f b6 02             	movzbl (%edx),%eax
80101cea:	3c 2f                	cmp    $0x2f,%al
80101cec:	75 f2                	jne    80101ce0 <namex+0x70>
80101cee:	89 d1                	mov    %edx,%ecx
80101cf0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101cf2:	83 f9 0d             	cmp    $0xd,%ecx
80101cf5:	0f 8e 91 00 00 00    	jle    80101d8c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101cfb:	83 ec 04             	sub    $0x4,%esp
80101cfe:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d01:	6a 0e                	push   $0xe
80101d03:	53                   	push   %ebx
80101d04:	57                   	push   %edi
80101d05:	e8 66 2f 00 00       	call   80104c70 <memmove>
    path++;
80101d0a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d0d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d10:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d12:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d15:	75 11                	jne    80101d28 <namex+0xb8>
80101d17:	89 f6                	mov    %esi,%esi
80101d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d20:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d23:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d26:	74 f8                	je     80101d20 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d28:	83 ec 0c             	sub    $0xc,%esp
80101d2b:	56                   	push   %esi
80101d2c:	e8 5f f9 ff ff       	call   80101690 <ilock>
    if(ip->type != T_DIR){
80101d31:	83 c4 10             	add    $0x10,%esp
80101d34:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d39:	0f 85 91 00 00 00    	jne    80101dd0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d3f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d42:	85 d2                	test   %edx,%edx
80101d44:	74 09                	je     80101d4f <namex+0xdf>
80101d46:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d49:	0f 84 b7 00 00 00    	je     80101e06 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d4f:	83 ec 04             	sub    $0x4,%esp
80101d52:	6a 00                	push   $0x0
80101d54:	57                   	push   %edi
80101d55:	56                   	push   %esi
80101d56:	e8 65 fe ff ff       	call   80101bc0 <dirlookup>
80101d5b:	83 c4 10             	add    $0x10,%esp
80101d5e:	85 c0                	test   %eax,%eax
80101d60:	74 6e                	je     80101dd0 <namex+0x160>
  iunlock(ip);
80101d62:	83 ec 0c             	sub    $0xc,%esp
80101d65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d68:	56                   	push   %esi
80101d69:	e8 02 fa ff ff       	call   80101770 <iunlock>
  iput(ip);
80101d6e:	89 34 24             	mov    %esi,(%esp)
80101d71:	e8 4a fa ff ff       	call   801017c0 <iput>
80101d76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d79:	83 c4 10             	add    $0x10,%esp
80101d7c:	89 c6                	mov    %eax,%esi
80101d7e:	e9 38 ff ff ff       	jmp    80101cbb <namex+0x4b>
80101d83:	90                   	nop
80101d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d88:	89 da                	mov    %ebx,%edx
80101d8a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d8c:	83 ec 04             	sub    $0x4,%esp
80101d8f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d92:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d95:	51                   	push   %ecx
80101d96:	53                   	push   %ebx
80101d97:	57                   	push   %edi
80101d98:	e8 d3 2e 00 00       	call   80104c70 <memmove>
    name[len] = 0;
80101d9d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101da0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101da3:	83 c4 10             	add    $0x10,%esp
80101da6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101daa:	89 d3                	mov    %edx,%ebx
80101dac:	e9 61 ff ff ff       	jmp    80101d12 <namex+0xa2>
80101db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101db8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dbb:	85 c0                	test   %eax,%eax
80101dbd:	75 5d                	jne    80101e1c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101dbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dc2:	89 f0                	mov    %esi,%eax
80101dc4:	5b                   	pop    %ebx
80101dc5:	5e                   	pop    %esi
80101dc6:	5f                   	pop    %edi
80101dc7:	5d                   	pop    %ebp
80101dc8:	c3                   	ret    
80101dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101dd0:	83 ec 0c             	sub    $0xc,%esp
80101dd3:	56                   	push   %esi
80101dd4:	e8 97 f9 ff ff       	call   80101770 <iunlock>
  iput(ip);
80101dd9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101ddc:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dde:	e8 dd f9 ff ff       	call   801017c0 <iput>
      return 0;
80101de3:	83 c4 10             	add    $0x10,%esp
}
80101de6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de9:	89 f0                	mov    %esi,%eax
80101deb:	5b                   	pop    %ebx
80101dec:	5e                   	pop    %esi
80101ded:	5f                   	pop    %edi
80101dee:	5d                   	pop    %ebp
80101def:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101df0:	ba 01 00 00 00       	mov    $0x1,%edx
80101df5:	b8 01 00 00 00       	mov    $0x1,%eax
80101dfa:	e8 21 f4 ff ff       	call   80101220 <iget>
80101dff:	89 c6                	mov    %eax,%esi
80101e01:	e9 b5 fe ff ff       	jmp    80101cbb <namex+0x4b>
      iunlock(ip);
80101e06:	83 ec 0c             	sub    $0xc,%esp
80101e09:	56                   	push   %esi
80101e0a:	e8 61 f9 ff ff       	call   80101770 <iunlock>
      return ip;
80101e0f:	83 c4 10             	add    $0x10,%esp
}
80101e12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e15:	89 f0                	mov    %esi,%eax
80101e17:	5b                   	pop    %ebx
80101e18:	5e                   	pop    %esi
80101e19:	5f                   	pop    %edi
80101e1a:	5d                   	pop    %ebp
80101e1b:	c3                   	ret    
    iput(ip);
80101e1c:	83 ec 0c             	sub    $0xc,%esp
80101e1f:	56                   	push   %esi
    return 0;
80101e20:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e22:	e8 99 f9 ff ff       	call   801017c0 <iput>
    return 0;
80101e27:	83 c4 10             	add    $0x10,%esp
80101e2a:	eb 93                	jmp    80101dbf <namex+0x14f>
80101e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e30 <dirlink>:
{
80101e30:	55                   	push   %ebp
80101e31:	89 e5                	mov    %esp,%ebp
80101e33:	57                   	push   %edi
80101e34:	56                   	push   %esi
80101e35:	53                   	push   %ebx
80101e36:	83 ec 20             	sub    $0x20,%esp
80101e39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e3c:	6a 00                	push   $0x0
80101e3e:	ff 75 0c             	pushl  0xc(%ebp)
80101e41:	53                   	push   %ebx
80101e42:	e8 79 fd ff ff       	call   80101bc0 <dirlookup>
80101e47:	83 c4 10             	add    $0x10,%esp
80101e4a:	85 c0                	test   %eax,%eax
80101e4c:	75 67                	jne    80101eb5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e4e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e51:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e54:	85 ff                	test   %edi,%edi
80101e56:	74 29                	je     80101e81 <dirlink+0x51>
80101e58:	31 ff                	xor    %edi,%edi
80101e5a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e5d:	eb 09                	jmp    80101e68 <dirlink+0x38>
80101e5f:	90                   	nop
80101e60:	83 c7 10             	add    $0x10,%edi
80101e63:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e66:	73 19                	jae    80101e81 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e68:	6a 10                	push   $0x10
80101e6a:	57                   	push   %edi
80101e6b:	56                   	push   %esi
80101e6c:	53                   	push   %ebx
80101e6d:	e8 fe fa ff ff       	call   80101970 <readi>
80101e72:	83 c4 10             	add    $0x10,%esp
80101e75:	83 f8 10             	cmp    $0x10,%eax
80101e78:	75 4e                	jne    80101ec8 <dirlink+0x98>
    if(de.inum == 0)
80101e7a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e7f:	75 df                	jne    80101e60 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e81:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e84:	83 ec 04             	sub    $0x4,%esp
80101e87:	6a 0e                	push   $0xe
80101e89:	ff 75 0c             	pushl  0xc(%ebp)
80101e8c:	50                   	push   %eax
80101e8d:	e8 ae 2e 00 00       	call   80104d40 <strncpy>
  de.inum = inum;
80101e92:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e95:	6a 10                	push   $0x10
80101e97:	57                   	push   %edi
80101e98:	56                   	push   %esi
80101e99:	53                   	push   %ebx
  de.inum = inum;
80101e9a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e9e:	e8 cd fb ff ff       	call   80101a70 <writei>
80101ea3:	83 c4 20             	add    $0x20,%esp
80101ea6:	83 f8 10             	cmp    $0x10,%eax
80101ea9:	75 2a                	jne    80101ed5 <dirlink+0xa5>
  return 0;
80101eab:	31 c0                	xor    %eax,%eax
}
80101ead:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eb0:	5b                   	pop    %ebx
80101eb1:	5e                   	pop    %esi
80101eb2:	5f                   	pop    %edi
80101eb3:	5d                   	pop    %ebp
80101eb4:	c3                   	ret    
    iput(ip);
80101eb5:	83 ec 0c             	sub    $0xc,%esp
80101eb8:	50                   	push   %eax
80101eb9:	e8 02 f9 ff ff       	call   801017c0 <iput>
    return -1;
80101ebe:	83 c4 10             	add    $0x10,%esp
80101ec1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ec6:	eb e5                	jmp    80101ead <dirlink+0x7d>
      panic("dirlink read");
80101ec8:	83 ec 0c             	sub    $0xc,%esp
80101ecb:	68 a8 78 10 80       	push   $0x801078a8
80101ed0:	e8 bb e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ed5:	83 ec 0c             	sub    $0xc,%esp
80101ed8:	68 2a 7f 10 80       	push   $0x80107f2a
80101edd:	e8 ae e4 ff ff       	call   80100390 <panic>
80101ee2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ef0 <namei>:

struct inode*
namei(char *path)
{
80101ef0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ef1:	31 d2                	xor    %edx,%edx
{
80101ef3:	89 e5                	mov    %esp,%ebp
80101ef5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101ef8:	8b 45 08             	mov    0x8(%ebp),%eax
80101efb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101efe:	e8 6d fd ff ff       	call   80101c70 <namex>
}
80101f03:	c9                   	leave  
80101f04:	c3                   	ret    
80101f05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f10 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f10:	55                   	push   %ebp
  return namex(path, 1, name);
80101f11:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f16:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f18:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f1b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f1e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f1f:	e9 4c fd ff ff       	jmp    80101c70 <namex>
80101f24:	66 90                	xchg   %ax,%ax
80101f26:	66 90                	xchg   %ax,%ax
80101f28:	66 90                	xchg   %ax,%ax
80101f2a:	66 90                	xchg   %ax,%ax
80101f2c:	66 90                	xchg   %ax,%ax
80101f2e:	66 90                	xchg   %ax,%ax

80101f30 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f30:	55                   	push   %ebp
80101f31:	89 e5                	mov    %esp,%ebp
80101f33:	57                   	push   %edi
80101f34:	56                   	push   %esi
80101f35:	53                   	push   %ebx
80101f36:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f39:	85 c0                	test   %eax,%eax
80101f3b:	0f 84 b4 00 00 00    	je     80101ff5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f41:	8b 58 08             	mov    0x8(%eax),%ebx
80101f44:	89 c6                	mov    %eax,%esi
80101f46:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f4c:	0f 87 96 00 00 00    	ja     80101fe8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f52:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f57:	89 f6                	mov    %esi,%esi
80101f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f60:	89 ca                	mov    %ecx,%edx
80101f62:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f63:	83 e0 c0             	and    $0xffffffc0,%eax
80101f66:	3c 40                	cmp    $0x40,%al
80101f68:	75 f6                	jne    80101f60 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f6a:	31 ff                	xor    %edi,%edi
80101f6c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f71:	89 f8                	mov    %edi,%eax
80101f73:	ee                   	out    %al,(%dx)
80101f74:	b8 01 00 00 00       	mov    $0x1,%eax
80101f79:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f7e:	ee                   	out    %al,(%dx)
80101f7f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f84:	89 d8                	mov    %ebx,%eax
80101f86:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f87:	89 d8                	mov    %ebx,%eax
80101f89:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f8e:	c1 f8 08             	sar    $0x8,%eax
80101f91:	ee                   	out    %al,(%dx)
80101f92:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f97:	89 f8                	mov    %edi,%eax
80101f99:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f9a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f9e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fa3:	c1 e0 04             	shl    $0x4,%eax
80101fa6:	83 e0 10             	and    $0x10,%eax
80101fa9:	83 c8 e0             	or     $0xffffffe0,%eax
80101fac:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fad:	f6 06 04             	testb  $0x4,(%esi)
80101fb0:	75 16                	jne    80101fc8 <idestart+0x98>
80101fb2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fb7:	89 ca                	mov    %ecx,%edx
80101fb9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fbd:	5b                   	pop    %ebx
80101fbe:	5e                   	pop    %esi
80101fbf:	5f                   	pop    %edi
80101fc0:	5d                   	pop    %ebp
80101fc1:	c3                   	ret    
80101fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fc8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fcd:	89 ca                	mov    %ecx,%edx
80101fcf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fd0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fd5:	83 c6 5c             	add    $0x5c,%esi
80101fd8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fdd:	fc                   	cld    
80101fde:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fe0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe3:	5b                   	pop    %ebx
80101fe4:	5e                   	pop    %esi
80101fe5:	5f                   	pop    %edi
80101fe6:	5d                   	pop    %ebp
80101fe7:	c3                   	ret    
    panic("incorrect blockno");
80101fe8:	83 ec 0c             	sub    $0xc,%esp
80101feb:	68 14 79 10 80       	push   $0x80107914
80101ff0:	e8 9b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80101ff5:	83 ec 0c             	sub    $0xc,%esp
80101ff8:	68 0b 79 10 80       	push   $0x8010790b
80101ffd:	e8 8e e3 ff ff       	call   80100390 <panic>
80102002:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102010 <ideinit>:
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102016:	68 26 79 10 80       	push   $0x80107926
8010201b:	68 20 b8 10 80       	push   $0x8010b820
80102020:	e8 4b 29 00 00       	call   80104970 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102025:	58                   	pop    %eax
80102026:	a1 c0 3f 11 80       	mov    0x80113fc0,%eax
8010202b:	5a                   	pop    %edx
8010202c:	83 e8 01             	sub    $0x1,%eax
8010202f:	50                   	push   %eax
80102030:	6a 0e                	push   $0xe
80102032:	e8 a9 02 00 00       	call   801022e0 <ioapicenable>
80102037:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010203a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010203f:	90                   	nop
80102040:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102041:	83 e0 c0             	and    $0xffffffc0,%eax
80102044:	3c 40                	cmp    $0x40,%al
80102046:	75 f8                	jne    80102040 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102048:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010204d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102052:	ee                   	out    %al,(%dx)
80102053:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102058:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010205d:	eb 06                	jmp    80102065 <ideinit+0x55>
8010205f:	90                   	nop
  for(i=0; i<1000; i++){
80102060:	83 e9 01             	sub    $0x1,%ecx
80102063:	74 0f                	je     80102074 <ideinit+0x64>
80102065:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102066:	84 c0                	test   %al,%al
80102068:	74 f6                	je     80102060 <ideinit+0x50>
      havedisk1 = 1;
8010206a:	c7 05 00 b8 10 80 01 	movl   $0x1,0x8010b800
80102071:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102074:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102079:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010207e:	ee                   	out    %al,(%dx)
}
8010207f:	c9                   	leave  
80102080:	c3                   	ret    
80102081:	eb 0d                	jmp    80102090 <ideintr>
80102083:	90                   	nop
80102084:	90                   	nop
80102085:	90                   	nop
80102086:	90                   	nop
80102087:	90                   	nop
80102088:	90                   	nop
80102089:	90                   	nop
8010208a:	90                   	nop
8010208b:	90                   	nop
8010208c:	90                   	nop
8010208d:	90                   	nop
8010208e:	90                   	nop
8010208f:	90                   	nop

80102090 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102090:	55                   	push   %ebp
80102091:	89 e5                	mov    %esp,%ebp
80102093:	57                   	push   %edi
80102094:	56                   	push   %esi
80102095:	53                   	push   %ebx
80102096:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102099:	68 20 b8 10 80       	push   $0x8010b820
8010209e:	e8 0d 2a 00 00       	call   80104ab0 <acquire>

  if((b = idequeue) == 0){
801020a3:	8b 1d 04 b8 10 80    	mov    0x8010b804,%ebx
801020a9:	83 c4 10             	add    $0x10,%esp
801020ac:	85 db                	test   %ebx,%ebx
801020ae:	74 67                	je     80102117 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020b0:	8b 43 58             	mov    0x58(%ebx),%eax
801020b3:	a3 04 b8 10 80       	mov    %eax,0x8010b804

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020b8:	8b 3b                	mov    (%ebx),%edi
801020ba:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020c0:	75 31                	jne    801020f3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020c2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020c7:	89 f6                	mov    %esi,%esi
801020c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020d0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020d1:	89 c6                	mov    %eax,%esi
801020d3:	83 e6 c0             	and    $0xffffffc0,%esi
801020d6:	89 f1                	mov    %esi,%ecx
801020d8:	80 f9 40             	cmp    $0x40,%cl
801020db:	75 f3                	jne    801020d0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020dd:	a8 21                	test   $0x21,%al
801020df:	75 12                	jne    801020f3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020e1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020e4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020e9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020ee:	fc                   	cld    
801020ef:	f3 6d                	rep insl (%dx),%es:(%edi)
801020f1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020f3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801020f6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801020f9:	89 f9                	mov    %edi,%ecx
801020fb:	83 c9 02             	or     $0x2,%ecx
801020fe:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102100:	53                   	push   %ebx
80102101:	e8 da 23 00 00       	call   801044e0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102106:	a1 04 b8 10 80       	mov    0x8010b804,%eax
8010210b:	83 c4 10             	add    $0x10,%esp
8010210e:	85 c0                	test   %eax,%eax
80102110:	74 05                	je     80102117 <ideintr+0x87>
    idestart(idequeue);
80102112:	e8 19 fe ff ff       	call   80101f30 <idestart>
    release(&idelock);
80102117:	83 ec 0c             	sub    $0xc,%esp
8010211a:	68 20 b8 10 80       	push   $0x8010b820
8010211f:	e8 4c 2a 00 00       	call   80104b70 <release>

  release(&idelock);
}
80102124:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102127:	5b                   	pop    %ebx
80102128:	5e                   	pop    %esi
80102129:	5f                   	pop    %edi
8010212a:	5d                   	pop    %ebp
8010212b:	c3                   	ret    
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102130 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102130:	55                   	push   %ebp
80102131:	89 e5                	mov    %esp,%ebp
80102133:	53                   	push   %ebx
80102134:	83 ec 10             	sub    $0x10,%esp
80102137:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010213a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010213d:	50                   	push   %eax
8010213e:	e8 dd 27 00 00       	call   80104920 <holdingsleep>
80102143:	83 c4 10             	add    $0x10,%esp
80102146:	85 c0                	test   %eax,%eax
80102148:	0f 84 c6 00 00 00    	je     80102214 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010214e:	8b 03                	mov    (%ebx),%eax
80102150:	83 e0 06             	and    $0x6,%eax
80102153:	83 f8 02             	cmp    $0x2,%eax
80102156:	0f 84 ab 00 00 00    	je     80102207 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010215c:	8b 53 04             	mov    0x4(%ebx),%edx
8010215f:	85 d2                	test   %edx,%edx
80102161:	74 0d                	je     80102170 <iderw+0x40>
80102163:	a1 00 b8 10 80       	mov    0x8010b800,%eax
80102168:	85 c0                	test   %eax,%eax
8010216a:	0f 84 b1 00 00 00    	je     80102221 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102170:	83 ec 0c             	sub    $0xc,%esp
80102173:	68 20 b8 10 80       	push   $0x8010b820
80102178:	e8 33 29 00 00       	call   80104ab0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010217d:	8b 15 04 b8 10 80    	mov    0x8010b804,%edx
80102183:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102186:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218d:	85 d2                	test   %edx,%edx
8010218f:	75 09                	jne    8010219a <iderw+0x6a>
80102191:	eb 6d                	jmp    80102200 <iderw+0xd0>
80102193:	90                   	nop
80102194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102198:	89 c2                	mov    %eax,%edx
8010219a:	8b 42 58             	mov    0x58(%edx),%eax
8010219d:	85 c0                	test   %eax,%eax
8010219f:	75 f7                	jne    80102198 <iderw+0x68>
801021a1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021a4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021a6:	39 1d 04 b8 10 80    	cmp    %ebx,0x8010b804
801021ac:	74 42                	je     801021f0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ae:	8b 03                	mov    (%ebx),%eax
801021b0:	83 e0 06             	and    $0x6,%eax
801021b3:	83 f8 02             	cmp    $0x2,%eax
801021b6:	74 23                	je     801021db <iderw+0xab>
801021b8:	90                   	nop
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021c0:	83 ec 08             	sub    $0x8,%esp
801021c3:	68 20 b8 10 80       	push   $0x8010b820
801021c8:	53                   	push   %ebx
801021c9:	e8 52 21 00 00       	call   80104320 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ce:	8b 03                	mov    (%ebx),%eax
801021d0:	83 c4 10             	add    $0x10,%esp
801021d3:	83 e0 06             	and    $0x6,%eax
801021d6:	83 f8 02             	cmp    $0x2,%eax
801021d9:	75 e5                	jne    801021c0 <iderw+0x90>
  }


  release(&idelock);
801021db:	c7 45 08 20 b8 10 80 	movl   $0x8010b820,0x8(%ebp)
}
801021e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021e5:	c9                   	leave  
  release(&idelock);
801021e6:	e9 85 29 00 00       	jmp    80104b70 <release>
801021eb:	90                   	nop
801021ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801021f0:	89 d8                	mov    %ebx,%eax
801021f2:	e8 39 fd ff ff       	call   80101f30 <idestart>
801021f7:	eb b5                	jmp    801021ae <iderw+0x7e>
801021f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102200:	ba 04 b8 10 80       	mov    $0x8010b804,%edx
80102205:	eb 9d                	jmp    801021a4 <iderw+0x74>
    panic("iderw: nothing to do");
80102207:	83 ec 0c             	sub    $0xc,%esp
8010220a:	68 40 79 10 80       	push   $0x80107940
8010220f:	e8 7c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102214:	83 ec 0c             	sub    $0xc,%esp
80102217:	68 2a 79 10 80       	push   $0x8010792a
8010221c:	e8 6f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102221:	83 ec 0c             	sub    $0xc,%esp
80102224:	68 55 79 10 80       	push   $0x80107955
80102229:	e8 62 e1 ff ff       	call   80100390 <panic>
8010222e:	66 90                	xchg   %ax,%ax

80102230 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102230:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102231:	c7 05 f4 38 11 80 00 	movl   $0xfec00000,0x801138f4
80102238:	00 c0 fe 
{
8010223b:	89 e5                	mov    %esp,%ebp
8010223d:	56                   	push   %esi
8010223e:	53                   	push   %ebx
  ioapic->reg = reg;
8010223f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102246:	00 00 00 
  return ioapic->data;
80102249:	a1 f4 38 11 80       	mov    0x801138f4,%eax
8010224e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102251:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102257:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010225d:	0f b6 15 20 3a 11 80 	movzbl 0x80113a20,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102264:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102267:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010226a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010226d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102270:	39 c2                	cmp    %eax,%edx
80102272:	74 16                	je     8010228a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102274:	83 ec 0c             	sub    $0xc,%esp
80102277:	68 74 79 10 80       	push   $0x80107974
8010227c:	e8 df e3 ff ff       	call   80100660 <cprintf>
80102281:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
80102287:	83 c4 10             	add    $0x10,%esp
8010228a:	83 c3 21             	add    $0x21,%ebx
{
8010228d:	ba 10 00 00 00       	mov    $0x10,%edx
80102292:	b8 20 00 00 00       	mov    $0x20,%eax
80102297:	89 f6                	mov    %esi,%esi
80102299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801022a0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022a2:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022a8:	89 c6                	mov    %eax,%esi
801022aa:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022b0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022b3:	89 71 10             	mov    %esi,0x10(%ecx)
801022b6:	8d 72 01             	lea    0x1(%edx),%esi
801022b9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022bc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022be:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022c0:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
801022c6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022cd:	75 d1                	jne    801022a0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022d2:	5b                   	pop    %ebx
801022d3:	5e                   	pop    %esi
801022d4:	5d                   	pop    %ebp
801022d5:	c3                   	ret    
801022d6:	8d 76 00             	lea    0x0(%esi),%esi
801022d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022e0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022e0:	55                   	push   %ebp
  ioapic->reg = reg;
801022e1:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
{
801022e7:	89 e5                	mov    %esp,%ebp
801022e9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022ec:	8d 50 20             	lea    0x20(%eax),%edx
801022ef:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801022f3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022f5:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022fb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022fe:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102301:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102304:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102306:	a1 f4 38 11 80       	mov    0x801138f4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010230b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010230e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102311:	5d                   	pop    %ebp
80102312:	c3                   	ret    
80102313:	66 90                	xchg   %ax,%ax
80102315:	66 90                	xchg   %ax,%ax
80102317:	66 90                	xchg   %ax,%ax
80102319:	66 90                	xchg   %ax,%ax
8010231b:	66 90                	xchg   %ax,%ax
8010231d:	66 90                	xchg   %ax,%ax
8010231f:	90                   	nop

80102320 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	53                   	push   %ebx
80102324:	83 ec 04             	sub    $0x4,%esp
80102327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010232a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102330:	75 70                	jne    801023a2 <kfree+0x82>
80102332:	81 fb 08 3a 13 80    	cmp    $0x80133a08,%ebx
80102338:	72 68                	jb     801023a2 <kfree+0x82>
8010233a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102340:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102345:	77 5b                	ja     801023a2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102347:	83 ec 04             	sub    $0x4,%esp
8010234a:	68 00 10 00 00       	push   $0x1000
8010234f:	6a 01                	push   $0x1
80102351:	53                   	push   %ebx
80102352:	e8 69 28 00 00       	call   80104bc0 <memset>

  if(kmem.use_lock)
80102357:	8b 15 34 39 11 80    	mov    0x80113934,%edx
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	85 d2                	test   %edx,%edx
80102362:	75 2c                	jne    80102390 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102364:	a1 38 39 11 80       	mov    0x80113938,%eax
80102369:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010236b:	a1 34 39 11 80       	mov    0x80113934,%eax
  kmem.freelist = r;
80102370:	89 1d 38 39 11 80    	mov    %ebx,0x80113938
  if(kmem.use_lock)
80102376:	85 c0                	test   %eax,%eax
80102378:	75 06                	jne    80102380 <kfree+0x60>
    release(&kmem.lock);
}
8010237a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010237d:	c9                   	leave  
8010237e:	c3                   	ret    
8010237f:	90                   	nop
    release(&kmem.lock);
80102380:	c7 45 08 00 39 11 80 	movl   $0x80113900,0x8(%ebp)
}
80102387:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010238a:	c9                   	leave  
    release(&kmem.lock);
8010238b:	e9 e0 27 00 00       	jmp    80104b70 <release>
    acquire(&kmem.lock);
80102390:	83 ec 0c             	sub    $0xc,%esp
80102393:	68 00 39 11 80       	push   $0x80113900
80102398:	e8 13 27 00 00       	call   80104ab0 <acquire>
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	eb c2                	jmp    80102364 <kfree+0x44>
    panic("kfree");
801023a2:	83 ec 0c             	sub    $0xc,%esp
801023a5:	68 a6 79 10 80       	push   $0x801079a6
801023aa:	e8 e1 df ff ff       	call   80100390 <panic>
801023af:	90                   	nop

801023b0 <freerange>:
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023b5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023cd:	39 de                	cmp    %ebx,%esi
801023cf:	72 23                	jb     801023f4 <freerange+0x44>
801023d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023d8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023de:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023e7:	50                   	push   %eax
801023e8:	e8 33 ff ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023ed:	83 c4 10             	add    $0x10,%esp
801023f0:	39 f3                	cmp    %esi,%ebx
801023f2:	76 e4                	jbe    801023d8 <freerange+0x28>
}
801023f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023f7:	5b                   	pop    %ebx
801023f8:	5e                   	pop    %esi
801023f9:	5d                   	pop    %ebp
801023fa:	c3                   	ret    
801023fb:	90                   	nop
801023fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102400 <kinit1>:
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	56                   	push   %esi
80102404:	53                   	push   %ebx
80102405:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102408:	83 ec 08             	sub    $0x8,%esp
8010240b:	68 ac 79 10 80       	push   $0x801079ac
80102410:	68 00 39 11 80       	push   $0x80113900
80102415:	e8 56 25 00 00       	call   80104970 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010241a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010241d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102420:	c7 05 34 39 11 80 00 	movl   $0x0,0x80113934
80102427:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102430:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102436:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010243c:	39 de                	cmp    %ebx,%esi
8010243e:	72 1c                	jb     8010245c <kinit1+0x5c>
    kfree(p);
80102440:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102446:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102449:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010244f:	50                   	push   %eax
80102450:	e8 cb fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102455:	83 c4 10             	add    $0x10,%esp
80102458:	39 de                	cmp    %ebx,%esi
8010245a:	73 e4                	jae    80102440 <kinit1+0x40>
}
8010245c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010245f:	5b                   	pop    %ebx
80102460:	5e                   	pop    %esi
80102461:	5d                   	pop    %ebp
80102462:	c3                   	ret    
80102463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102470 <kinit2>:
{
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	56                   	push   %esi
80102474:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102475:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102478:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010247b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102481:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102487:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010248d:	39 de                	cmp    %ebx,%esi
8010248f:	72 23                	jb     801024b4 <kinit2+0x44>
80102491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102498:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010249e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024a7:	50                   	push   %eax
801024a8:	e8 73 fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024ad:	83 c4 10             	add    $0x10,%esp
801024b0:	39 de                	cmp    %ebx,%esi
801024b2:	73 e4                	jae    80102498 <kinit2+0x28>
  kmem.use_lock = 1;
801024b4:	c7 05 34 39 11 80 01 	movl   $0x1,0x80113934
801024bb:	00 00 00 
}
801024be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024c1:	5b                   	pop    %ebx
801024c2:	5e                   	pop    %esi
801024c3:	5d                   	pop    %ebp
801024c4:	c3                   	ret    
801024c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024d0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024d0:	a1 34 39 11 80       	mov    0x80113934,%eax
801024d5:	85 c0                	test   %eax,%eax
801024d7:	75 1f                	jne    801024f8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024d9:	a1 38 39 11 80       	mov    0x80113938,%eax
  if(r)
801024de:	85 c0                	test   %eax,%eax
801024e0:	74 0e                	je     801024f0 <kalloc+0x20>
    kmem.freelist = r->next;
801024e2:	8b 10                	mov    (%eax),%edx
801024e4:	89 15 38 39 11 80    	mov    %edx,0x80113938
801024ea:	c3                   	ret    
801024eb:	90                   	nop
801024ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801024f0:	f3 c3                	repz ret 
801024f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801024f8:	55                   	push   %ebp
801024f9:	89 e5                	mov    %esp,%ebp
801024fb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801024fe:	68 00 39 11 80       	push   $0x80113900
80102503:	e8 a8 25 00 00       	call   80104ab0 <acquire>
  r = kmem.freelist;
80102508:	a1 38 39 11 80       	mov    0x80113938,%eax
  if(r)
8010250d:	83 c4 10             	add    $0x10,%esp
80102510:	8b 15 34 39 11 80    	mov    0x80113934,%edx
80102516:	85 c0                	test   %eax,%eax
80102518:	74 08                	je     80102522 <kalloc+0x52>
    kmem.freelist = r->next;
8010251a:	8b 08                	mov    (%eax),%ecx
8010251c:	89 0d 38 39 11 80    	mov    %ecx,0x80113938
  if(kmem.use_lock)
80102522:	85 d2                	test   %edx,%edx
80102524:	74 16                	je     8010253c <kalloc+0x6c>
    release(&kmem.lock);
80102526:	83 ec 0c             	sub    $0xc,%esp
80102529:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010252c:	68 00 39 11 80       	push   $0x80113900
80102531:	e8 3a 26 00 00       	call   80104b70 <release>
  return (char*)r;
80102536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102539:	83 c4 10             	add    $0x10,%esp
}
8010253c:	c9                   	leave  
8010253d:	c3                   	ret    
8010253e:	66 90                	xchg   %ax,%ax

80102540 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102540:	ba 64 00 00 00       	mov    $0x64,%edx
80102545:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102546:	a8 01                	test   $0x1,%al
80102548:	0f 84 c2 00 00 00    	je     80102610 <kbdgetc+0xd0>
8010254e:	ba 60 00 00 00       	mov    $0x60,%edx
80102553:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102554:	0f b6 d0             	movzbl %al,%edx
80102557:	8b 0d 54 b8 10 80    	mov    0x8010b854,%ecx

  if(data == 0xE0){
8010255d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102563:	0f 84 7f 00 00 00    	je     801025e8 <kbdgetc+0xa8>
{
80102569:	55                   	push   %ebp
8010256a:	89 e5                	mov    %esp,%ebp
8010256c:	53                   	push   %ebx
8010256d:	89 cb                	mov    %ecx,%ebx
8010256f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102572:	84 c0                	test   %al,%al
80102574:	78 4a                	js     801025c0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102576:	85 db                	test   %ebx,%ebx
80102578:	74 09                	je     80102583 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010257a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010257d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102580:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102583:	0f b6 82 e0 7a 10 80 	movzbl -0x7fef8520(%edx),%eax
8010258a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010258c:	0f b6 82 e0 79 10 80 	movzbl -0x7fef8620(%edx),%eax
80102593:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102595:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102597:	89 0d 54 b8 10 80    	mov    %ecx,0x8010b854
  c = charcode[shift & (CTL | SHIFT)][data];
8010259d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025a0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025a3:	8b 04 85 c0 79 10 80 	mov    -0x7fef8640(,%eax,4),%eax
801025aa:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025ae:	74 31                	je     801025e1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025b0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025b3:	83 fa 19             	cmp    $0x19,%edx
801025b6:	77 40                	ja     801025f8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025b8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025bb:	5b                   	pop    %ebx
801025bc:	5d                   	pop    %ebp
801025bd:	c3                   	ret    
801025be:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025c0:	83 e0 7f             	and    $0x7f,%eax
801025c3:	85 db                	test   %ebx,%ebx
801025c5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025c8:	0f b6 82 e0 7a 10 80 	movzbl -0x7fef8520(%edx),%eax
801025cf:	83 c8 40             	or     $0x40,%eax
801025d2:	0f b6 c0             	movzbl %al,%eax
801025d5:	f7 d0                	not    %eax
801025d7:	21 c1                	and    %eax,%ecx
    return 0;
801025d9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025db:	89 0d 54 b8 10 80    	mov    %ecx,0x8010b854
}
801025e1:	5b                   	pop    %ebx
801025e2:	5d                   	pop    %ebp
801025e3:	c3                   	ret    
801025e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025e8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025eb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025ed:	89 0d 54 b8 10 80    	mov    %ecx,0x8010b854
    return 0;
801025f3:	c3                   	ret    
801025f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801025f8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025fb:	8d 50 20             	lea    0x20(%eax),%edx
}
801025fe:	5b                   	pop    %ebx
      c += 'a' - 'A';
801025ff:	83 f9 1a             	cmp    $0x1a,%ecx
80102602:	0f 42 c2             	cmovb  %edx,%eax
}
80102605:	5d                   	pop    %ebp
80102606:	c3                   	ret    
80102607:	89 f6                	mov    %esi,%esi
80102609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102610:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102615:	c3                   	ret    
80102616:	8d 76 00             	lea    0x0(%esi),%esi
80102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102620 <kbdintr>:

void
kbdintr(void)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102626:	68 40 25 10 80       	push   $0x80102540
8010262b:	e8 e0 e1 ff ff       	call   80100810 <consoleintr>
}
80102630:	83 c4 10             	add    $0x10,%esp
80102633:	c9                   	leave  
80102634:	c3                   	ret    
80102635:	66 90                	xchg   %ax,%ax
80102637:	66 90                	xchg   %ax,%ax
80102639:	66 90                	xchg   %ax,%ax
8010263b:	66 90                	xchg   %ax,%ax
8010263d:	66 90                	xchg   %ax,%ax
8010263f:	90                   	nop

80102640 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102640:	a1 3c 39 11 80       	mov    0x8011393c,%eax
{
80102645:	55                   	push   %ebp
80102646:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102648:	85 c0                	test   %eax,%eax
8010264a:	0f 84 c8 00 00 00    	je     80102718 <lapicinit+0xd8>
  lapic[index] = value;
80102650:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102657:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010265a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010265d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102664:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102667:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010266a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102671:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102674:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102677:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010267e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102681:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102684:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010268b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010268e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102691:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102698:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010269e:	8b 50 30             	mov    0x30(%eax),%edx
801026a1:	c1 ea 10             	shr    $0x10,%edx
801026a4:	80 fa 03             	cmp    $0x3,%dl
801026a7:	77 77                	ja     80102720 <lapicinit+0xe0>
  lapic[index] = value;
801026a9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026b0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026bd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026cd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026d7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026da:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026dd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ea:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026f1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026f4:	8b 50 20             	mov    0x20(%eax),%edx
801026f7:	89 f6                	mov    %esi,%esi
801026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102700:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102706:	80 e6 10             	and    $0x10,%dh
80102709:	75 f5                	jne    80102700 <lapicinit+0xc0>
  lapic[index] = value;
8010270b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102712:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102715:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102718:	5d                   	pop    %ebp
80102719:	c3                   	ret    
8010271a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102720:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102727:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010272a:	8b 50 20             	mov    0x20(%eax),%edx
8010272d:	e9 77 ff ff ff       	jmp    801026a9 <lapicinit+0x69>
80102732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102740 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102740:	8b 15 3c 39 11 80    	mov    0x8011393c,%edx
{
80102746:	55                   	push   %ebp
80102747:	31 c0                	xor    %eax,%eax
80102749:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010274b:	85 d2                	test   %edx,%edx
8010274d:	74 06                	je     80102755 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010274f:	8b 42 20             	mov    0x20(%edx),%eax
80102752:	c1 e8 18             	shr    $0x18,%eax
}
80102755:	5d                   	pop    %ebp
80102756:	c3                   	ret    
80102757:	89 f6                	mov    %esi,%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102760:	a1 3c 39 11 80       	mov    0x8011393c,%eax
{
80102765:	55                   	push   %ebp
80102766:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102768:	85 c0                	test   %eax,%eax
8010276a:	74 0d                	je     80102779 <lapiceoi+0x19>
  lapic[index] = value;
8010276c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102773:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102776:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102779:	5d                   	pop    %ebp
8010277a:	c3                   	ret    
8010277b:	90                   	nop
8010277c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102780 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
}
80102783:	5d                   	pop    %ebp
80102784:	c3                   	ret    
80102785:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102790 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102790:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102791:	b8 0f 00 00 00       	mov    $0xf,%eax
80102796:	ba 70 00 00 00       	mov    $0x70,%edx
8010279b:	89 e5                	mov    %esp,%ebp
8010279d:	53                   	push   %ebx
8010279e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027a4:	ee                   	out    %al,(%dx)
801027a5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027aa:	ba 71 00 00 00       	mov    $0x71,%edx
801027af:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027b0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027b2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027b5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027bb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027bd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027c0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027c3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027c5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027c8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027ce:	a1 3c 39 11 80       	mov    0x8011393c,%eax
801027d3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027dc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027e3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027e9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027f0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027f6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027fc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027ff:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102805:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102808:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010280e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102811:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102817:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010281a:	5b                   	pop    %ebx
8010281b:	5d                   	pop    %ebp
8010281c:	c3                   	ret    
8010281d:	8d 76 00             	lea    0x0(%esi),%esi

80102820 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102820:	55                   	push   %ebp
80102821:	b8 0b 00 00 00       	mov    $0xb,%eax
80102826:	ba 70 00 00 00       	mov    $0x70,%edx
8010282b:	89 e5                	mov    %esp,%ebp
8010282d:	57                   	push   %edi
8010282e:	56                   	push   %esi
8010282f:	53                   	push   %ebx
80102830:	83 ec 4c             	sub    $0x4c,%esp
80102833:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102834:	ba 71 00 00 00       	mov    $0x71,%edx
80102839:	ec                   	in     (%dx),%al
8010283a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010283d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102842:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102845:	8d 76 00             	lea    0x0(%esi),%esi
80102848:	31 c0                	xor    %eax,%eax
8010284a:	89 da                	mov    %ebx,%edx
8010284c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010284d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102852:	89 ca                	mov    %ecx,%edx
80102854:	ec                   	in     (%dx),%al
80102855:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102858:	89 da                	mov    %ebx,%edx
8010285a:	b8 02 00 00 00       	mov    $0x2,%eax
8010285f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102860:	89 ca                	mov    %ecx,%edx
80102862:	ec                   	in     (%dx),%al
80102863:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102866:	89 da                	mov    %ebx,%edx
80102868:	b8 04 00 00 00       	mov    $0x4,%eax
8010286d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286e:	89 ca                	mov    %ecx,%edx
80102870:	ec                   	in     (%dx),%al
80102871:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102874:	89 da                	mov    %ebx,%edx
80102876:	b8 07 00 00 00       	mov    $0x7,%eax
8010287b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287c:	89 ca                	mov    %ecx,%edx
8010287e:	ec                   	in     (%dx),%al
8010287f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102882:	89 da                	mov    %ebx,%edx
80102884:	b8 08 00 00 00       	mov    $0x8,%eax
80102889:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288a:	89 ca                	mov    %ecx,%edx
8010288c:	ec                   	in     (%dx),%al
8010288d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010288f:	89 da                	mov    %ebx,%edx
80102891:	b8 09 00 00 00       	mov    $0x9,%eax
80102896:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102897:	89 ca                	mov    %ecx,%edx
80102899:	ec                   	in     (%dx),%al
8010289a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010289c:	89 da                	mov    %ebx,%edx
8010289e:	b8 0a 00 00 00       	mov    $0xa,%eax
801028a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a4:	89 ca                	mov    %ecx,%edx
801028a6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028a7:	84 c0                	test   %al,%al
801028a9:	78 9d                	js     80102848 <cmostime+0x28>
  return inb(CMOS_RETURN);
801028ab:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801028af:	89 fa                	mov    %edi,%edx
801028b1:	0f b6 fa             	movzbl %dl,%edi
801028b4:	89 f2                	mov    %esi,%edx
801028b6:	0f b6 f2             	movzbl %dl,%esi
801028b9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028bc:	89 da                	mov    %ebx,%edx
801028be:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028c1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028c4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028c8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028cb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028cf:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028d2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028d9:	31 c0                	xor    %eax,%eax
801028db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028dc:	89 ca                	mov    %ecx,%edx
801028de:	ec                   	in     (%dx),%al
801028df:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e2:	89 da                	mov    %ebx,%edx
801028e4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028e7:	b8 02 00 00 00       	mov    $0x2,%eax
801028ec:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ed:	89 ca                	mov    %ecx,%edx
801028ef:	ec                   	in     (%dx),%al
801028f0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f3:	89 da                	mov    %ebx,%edx
801028f5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028f8:	b8 04 00 00 00       	mov    $0x4,%eax
801028fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fe:	89 ca                	mov    %ecx,%edx
80102900:	ec                   	in     (%dx),%al
80102901:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102904:	89 da                	mov    %ebx,%edx
80102906:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102909:	b8 07 00 00 00       	mov    $0x7,%eax
8010290e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290f:	89 ca                	mov    %ecx,%edx
80102911:	ec                   	in     (%dx),%al
80102912:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102915:	89 da                	mov    %ebx,%edx
80102917:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010291a:	b8 08 00 00 00       	mov    $0x8,%eax
8010291f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102920:	89 ca                	mov    %ecx,%edx
80102922:	ec                   	in     (%dx),%al
80102923:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102926:	89 da                	mov    %ebx,%edx
80102928:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010292b:	b8 09 00 00 00       	mov    $0x9,%eax
80102930:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102931:	89 ca                	mov    %ecx,%edx
80102933:	ec                   	in     (%dx),%al
80102934:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102937:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010293a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010293d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102940:	6a 18                	push   $0x18
80102942:	50                   	push   %eax
80102943:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102946:	50                   	push   %eax
80102947:	e8 c4 22 00 00       	call   80104c10 <memcmp>
8010294c:	83 c4 10             	add    $0x10,%esp
8010294f:	85 c0                	test   %eax,%eax
80102951:	0f 85 f1 fe ff ff    	jne    80102848 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102957:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010295b:	75 78                	jne    801029d5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010295d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102960:	89 c2                	mov    %eax,%edx
80102962:	83 e0 0f             	and    $0xf,%eax
80102965:	c1 ea 04             	shr    $0x4,%edx
80102968:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010296b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010296e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102971:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102974:	89 c2                	mov    %eax,%edx
80102976:	83 e0 0f             	and    $0xf,%eax
80102979:	c1 ea 04             	shr    $0x4,%edx
8010297c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010297f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102982:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102985:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102988:	89 c2                	mov    %eax,%edx
8010298a:	83 e0 0f             	and    $0xf,%eax
8010298d:	c1 ea 04             	shr    $0x4,%edx
80102990:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102993:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102996:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102999:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010299c:	89 c2                	mov    %eax,%edx
8010299e:	83 e0 0f             	and    $0xf,%eax
801029a1:	c1 ea 04             	shr    $0x4,%edx
801029a4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029aa:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029b0:	89 c2                	mov    %eax,%edx
801029b2:	83 e0 0f             	and    $0xf,%eax
801029b5:	c1 ea 04             	shr    $0x4,%edx
801029b8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029bb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029be:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029c1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029c4:	89 c2                	mov    %eax,%edx
801029c6:	83 e0 0f             	and    $0xf,%eax
801029c9:	c1 ea 04             	shr    $0x4,%edx
801029cc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029cf:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029d2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029d5:	8b 75 08             	mov    0x8(%ebp),%esi
801029d8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029db:	89 06                	mov    %eax,(%esi)
801029dd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029e0:	89 46 04             	mov    %eax,0x4(%esi)
801029e3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029e6:	89 46 08             	mov    %eax,0x8(%esi)
801029e9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ec:	89 46 0c             	mov    %eax,0xc(%esi)
801029ef:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029f2:	89 46 10             	mov    %eax,0x10(%esi)
801029f5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029f8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029fb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a05:	5b                   	pop    %ebx
80102a06:	5e                   	pop    %esi
80102a07:	5f                   	pop    %edi
80102a08:	5d                   	pop    %ebp
80102a09:	c3                   	ret    
80102a0a:	66 90                	xchg   %ax,%ax
80102a0c:	66 90                	xchg   %ax,%ax
80102a0e:	66 90                	xchg   %ax,%ax

80102a10 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a10:	8b 0d 88 39 11 80    	mov    0x80113988,%ecx
80102a16:	85 c9                	test   %ecx,%ecx
80102a18:	0f 8e 8a 00 00 00    	jle    80102aa8 <install_trans+0x98>
{
80102a1e:	55                   	push   %ebp
80102a1f:	89 e5                	mov    %esp,%ebp
80102a21:	57                   	push   %edi
80102a22:	56                   	push   %esi
80102a23:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a24:	31 db                	xor    %ebx,%ebx
{
80102a26:	83 ec 0c             	sub    $0xc,%esp
80102a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a30:	a1 74 39 11 80       	mov    0x80113974,%eax
80102a35:	83 ec 08             	sub    $0x8,%esp
80102a38:	01 d8                	add    %ebx,%eax
80102a3a:	83 c0 01             	add    $0x1,%eax
80102a3d:	50                   	push   %eax
80102a3e:	ff 35 84 39 11 80    	pushl  0x80113984
80102a44:	e8 87 d6 ff ff       	call   801000d0 <bread>
80102a49:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a4b:	58                   	pop    %eax
80102a4c:	5a                   	pop    %edx
80102a4d:	ff 34 9d 8c 39 11 80 	pushl  -0x7feec674(,%ebx,4)
80102a54:	ff 35 84 39 11 80    	pushl  0x80113984
  for (tail = 0; tail < log.lh.n; tail++) {
80102a5a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a5d:	e8 6e d6 ff ff       	call   801000d0 <bread>
80102a62:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a64:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a67:	83 c4 0c             	add    $0xc,%esp
80102a6a:	68 00 02 00 00       	push   $0x200
80102a6f:	50                   	push   %eax
80102a70:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a73:	50                   	push   %eax
80102a74:	e8 f7 21 00 00       	call   80104c70 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a79:	89 34 24             	mov    %esi,(%esp)
80102a7c:	e8 1f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a81:	89 3c 24             	mov    %edi,(%esp)
80102a84:	e8 57 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a89:	89 34 24             	mov    %esi,(%esp)
80102a8c:	e8 4f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102a91:	83 c4 10             	add    $0x10,%esp
80102a94:	39 1d 88 39 11 80    	cmp    %ebx,0x80113988
80102a9a:	7f 94                	jg     80102a30 <install_trans+0x20>
  }
}
80102a9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a9f:	5b                   	pop    %ebx
80102aa0:	5e                   	pop    %esi
80102aa1:	5f                   	pop    %edi
80102aa2:	5d                   	pop    %ebp
80102aa3:	c3                   	ret    
80102aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102aa8:	f3 c3                	repz ret 
80102aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ab0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ab0:	55                   	push   %ebp
80102ab1:	89 e5                	mov    %esp,%ebp
80102ab3:	56                   	push   %esi
80102ab4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102ab5:	83 ec 08             	sub    $0x8,%esp
80102ab8:	ff 35 74 39 11 80    	pushl  0x80113974
80102abe:	ff 35 84 39 11 80    	pushl  0x80113984
80102ac4:	e8 07 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ac9:	8b 1d 88 39 11 80    	mov    0x80113988,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102acf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ad2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ad4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ad6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ad9:	7e 16                	jle    80102af1 <write_head+0x41>
80102adb:	c1 e3 02             	shl    $0x2,%ebx
80102ade:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102ae0:	8b 8a 8c 39 11 80    	mov    -0x7feec674(%edx),%ecx
80102ae6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102aea:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102aed:	39 da                	cmp    %ebx,%edx
80102aef:	75 ef                	jne    80102ae0 <write_head+0x30>
  }
  bwrite(buf);
80102af1:	83 ec 0c             	sub    $0xc,%esp
80102af4:	56                   	push   %esi
80102af5:	e8 a6 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102afa:	89 34 24             	mov    %esi,(%esp)
80102afd:	e8 de d6 ff ff       	call   801001e0 <brelse>
}
80102b02:	83 c4 10             	add    $0x10,%esp
80102b05:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b08:	5b                   	pop    %ebx
80102b09:	5e                   	pop    %esi
80102b0a:	5d                   	pop    %ebp
80102b0b:	c3                   	ret    
80102b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b10 <initlog>:
{
80102b10:	55                   	push   %ebp
80102b11:	89 e5                	mov    %esp,%ebp
80102b13:	53                   	push   %ebx
80102b14:	83 ec 2c             	sub    $0x2c,%esp
80102b17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b1a:	68 e0 7b 10 80       	push   $0x80107be0
80102b1f:	68 40 39 11 80       	push   $0x80113940
80102b24:	e8 47 1e 00 00       	call   80104970 <initlock>
  readsb(dev, &sb);
80102b29:	58                   	pop    %eax
80102b2a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b2d:	5a                   	pop    %edx
80102b2e:	50                   	push   %eax
80102b2f:	53                   	push   %ebx
80102b30:	e8 9b e8 ff ff       	call   801013d0 <readsb>
  log.size = sb.nlog;
80102b35:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b38:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b3b:	59                   	pop    %ecx
  log.dev = dev;
80102b3c:	89 1d 84 39 11 80    	mov    %ebx,0x80113984
  log.size = sb.nlog;
80102b42:	89 15 78 39 11 80    	mov    %edx,0x80113978
  log.start = sb.logstart;
80102b48:	a3 74 39 11 80       	mov    %eax,0x80113974
  struct buf *buf = bread(log.dev, log.start);
80102b4d:	5a                   	pop    %edx
80102b4e:	50                   	push   %eax
80102b4f:	53                   	push   %ebx
80102b50:	e8 7b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b55:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b58:	83 c4 10             	add    $0x10,%esp
80102b5b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b5d:	89 1d 88 39 11 80    	mov    %ebx,0x80113988
  for (i = 0; i < log.lh.n; i++) {
80102b63:	7e 1c                	jle    80102b81 <initlog+0x71>
80102b65:	c1 e3 02             	shl    $0x2,%ebx
80102b68:	31 d2                	xor    %edx,%edx
80102b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b70:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b74:	83 c2 04             	add    $0x4,%edx
80102b77:	89 8a 88 39 11 80    	mov    %ecx,-0x7feec678(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b7d:	39 d3                	cmp    %edx,%ebx
80102b7f:	75 ef                	jne    80102b70 <initlog+0x60>
  brelse(buf);
80102b81:	83 ec 0c             	sub    $0xc,%esp
80102b84:	50                   	push   %eax
80102b85:	e8 56 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b8a:	e8 81 fe ff ff       	call   80102a10 <install_trans>
  log.lh.n = 0;
80102b8f:	c7 05 88 39 11 80 00 	movl   $0x0,0x80113988
80102b96:	00 00 00 
  write_head(); // clear the log
80102b99:	e8 12 ff ff ff       	call   80102ab0 <write_head>
}
80102b9e:	83 c4 10             	add    $0x10,%esp
80102ba1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ba4:	c9                   	leave  
80102ba5:	c3                   	ret    
80102ba6:	8d 76 00             	lea    0x0(%esi),%esi
80102ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bb0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102bb6:	68 40 39 11 80       	push   $0x80113940
80102bbb:	e8 f0 1e 00 00       	call   80104ab0 <acquire>
80102bc0:	83 c4 10             	add    $0x10,%esp
80102bc3:	eb 18                	jmp    80102bdd <begin_op+0x2d>
80102bc5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bc8:	83 ec 08             	sub    $0x8,%esp
80102bcb:	68 40 39 11 80       	push   $0x80113940
80102bd0:	68 40 39 11 80       	push   $0x80113940
80102bd5:	e8 46 17 00 00       	call   80104320 <sleep>
80102bda:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bdd:	a1 80 39 11 80       	mov    0x80113980,%eax
80102be2:	85 c0                	test   %eax,%eax
80102be4:	75 e2                	jne    80102bc8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102be6:	a1 7c 39 11 80       	mov    0x8011397c,%eax
80102beb:	8b 15 88 39 11 80    	mov    0x80113988,%edx
80102bf1:	83 c0 01             	add    $0x1,%eax
80102bf4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102bf7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bfa:	83 fa 1e             	cmp    $0x1e,%edx
80102bfd:	7f c9                	jg     80102bc8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bff:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c02:	a3 7c 39 11 80       	mov    %eax,0x8011397c
      release(&log.lock);
80102c07:	68 40 39 11 80       	push   $0x80113940
80102c0c:	e8 5f 1f 00 00       	call   80104b70 <release>
      break;
    }
  }
}
80102c11:	83 c4 10             	add    $0x10,%esp
80102c14:	c9                   	leave  
80102c15:	c3                   	ret    
80102c16:	8d 76 00             	lea    0x0(%esi),%esi
80102c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c20 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c20:	55                   	push   %ebp
80102c21:	89 e5                	mov    %esp,%ebp
80102c23:	57                   	push   %edi
80102c24:	56                   	push   %esi
80102c25:	53                   	push   %ebx
80102c26:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c29:	68 40 39 11 80       	push   $0x80113940
80102c2e:	e8 7d 1e 00 00       	call   80104ab0 <acquire>
  log.outstanding -= 1;
80102c33:	a1 7c 39 11 80       	mov    0x8011397c,%eax
  if(log.committing)
80102c38:	8b 35 80 39 11 80    	mov    0x80113980,%esi
80102c3e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c41:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c44:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c46:	89 1d 7c 39 11 80    	mov    %ebx,0x8011397c
  if(log.committing)
80102c4c:	0f 85 1a 01 00 00    	jne    80102d6c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c52:	85 db                	test   %ebx,%ebx
80102c54:	0f 85 ee 00 00 00    	jne    80102d48 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c5a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c5d:	c7 05 80 39 11 80 01 	movl   $0x1,0x80113980
80102c64:	00 00 00 
  release(&log.lock);
80102c67:	68 40 39 11 80       	push   $0x80113940
80102c6c:	e8 ff 1e 00 00       	call   80104b70 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c71:	8b 0d 88 39 11 80    	mov    0x80113988,%ecx
80102c77:	83 c4 10             	add    $0x10,%esp
80102c7a:	85 c9                	test   %ecx,%ecx
80102c7c:	0f 8e 85 00 00 00    	jle    80102d07 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c82:	a1 74 39 11 80       	mov    0x80113974,%eax
80102c87:	83 ec 08             	sub    $0x8,%esp
80102c8a:	01 d8                	add    %ebx,%eax
80102c8c:	83 c0 01             	add    $0x1,%eax
80102c8f:	50                   	push   %eax
80102c90:	ff 35 84 39 11 80    	pushl  0x80113984
80102c96:	e8 35 d4 ff ff       	call   801000d0 <bread>
80102c9b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c9d:	58                   	pop    %eax
80102c9e:	5a                   	pop    %edx
80102c9f:	ff 34 9d 8c 39 11 80 	pushl  -0x7feec674(,%ebx,4)
80102ca6:	ff 35 84 39 11 80    	pushl  0x80113984
  for (tail = 0; tail < log.lh.n; tail++) {
80102cac:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102caf:	e8 1c d4 ff ff       	call   801000d0 <bread>
80102cb4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cb6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cb9:	83 c4 0c             	add    $0xc,%esp
80102cbc:	68 00 02 00 00       	push   $0x200
80102cc1:	50                   	push   %eax
80102cc2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cc5:	50                   	push   %eax
80102cc6:	e8 a5 1f 00 00       	call   80104c70 <memmove>
    bwrite(to);  // write the log
80102ccb:	89 34 24             	mov    %esi,(%esp)
80102cce:	e8 cd d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102cd3:	89 3c 24             	mov    %edi,(%esp)
80102cd6:	e8 05 d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102cdb:	89 34 24             	mov    %esi,(%esp)
80102cde:	e8 fd d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ce3:	83 c4 10             	add    $0x10,%esp
80102ce6:	3b 1d 88 39 11 80    	cmp    0x80113988,%ebx
80102cec:	7c 94                	jl     80102c82 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cee:	e8 bd fd ff ff       	call   80102ab0 <write_head>
    install_trans(); // Now install writes to home locations
80102cf3:	e8 18 fd ff ff       	call   80102a10 <install_trans>
    log.lh.n = 0;
80102cf8:	c7 05 88 39 11 80 00 	movl   $0x0,0x80113988
80102cff:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d02:	e8 a9 fd ff ff       	call   80102ab0 <write_head>
    acquire(&log.lock);
80102d07:	83 ec 0c             	sub    $0xc,%esp
80102d0a:	68 40 39 11 80       	push   $0x80113940
80102d0f:	e8 9c 1d 00 00       	call   80104ab0 <acquire>
    wakeup(&log);
80102d14:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
    log.committing = 0;
80102d1b:	c7 05 80 39 11 80 00 	movl   $0x0,0x80113980
80102d22:	00 00 00 
    wakeup(&log);
80102d25:	e8 b6 17 00 00       	call   801044e0 <wakeup>
    release(&log.lock);
80102d2a:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80102d31:	e8 3a 1e 00 00       	call   80104b70 <release>
80102d36:	83 c4 10             	add    $0x10,%esp
}
80102d39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d3c:	5b                   	pop    %ebx
80102d3d:	5e                   	pop    %esi
80102d3e:	5f                   	pop    %edi
80102d3f:	5d                   	pop    %ebp
80102d40:	c3                   	ret    
80102d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d48:	83 ec 0c             	sub    $0xc,%esp
80102d4b:	68 40 39 11 80       	push   $0x80113940
80102d50:	e8 8b 17 00 00       	call   801044e0 <wakeup>
  release(&log.lock);
80102d55:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80102d5c:	e8 0f 1e 00 00       	call   80104b70 <release>
80102d61:	83 c4 10             	add    $0x10,%esp
}
80102d64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d67:	5b                   	pop    %ebx
80102d68:	5e                   	pop    %esi
80102d69:	5f                   	pop    %edi
80102d6a:	5d                   	pop    %ebp
80102d6b:	c3                   	ret    
    panic("log.committing");
80102d6c:	83 ec 0c             	sub    $0xc,%esp
80102d6f:	68 e4 7b 10 80       	push   $0x80107be4
80102d74:	e8 17 d6 ff ff       	call   80100390 <panic>
80102d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d80 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	53                   	push   %ebx
80102d84:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d87:	8b 15 88 39 11 80    	mov    0x80113988,%edx
{
80102d8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d90:	83 fa 1d             	cmp    $0x1d,%edx
80102d93:	0f 8f 9d 00 00 00    	jg     80102e36 <log_write+0xb6>
80102d99:	a1 78 39 11 80       	mov    0x80113978,%eax
80102d9e:	83 e8 01             	sub    $0x1,%eax
80102da1:	39 c2                	cmp    %eax,%edx
80102da3:	0f 8d 8d 00 00 00    	jge    80102e36 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102da9:	a1 7c 39 11 80       	mov    0x8011397c,%eax
80102dae:	85 c0                	test   %eax,%eax
80102db0:	0f 8e 8d 00 00 00    	jle    80102e43 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102db6:	83 ec 0c             	sub    $0xc,%esp
80102db9:	68 40 39 11 80       	push   $0x80113940
80102dbe:	e8 ed 1c 00 00       	call   80104ab0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102dc3:	8b 0d 88 39 11 80    	mov    0x80113988,%ecx
80102dc9:	83 c4 10             	add    $0x10,%esp
80102dcc:	83 f9 00             	cmp    $0x0,%ecx
80102dcf:	7e 57                	jle    80102e28 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dd1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102dd4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dd6:	3b 15 8c 39 11 80    	cmp    0x8011398c,%edx
80102ddc:	75 0b                	jne    80102de9 <log_write+0x69>
80102dde:	eb 38                	jmp    80102e18 <log_write+0x98>
80102de0:	39 14 85 8c 39 11 80 	cmp    %edx,-0x7feec674(,%eax,4)
80102de7:	74 2f                	je     80102e18 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102de9:	83 c0 01             	add    $0x1,%eax
80102dec:	39 c1                	cmp    %eax,%ecx
80102dee:	75 f0                	jne    80102de0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102df0:	89 14 85 8c 39 11 80 	mov    %edx,-0x7feec674(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102df7:	83 c0 01             	add    $0x1,%eax
80102dfa:	a3 88 39 11 80       	mov    %eax,0x80113988
  b->flags |= B_DIRTY; // prevent eviction
80102dff:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e02:	c7 45 08 40 39 11 80 	movl   $0x80113940,0x8(%ebp)
}
80102e09:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e0c:	c9                   	leave  
  release(&log.lock);
80102e0d:	e9 5e 1d 00 00       	jmp    80104b70 <release>
80102e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e18:	89 14 85 8c 39 11 80 	mov    %edx,-0x7feec674(,%eax,4)
80102e1f:	eb de                	jmp    80102dff <log_write+0x7f>
80102e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e28:	8b 43 08             	mov    0x8(%ebx),%eax
80102e2b:	a3 8c 39 11 80       	mov    %eax,0x8011398c
  if (i == log.lh.n)
80102e30:	75 cd                	jne    80102dff <log_write+0x7f>
80102e32:	31 c0                	xor    %eax,%eax
80102e34:	eb c1                	jmp    80102df7 <log_write+0x77>
    panic("too big a transaction");
80102e36:	83 ec 0c             	sub    $0xc,%esp
80102e39:	68 f3 7b 10 80       	push   $0x80107bf3
80102e3e:	e8 4d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e43:	83 ec 0c             	sub    $0xc,%esp
80102e46:	68 09 7c 10 80       	push   $0x80107c09
80102e4b:	e8 40 d5 ff ff       	call   80100390 <panic>

80102e50 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	53                   	push   %ebx
80102e54:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e57:	e8 e4 0c 00 00       	call   80103b40 <cpuid>
80102e5c:	89 c3                	mov    %eax,%ebx
80102e5e:	e8 dd 0c 00 00       	call   80103b40 <cpuid>
80102e63:	83 ec 04             	sub    $0x4,%esp
80102e66:	53                   	push   %ebx
80102e67:	50                   	push   %eax
80102e68:	68 24 7c 10 80       	push   $0x80107c24
80102e6d:	e8 ee d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e72:	e8 e9 30 00 00       	call   80105f60 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e77:	e8 44 0c 00 00       	call   80103ac0 <mycpu>
80102e7c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e7e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e83:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e8a:	e8 91 0f 00 00       	call   80103e20 <scheduler>
80102e8f:	90                   	nop

80102e90 <mpenter>:
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e96:	e8 b5 41 00 00       	call   80107050 <switchkvm>
  seginit();
80102e9b:	e8 20 41 00 00       	call   80106fc0 <seginit>
  lapicinit();
80102ea0:	e8 9b f7 ff ff       	call   80102640 <lapicinit>
  mpmain();
80102ea5:	e8 a6 ff ff ff       	call   80102e50 <mpmain>
80102eaa:	66 90                	xchg   %ax,%ax
80102eac:	66 90                	xchg   %ax,%ax
80102eae:	66 90                	xchg   %ax,%ax

80102eb0 <main>:
{
80102eb0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102eb4:	83 e4 f0             	and    $0xfffffff0,%esp
80102eb7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eba:	55                   	push   %ebp
80102ebb:	89 e5                	mov    %esp,%ebp
80102ebd:	53                   	push   %ebx
80102ebe:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ebf:	83 ec 08             	sub    $0x8,%esp
80102ec2:	68 00 00 40 80       	push   $0x80400000
80102ec7:	68 08 3a 13 80       	push   $0x80133a08
80102ecc:	e8 2f f5 ff ff       	call   80102400 <kinit1>
  kvmalloc();      // kernel page table
80102ed1:	e8 4a 46 00 00       	call   80107520 <kvmalloc>
  mpinit();        // detect other processors
80102ed6:	e8 75 01 00 00       	call   80103050 <mpinit>
  lapicinit();     // interrupt controller
80102edb:	e8 60 f7 ff ff       	call   80102640 <lapicinit>
  seginit();       // segment descriptors
80102ee0:	e8 db 40 00 00       	call   80106fc0 <seginit>
  picinit();       // disable pic
80102ee5:	e8 46 03 00 00       	call   80103230 <picinit>
  ioapicinit();    // another interrupt controller
80102eea:	e8 41 f3 ff ff       	call   80102230 <ioapicinit>
  consoleinit();   // console hardware
80102eef:	e8 cc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102ef4:	e8 97 33 00 00       	call   80106290 <uartinit>
  pinit();         // process table
80102ef9:	e8 72 0b 00 00       	call   80103a70 <pinit>
  tvinit();        // trap vectors
80102efe:	e8 dd 2f 00 00       	call   80105ee0 <tvinit>
  binit();         // buffer cache
80102f03:	e8 38 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f08:	e8 53 de ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102f0d:	e8 fe f0 ff ff       	call   80102010 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f12:	83 c4 0c             	add    $0xc,%esp
80102f15:	68 8a 00 00 00       	push   $0x8a
80102f1a:	68 2c b7 10 80       	push   $0x8010b72c
80102f1f:	68 00 70 00 80       	push   $0x80007000
80102f24:	e8 47 1d 00 00       	call   80104c70 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f29:	69 05 c0 3f 11 80 b0 	imul   $0xb0,0x80113fc0,%eax
80102f30:	00 00 00 
80102f33:	83 c4 10             	add    $0x10,%esp
80102f36:	05 40 3a 11 80       	add    $0x80113a40,%eax
80102f3b:	3d 40 3a 11 80       	cmp    $0x80113a40,%eax
80102f40:	76 71                	jbe    80102fb3 <main+0x103>
80102f42:	bb 40 3a 11 80       	mov    $0x80113a40,%ebx
80102f47:	89 f6                	mov    %esi,%esi
80102f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f50:	e8 6b 0b 00 00       	call   80103ac0 <mycpu>
80102f55:	39 d8                	cmp    %ebx,%eax
80102f57:	74 41                	je     80102f9a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f59:	e8 72 f5 ff ff       	call   801024d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f5e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f63:	c7 05 f8 6f 00 80 90 	movl   $0x80102e90,0x80006ff8
80102f6a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f6d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80102f74:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f77:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f7c:	0f b6 03             	movzbl (%ebx),%eax
80102f7f:	83 ec 08             	sub    $0x8,%esp
80102f82:	68 00 70 00 00       	push   $0x7000
80102f87:	50                   	push   %eax
80102f88:	e8 03 f8 ff ff       	call   80102790 <lapicstartap>
80102f8d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f90:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f96:	85 c0                	test   %eax,%eax
80102f98:	74 f6                	je     80102f90 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102f9a:	69 05 c0 3f 11 80 b0 	imul   $0xb0,0x80113fc0,%eax
80102fa1:	00 00 00 
80102fa4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102faa:	05 40 3a 11 80       	add    $0x80113a40,%eax
80102faf:	39 c3                	cmp    %eax,%ebx
80102fb1:	72 9d                	jb     80102f50 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fb3:	83 ec 08             	sub    $0x8,%esp
80102fb6:	68 00 00 00 8e       	push   $0x8e000000
80102fbb:	68 00 00 40 80       	push   $0x80400000
80102fc0:	e8 ab f4 ff ff       	call   80102470 <kinit2>
  userinit();      // first user process
80102fc5:	e8 c6 0b 00 00       	call   80103b90 <userinit>
  mpmain();        // finish this processor's setup
80102fca:	e8 81 fe ff ff       	call   80102e50 <mpmain>
80102fcf:	90                   	nop

80102fd0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	57                   	push   %edi
80102fd4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fd5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102fdb:	53                   	push   %ebx
  e = addr+len;
80102fdc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fdf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102fe2:	39 de                	cmp    %ebx,%esi
80102fe4:	72 10                	jb     80102ff6 <mpsearch1+0x26>
80102fe6:	eb 50                	jmp    80103038 <mpsearch1+0x68>
80102fe8:	90                   	nop
80102fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ff0:	39 fb                	cmp    %edi,%ebx
80102ff2:	89 fe                	mov    %edi,%esi
80102ff4:	76 42                	jbe    80103038 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102ff6:	83 ec 04             	sub    $0x4,%esp
80102ff9:	8d 7e 10             	lea    0x10(%esi),%edi
80102ffc:	6a 04                	push   $0x4
80102ffe:	68 38 7c 10 80       	push   $0x80107c38
80103003:	56                   	push   %esi
80103004:	e8 07 1c 00 00       	call   80104c10 <memcmp>
80103009:	83 c4 10             	add    $0x10,%esp
8010300c:	85 c0                	test   %eax,%eax
8010300e:	75 e0                	jne    80102ff0 <mpsearch1+0x20>
80103010:	89 f1                	mov    %esi,%ecx
80103012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103018:	0f b6 11             	movzbl (%ecx),%edx
8010301b:	83 c1 01             	add    $0x1,%ecx
8010301e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103020:	39 f9                	cmp    %edi,%ecx
80103022:	75 f4                	jne    80103018 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103024:	84 c0                	test   %al,%al
80103026:	75 c8                	jne    80102ff0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103028:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010302b:	89 f0                	mov    %esi,%eax
8010302d:	5b                   	pop    %ebx
8010302e:	5e                   	pop    %esi
8010302f:	5f                   	pop    %edi
80103030:	5d                   	pop    %ebp
80103031:	c3                   	ret    
80103032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103038:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010303b:	31 f6                	xor    %esi,%esi
}
8010303d:	89 f0                	mov    %esi,%eax
8010303f:	5b                   	pop    %ebx
80103040:	5e                   	pop    %esi
80103041:	5f                   	pop    %edi
80103042:	5d                   	pop    %ebp
80103043:	c3                   	ret    
80103044:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010304a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103050 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	57                   	push   %edi
80103054:	56                   	push   %esi
80103055:	53                   	push   %ebx
80103056:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103059:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103060:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103067:	c1 e0 08             	shl    $0x8,%eax
8010306a:	09 d0                	or     %edx,%eax
8010306c:	c1 e0 04             	shl    $0x4,%eax
8010306f:	85 c0                	test   %eax,%eax
80103071:	75 1b                	jne    8010308e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103073:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010307a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103081:	c1 e0 08             	shl    $0x8,%eax
80103084:	09 d0                	or     %edx,%eax
80103086:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103089:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010308e:	ba 00 04 00 00       	mov    $0x400,%edx
80103093:	e8 38 ff ff ff       	call   80102fd0 <mpsearch1>
80103098:	85 c0                	test   %eax,%eax
8010309a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010309d:	0f 84 3d 01 00 00    	je     801031e0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030a6:	8b 58 04             	mov    0x4(%eax),%ebx
801030a9:	85 db                	test   %ebx,%ebx
801030ab:	0f 84 4f 01 00 00    	je     80103200 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030b1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030b7:	83 ec 04             	sub    $0x4,%esp
801030ba:	6a 04                	push   $0x4
801030bc:	68 55 7c 10 80       	push   $0x80107c55
801030c1:	56                   	push   %esi
801030c2:	e8 49 1b 00 00       	call   80104c10 <memcmp>
801030c7:	83 c4 10             	add    $0x10,%esp
801030ca:	85 c0                	test   %eax,%eax
801030cc:	0f 85 2e 01 00 00    	jne    80103200 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801030d2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030d9:	3c 01                	cmp    $0x1,%al
801030db:	0f 95 c2             	setne  %dl
801030de:	3c 04                	cmp    $0x4,%al
801030e0:	0f 95 c0             	setne  %al
801030e3:	20 c2                	and    %al,%dl
801030e5:	0f 85 15 01 00 00    	jne    80103200 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801030eb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801030f2:	66 85 ff             	test   %di,%di
801030f5:	74 1a                	je     80103111 <mpinit+0xc1>
801030f7:	89 f0                	mov    %esi,%eax
801030f9:	01 f7                	add    %esi,%edi
  sum = 0;
801030fb:	31 d2                	xor    %edx,%edx
801030fd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103100:	0f b6 08             	movzbl (%eax),%ecx
80103103:	83 c0 01             	add    $0x1,%eax
80103106:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103108:	39 c7                	cmp    %eax,%edi
8010310a:	75 f4                	jne    80103100 <mpinit+0xb0>
8010310c:	84 d2                	test   %dl,%dl
8010310e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103111:	85 f6                	test   %esi,%esi
80103113:	0f 84 e7 00 00 00    	je     80103200 <mpinit+0x1b0>
80103119:	84 d2                	test   %dl,%dl
8010311b:	0f 85 df 00 00 00    	jne    80103200 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103121:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103127:	a3 3c 39 11 80       	mov    %eax,0x8011393c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010312c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103133:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103139:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010313e:	01 d6                	add    %edx,%esi
80103140:	39 c6                	cmp    %eax,%esi
80103142:	76 23                	jbe    80103167 <mpinit+0x117>
    switch(*p){
80103144:	0f b6 10             	movzbl (%eax),%edx
80103147:	80 fa 04             	cmp    $0x4,%dl
8010314a:	0f 87 ca 00 00 00    	ja     8010321a <mpinit+0x1ca>
80103150:	ff 24 95 7c 7c 10 80 	jmp    *-0x7fef8384(,%edx,4)
80103157:	89 f6                	mov    %esi,%esi
80103159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103160:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103163:	39 c6                	cmp    %eax,%esi
80103165:	77 dd                	ja     80103144 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103167:	85 db                	test   %ebx,%ebx
80103169:	0f 84 9e 00 00 00    	je     8010320d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010316f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103172:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103176:	74 15                	je     8010318d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103178:	b8 70 00 00 00       	mov    $0x70,%eax
8010317d:	ba 22 00 00 00       	mov    $0x22,%edx
80103182:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103183:	ba 23 00 00 00       	mov    $0x23,%edx
80103188:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103189:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010318c:	ee                   	out    %al,(%dx)
  }
}
8010318d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103190:	5b                   	pop    %ebx
80103191:	5e                   	pop    %esi
80103192:	5f                   	pop    %edi
80103193:	5d                   	pop    %ebp
80103194:	c3                   	ret    
80103195:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103198:	8b 0d c0 3f 11 80    	mov    0x80113fc0,%ecx
8010319e:	83 f9 07             	cmp    $0x7,%ecx
801031a1:	7f 19                	jg     801031bc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031a3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031a7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031ad:	83 c1 01             	add    $0x1,%ecx
801031b0:	89 0d c0 3f 11 80    	mov    %ecx,0x80113fc0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031b6:	88 97 40 3a 11 80    	mov    %dl,-0x7feec5c0(%edi)
      p += sizeof(struct mpproc);
801031bc:	83 c0 14             	add    $0x14,%eax
      continue;
801031bf:	e9 7c ff ff ff       	jmp    80103140 <mpinit+0xf0>
801031c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801031c8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031cc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031cf:	88 15 20 3a 11 80    	mov    %dl,0x80113a20
      continue;
801031d5:	e9 66 ff ff ff       	jmp    80103140 <mpinit+0xf0>
801031da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801031e0:	ba 00 00 01 00       	mov    $0x10000,%edx
801031e5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031ea:	e8 e1 fd ff ff       	call   80102fd0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031ef:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801031f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031f4:	0f 85 a9 fe ff ff    	jne    801030a3 <mpinit+0x53>
801031fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103200:	83 ec 0c             	sub    $0xc,%esp
80103203:	68 3d 7c 10 80       	push   $0x80107c3d
80103208:	e8 83 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010320d:	83 ec 0c             	sub    $0xc,%esp
80103210:	68 5c 7c 10 80       	push   $0x80107c5c
80103215:	e8 76 d1 ff ff       	call   80100390 <panic>
      ismp = 0;
8010321a:	31 db                	xor    %ebx,%ebx
8010321c:	e9 26 ff ff ff       	jmp    80103147 <mpinit+0xf7>
80103221:	66 90                	xchg   %ax,%ax
80103223:	66 90                	xchg   %ax,%ax
80103225:	66 90                	xchg   %ax,%ax
80103227:	66 90                	xchg   %ax,%ax
80103229:	66 90                	xchg   %ax,%ax
8010322b:	66 90                	xchg   %ax,%ax
8010322d:	66 90                	xchg   %ax,%ax
8010322f:	90                   	nop

80103230 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103230:	55                   	push   %ebp
80103231:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103236:	ba 21 00 00 00       	mov    $0x21,%edx
8010323b:	89 e5                	mov    %esp,%ebp
8010323d:	ee                   	out    %al,(%dx)
8010323e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103243:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103244:	5d                   	pop    %ebp
80103245:	c3                   	ret    
80103246:	66 90                	xchg   %ax,%ax
80103248:	66 90                	xchg   %ax,%ax
8010324a:	66 90                	xchg   %ax,%ax
8010324c:	66 90                	xchg   %ax,%ax
8010324e:	66 90                	xchg   %ax,%ax

80103250 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	57                   	push   %edi
80103254:	56                   	push   %esi
80103255:	53                   	push   %ebx
80103256:	83 ec 0c             	sub    $0xc,%esp
80103259:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010325c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010325f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103265:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010326b:	e8 10 db ff ff       	call   80100d80 <filealloc>
80103270:	85 c0                	test   %eax,%eax
80103272:	89 03                	mov    %eax,(%ebx)
80103274:	74 22                	je     80103298 <pipealloc+0x48>
80103276:	e8 05 db ff ff       	call   80100d80 <filealloc>
8010327b:	85 c0                	test   %eax,%eax
8010327d:	89 06                	mov    %eax,(%esi)
8010327f:	74 3f                	je     801032c0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103281:	e8 4a f2 ff ff       	call   801024d0 <kalloc>
80103286:	85 c0                	test   %eax,%eax
80103288:	89 c7                	mov    %eax,%edi
8010328a:	75 54                	jne    801032e0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010328c:	8b 03                	mov    (%ebx),%eax
8010328e:	85 c0                	test   %eax,%eax
80103290:	75 34                	jne    801032c6 <pipealloc+0x76>
80103292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103298:	8b 06                	mov    (%esi),%eax
8010329a:	85 c0                	test   %eax,%eax
8010329c:	74 0c                	je     801032aa <pipealloc+0x5a>
    fileclose(*f1);
8010329e:	83 ec 0c             	sub    $0xc,%esp
801032a1:	50                   	push   %eax
801032a2:	e8 99 db ff ff       	call   80100e40 <fileclose>
801032a7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801032ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032b2:	5b                   	pop    %ebx
801032b3:	5e                   	pop    %esi
801032b4:	5f                   	pop    %edi
801032b5:	5d                   	pop    %ebp
801032b6:	c3                   	ret    
801032b7:	89 f6                	mov    %esi,%esi
801032b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032c0:	8b 03                	mov    (%ebx),%eax
801032c2:	85 c0                	test   %eax,%eax
801032c4:	74 e4                	je     801032aa <pipealloc+0x5a>
    fileclose(*f0);
801032c6:	83 ec 0c             	sub    $0xc,%esp
801032c9:	50                   	push   %eax
801032ca:	e8 71 db ff ff       	call   80100e40 <fileclose>
  if(*f1)
801032cf:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032d1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032d4:	85 c0                	test   %eax,%eax
801032d6:	75 c6                	jne    8010329e <pipealloc+0x4e>
801032d8:	eb d0                	jmp    801032aa <pipealloc+0x5a>
801032da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801032e0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801032e3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032ea:	00 00 00 
  p->writeopen = 1;
801032ed:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801032f4:	00 00 00 
  p->nwrite = 0;
801032f7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801032fe:	00 00 00 
  p->nread = 0;
80103301:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103308:	00 00 00 
  initlock(&p->lock, "pipe");
8010330b:	68 90 7c 10 80       	push   $0x80107c90
80103310:	50                   	push   %eax
80103311:	e8 5a 16 00 00       	call   80104970 <initlock>
  (*f0)->type = FD_PIPE;
80103316:	8b 03                	mov    (%ebx),%eax
  return 0;
80103318:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010331b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103321:	8b 03                	mov    (%ebx),%eax
80103323:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103327:	8b 03                	mov    (%ebx),%eax
80103329:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010332d:	8b 03                	mov    (%ebx),%eax
8010332f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103332:	8b 06                	mov    (%esi),%eax
80103334:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010333a:	8b 06                	mov    (%esi),%eax
8010333c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103340:	8b 06                	mov    (%esi),%eax
80103342:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103346:	8b 06                	mov    (%esi),%eax
80103348:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010334b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010334e:	31 c0                	xor    %eax,%eax
}
80103350:	5b                   	pop    %ebx
80103351:	5e                   	pop    %esi
80103352:	5f                   	pop    %edi
80103353:	5d                   	pop    %ebp
80103354:	c3                   	ret    
80103355:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103360 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	56                   	push   %esi
80103364:	53                   	push   %ebx
80103365:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103368:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010336b:	83 ec 0c             	sub    $0xc,%esp
8010336e:	53                   	push   %ebx
8010336f:	e8 3c 17 00 00       	call   80104ab0 <acquire>
  if(writable){
80103374:	83 c4 10             	add    $0x10,%esp
80103377:	85 f6                	test   %esi,%esi
80103379:	74 45                	je     801033c0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010337b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103381:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103384:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010338b:	00 00 00 
    wakeup(&p->nread);
8010338e:	50                   	push   %eax
8010338f:	e8 4c 11 00 00       	call   801044e0 <wakeup>
80103394:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103397:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010339d:	85 d2                	test   %edx,%edx
8010339f:	75 0a                	jne    801033ab <pipeclose+0x4b>
801033a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033a7:	85 c0                	test   %eax,%eax
801033a9:	74 35                	je     801033e0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801033ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801033ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033b1:	5b                   	pop    %ebx
801033b2:	5e                   	pop    %esi
801033b3:	5d                   	pop    %ebp
    release(&p->lock);
801033b4:	e9 b7 17 00 00       	jmp    80104b70 <release>
801033b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033c0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033c6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033d0:	00 00 00 
    wakeup(&p->nwrite);
801033d3:	50                   	push   %eax
801033d4:	e8 07 11 00 00       	call   801044e0 <wakeup>
801033d9:	83 c4 10             	add    $0x10,%esp
801033dc:	eb b9                	jmp    80103397 <pipeclose+0x37>
801033de:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033e0:	83 ec 0c             	sub    $0xc,%esp
801033e3:	53                   	push   %ebx
801033e4:	e8 87 17 00 00       	call   80104b70 <release>
    kfree((char*)p);
801033e9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033ec:	83 c4 10             	add    $0x10,%esp
}
801033ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033f2:	5b                   	pop    %ebx
801033f3:	5e                   	pop    %esi
801033f4:	5d                   	pop    %ebp
    kfree((char*)p);
801033f5:	e9 26 ef ff ff       	jmp    80102320 <kfree>
801033fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103400 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103400:	55                   	push   %ebp
80103401:	89 e5                	mov    %esp,%ebp
80103403:	57                   	push   %edi
80103404:	56                   	push   %esi
80103405:	53                   	push   %ebx
80103406:	83 ec 28             	sub    $0x28,%esp
80103409:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010340c:	53                   	push   %ebx
8010340d:	e8 9e 16 00 00       	call   80104ab0 <acquire>
  for(i = 0; i < n; i++){
80103412:	8b 45 10             	mov    0x10(%ebp),%eax
80103415:	83 c4 10             	add    $0x10,%esp
80103418:	85 c0                	test   %eax,%eax
8010341a:	0f 8e c9 00 00 00    	jle    801034e9 <pipewrite+0xe9>
80103420:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103423:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103429:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010342f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103432:	03 4d 10             	add    0x10(%ebp),%ecx
80103435:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103438:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010343e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103444:	39 d0                	cmp    %edx,%eax
80103446:	75 71                	jne    801034b9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103448:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010344e:	85 c0                	test   %eax,%eax
80103450:	74 4e                	je     801034a0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103452:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103458:	eb 3a                	jmp    80103494 <pipewrite+0x94>
8010345a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103460:	83 ec 0c             	sub    $0xc,%esp
80103463:	57                   	push   %edi
80103464:	e8 77 10 00 00       	call   801044e0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103469:	5a                   	pop    %edx
8010346a:	59                   	pop    %ecx
8010346b:	53                   	push   %ebx
8010346c:	56                   	push   %esi
8010346d:	e8 ae 0e 00 00       	call   80104320 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103472:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103478:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010347e:	83 c4 10             	add    $0x10,%esp
80103481:	05 00 02 00 00       	add    $0x200,%eax
80103486:	39 c2                	cmp    %eax,%edx
80103488:	75 36                	jne    801034c0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010348a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103490:	85 c0                	test   %eax,%eax
80103492:	74 0c                	je     801034a0 <pipewrite+0xa0>
80103494:	e8 c7 06 00 00       	call   80103b60 <myproc>
80103499:	8b 40 24             	mov    0x24(%eax),%eax
8010349c:	85 c0                	test   %eax,%eax
8010349e:	74 c0                	je     80103460 <pipewrite+0x60>
        release(&p->lock);
801034a0:	83 ec 0c             	sub    $0xc,%esp
801034a3:	53                   	push   %ebx
801034a4:	e8 c7 16 00 00       	call   80104b70 <release>
        return -1;
801034a9:	83 c4 10             	add    $0x10,%esp
801034ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034b4:	5b                   	pop    %ebx
801034b5:	5e                   	pop    %esi
801034b6:	5f                   	pop    %edi
801034b7:	5d                   	pop    %ebp
801034b8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034b9:	89 c2                	mov    %eax,%edx
801034bb:	90                   	nop
801034bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034c0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034c3:	8d 42 01             	lea    0x1(%edx),%eax
801034c6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034cc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034d2:	83 c6 01             	add    $0x1,%esi
801034d5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034d9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034dc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034df:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801034e3:	0f 85 4f ff ff ff    	jne    80103438 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034e9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034ef:	83 ec 0c             	sub    $0xc,%esp
801034f2:	50                   	push   %eax
801034f3:	e8 e8 0f 00 00       	call   801044e0 <wakeup>
  release(&p->lock);
801034f8:	89 1c 24             	mov    %ebx,(%esp)
801034fb:	e8 70 16 00 00       	call   80104b70 <release>
  return n;
80103500:	83 c4 10             	add    $0x10,%esp
80103503:	8b 45 10             	mov    0x10(%ebp),%eax
80103506:	eb a9                	jmp    801034b1 <pipewrite+0xb1>
80103508:	90                   	nop
80103509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103510 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103510:	55                   	push   %ebp
80103511:	89 e5                	mov    %esp,%ebp
80103513:	57                   	push   %edi
80103514:	56                   	push   %esi
80103515:	53                   	push   %ebx
80103516:	83 ec 18             	sub    $0x18,%esp
80103519:	8b 75 08             	mov    0x8(%ebp),%esi
8010351c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010351f:	56                   	push   %esi
80103520:	e8 8b 15 00 00       	call   80104ab0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103525:	83 c4 10             	add    $0x10,%esp
80103528:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010352e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103534:	75 6a                	jne    801035a0 <piperead+0x90>
80103536:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010353c:	85 db                	test   %ebx,%ebx
8010353e:	0f 84 c4 00 00 00    	je     80103608 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103544:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010354a:	eb 2d                	jmp    80103579 <piperead+0x69>
8010354c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103550:	83 ec 08             	sub    $0x8,%esp
80103553:	56                   	push   %esi
80103554:	53                   	push   %ebx
80103555:	e8 c6 0d 00 00       	call   80104320 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010355a:	83 c4 10             	add    $0x10,%esp
8010355d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103563:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103569:	75 35                	jne    801035a0 <piperead+0x90>
8010356b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103571:	85 d2                	test   %edx,%edx
80103573:	0f 84 8f 00 00 00    	je     80103608 <piperead+0xf8>
    if(myproc()->killed){
80103579:	e8 e2 05 00 00       	call   80103b60 <myproc>
8010357e:	8b 48 24             	mov    0x24(%eax),%ecx
80103581:	85 c9                	test   %ecx,%ecx
80103583:	74 cb                	je     80103550 <piperead+0x40>
      release(&p->lock);
80103585:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103588:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010358d:	56                   	push   %esi
8010358e:	e8 dd 15 00 00       	call   80104b70 <release>
      return -1;
80103593:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103596:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103599:	89 d8                	mov    %ebx,%eax
8010359b:	5b                   	pop    %ebx
8010359c:	5e                   	pop    %esi
8010359d:	5f                   	pop    %edi
8010359e:	5d                   	pop    %ebp
8010359f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035a0:	8b 45 10             	mov    0x10(%ebp),%eax
801035a3:	85 c0                	test   %eax,%eax
801035a5:	7e 61                	jle    80103608 <piperead+0xf8>
    if(p->nread == p->nwrite)
801035a7:	31 db                	xor    %ebx,%ebx
801035a9:	eb 13                	jmp    801035be <piperead+0xae>
801035ab:	90                   	nop
801035ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035b0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035b6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035bc:	74 1f                	je     801035dd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035be:	8d 41 01             	lea    0x1(%ecx),%eax
801035c1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035c7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035cd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035d2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035d5:	83 c3 01             	add    $0x1,%ebx
801035d8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035db:	75 d3                	jne    801035b0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035dd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801035e3:	83 ec 0c             	sub    $0xc,%esp
801035e6:	50                   	push   %eax
801035e7:	e8 f4 0e 00 00       	call   801044e0 <wakeup>
  release(&p->lock);
801035ec:	89 34 24             	mov    %esi,(%esp)
801035ef:	e8 7c 15 00 00       	call   80104b70 <release>
  return i;
801035f4:	83 c4 10             	add    $0x10,%esp
}
801035f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035fa:	89 d8                	mov    %ebx,%eax
801035fc:	5b                   	pop    %ebx
801035fd:	5e                   	pop    %esi
801035fe:	5f                   	pop    %edi
801035ff:	5d                   	pop    %ebp
80103600:	c3                   	ret    
80103601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103608:	31 db                	xor    %ebx,%ebx
8010360a:	eb d1                	jmp    801035dd <piperead+0xcd>
8010360c:	66 90                	xchg   %ax,%ax
8010360e:	66 90                	xchg   %ax,%ax

80103610 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  int idx=0;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++,idx++)
80103614:	bb 14 d3 12 80       	mov    $0x8012d314,%ebx
{
80103619:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010361c:	68 e0 d2 12 80       	push   $0x8012d2e0
80103621:	e8 8a 14 00 00       	call   80104ab0 <acquire>
80103626:	83 c4 10             	add    $0x10,%esp
  int idx=0;
80103629:	31 c0                	xor    %eax,%eax
8010362b:	eb 18                	jmp    80103645 <allocproc+0x35>
8010362d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++,idx++)
80103630:	81 c3 78 01 00 00    	add    $0x178,%ebx
80103636:	83 c0 01             	add    $0x1,%eax
80103639:	81 fb 14 31 13 80    	cmp    $0x80133114,%ebx
8010363f:	0f 83 c3 00 00 00    	jae    80103708 <allocproc+0xf8>
    if(p->state == UNUSED)
80103645:	8b 53 0c             	mov    0xc(%ebx),%edx
80103648:	85 d2                	test   %edx,%edx
8010364a:	75 e4                	jne    80103630 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
8010364c:	8b 15 04 b0 10 80    	mov    0x8010b004,%edx
  p->h=0;
  p->size=0;
  process_Qs[idx].h=0;
  process_Qs[idx].t=0;
  process_Qs[idx].size=0;
  release(&ptable.lock);
80103652:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103655:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  process_Qs[idx].h=0;
8010365c:	69 c0 4c 06 00 00    	imul   $0x64c,%eax,%eax
  p->t=0;
80103662:	c7 83 74 01 00 00 00 	movl   $0x0,0x174(%ebx)
80103669:	00 00 00 
  p->h=0;
8010366c:	c7 83 70 01 00 00 00 	movl   $0x0,0x170(%ebx)
80103673:	00 00 00 
  p->size=0;
80103676:	c7 83 cc 00 00 00 00 	movl   $0x0,0xcc(%ebx)
8010367d:	00 00 00 
  p->pid = nextpid++;
80103680:	8d 4a 01             	lea    0x1(%edx),%ecx
80103683:	89 53 10             	mov    %edx,0x10(%ebx)
  release(&ptable.lock);
80103686:	68 e0 d2 12 80       	push   $0x8012d2e0
  process_Qs[idx].h=0;
8010368b:	c7 80 20 46 11 80 00 	movl   $0x0,-0x7feeb9e0(%eax)
80103692:	00 00 00 
  process_Qs[idx].t=0;
80103695:	c7 80 24 46 11 80 00 	movl   $0x0,-0x7feeb9dc(%eax)
8010369c:	00 00 00 
  p->pid = nextpid++;
8010369f:	89 0d 04 b0 10 80    	mov    %ecx,0x8010b004
  process_Qs[idx].size=0;
801036a5:	c7 80 28 46 11 80 00 	movl   $0x0,-0x7feeb9d8(%eax)
801036ac:	00 00 00 
  release(&ptable.lock);
801036af:	e8 bc 14 00 00       	call   80104b70 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801036b4:	e8 17 ee ff ff       	call   801024d0 <kalloc>
801036b9:	83 c4 10             	add    $0x10,%esp
801036bc:	85 c0                	test   %eax,%eax
801036be:	89 43 08             	mov    %eax,0x8(%ebx)
801036c1:	74 5e                	je     80103721 <allocproc+0x111>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801036c3:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801036c9:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801036cc:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801036d1:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801036d4:	c7 40 14 c2 5e 10 80 	movl   $0x80105ec2,0x14(%eax)
  p->context = (struct context*)sp;
801036db:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801036de:	6a 14                	push   $0x14
801036e0:	6a 00                	push   $0x0
801036e2:	50                   	push   %eax
801036e3:	e8 d8 14 00 00       	call   80104bc0 <memset>
  p->context->eip = (uint)forkret;
801036e8:	8b 43 1c             	mov    0x1c(%ebx),%eax
  p->sighandler = (sig_handler)-1; // default signal handler value
  return p;
801036eb:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801036ee:	c7 40 10 30 37 10 80 	movl   $0x80103730,0x10(%eax)
  p->sighandler = (sig_handler)-1; // default signal handler value
801036f5:	c7 43 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%ebx)
}
801036fc:	89 d8                	mov    %ebx,%eax
801036fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103701:	c9                   	leave  
80103702:	c3                   	ret    
80103703:	90                   	nop
80103704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103708:	83 ec 0c             	sub    $0xc,%esp
  return 0;
8010370b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
8010370d:	68 e0 d2 12 80       	push   $0x8012d2e0
80103712:	e8 59 14 00 00       	call   80104b70 <release>
}
80103717:	89 d8                	mov    %ebx,%eax
  return 0;
80103719:	83 c4 10             	add    $0x10,%esp
}
8010371c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010371f:	c9                   	leave  
80103720:	c3                   	ret    
    p->state = UNUSED;
80103721:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103728:	31 db                	xor    %ebx,%ebx
8010372a:	eb d0                	jmp    801036fc <allocproc+0xec>
8010372c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103730 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103736:	68 e0 d2 12 80       	push   $0x8012d2e0
8010373b:	e8 30 14 00 00       	call   80104b70 <release>

  if (first) {
80103740:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103745:	83 c4 10             	add    $0x10,%esp
80103748:	85 c0                	test   %eax,%eax
8010374a:	75 04                	jne    80103750 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010374c:	c9                   	leave  
8010374d:	c3                   	ret    
8010374e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103750:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103753:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010375a:	00 00 00 
    iinit(ROOTDEV);
8010375d:	6a 01                	push   $0x1
8010375f:	e8 2c dd ff ff       	call   80101490 <iinit>
    initlog(ROOTDEV);
80103764:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010376b:	e8 a0 f3 ff ff       	call   80102b10 <initlog>
80103770:	83 c4 10             	add    $0x10,%esp
}
80103773:	c9                   	leave  
80103774:	c3                   	ret    
80103775:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103780 <setzero>:
void setzero(struct msg_q process_Qs[NPROC]){
80103780:	55                   	push   %ebp
80103781:	89 e5                	mov    %esp,%ebp
80103783:	8b 55 08             	mov    0x8(%ebp),%edx
80103786:	8d 82 40 06 00 00    	lea    0x640(%edx),%eax
8010378c:	81 c2 40 99 01 00    	add    $0x19940,%edx
80103792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    process_Qs[j].h=0;
80103798:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    process_Qs[j].t=0;
8010379e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
801037a5:	05 4c 06 00 00       	add    $0x64c,%eax
    process_Qs[j].size=0;
801037aa:	c7 80 bc f9 ff ff 00 	movl   $0x0,-0x644(%eax)
801037b1:	00 00 00 
  for(int j=0;j<NPROC;j++){
801037b4:	39 d0                	cmp    %edx,%eax
801037b6:	75 e0                	jne    80103798 <setzero+0x18>
}
801037b8:	5d                   	pop    %ebp
801037b9:	c3                   	ret    
801037ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801037c0 <send>:
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	57                   	push   %edi
801037c4:	56                   	push   %esi
801037c5:	53                   	push   %ebx
801037c6:	83 ec 38             	sub    $0x38,%esp
  acquire(&ptable.lock);
801037c9:	68 e0 d2 12 80       	push   $0x8012d2e0
801037ce:	e8 dd 12 00 00       	call   80104ab0 <acquire>
  argint(0,&sender_pid);
801037d3:	58                   	pop    %eax
801037d4:	8d 45 dc             	lea    -0x24(%ebp),%eax
801037d7:	5a                   	pop    %edx
801037d8:	50                   	push   %eax
801037d9:	6a 00                	push   $0x0
801037db:	e8 e0 16 00 00       	call   80104ec0 <argint>
  argint(1,&rec_pid);
801037e0:	59                   	pop    %ecx
801037e1:	8d 45 e0             	lea    -0x20(%ebp),%eax
801037e4:	5b                   	pop    %ebx
801037e5:	50                   	push   %eax
801037e6:	6a 01                	push   $0x1
  if(argstr(2,&msg) < 0) {return -1;}
801037e8:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
  argint(1,&rec_pid);
801037eb:	e8 d0 16 00 00       	call   80104ec0 <argint>
  if(argstr(2,&msg) < 0) {return -1;}
801037f0:	5e                   	pop    %esi
801037f1:	5f                   	pop    %edi
801037f2:	53                   	push   %ebx
801037f3:	6a 02                	push   $0x2
801037f5:	e8 76 17 00 00       	call   80104f70 <argstr>
801037fa:	83 c4 10             	add    $0x10,%esp
801037fd:	85 c0                	test   %eax,%eax
801037ff:	0f 88 00 01 00 00    	js     80103905 <send+0x145>
  argstr(2,&msg);
80103805:	83 ec 08             	sub    $0x8,%esp
80103808:	53                   	push   %ebx
80103809:	6a 02                	push   $0x2
  int idx=0;
8010380b:	31 db                	xor    %ebx,%ebx
  argstr(2,&msg);
8010380d:	e8 5e 17 00 00       	call   80104f70 <argstr>
    if(p->pid ==rec_pid)
80103812:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103815:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++,idx++)
80103818:	b8 14 d3 12 80       	mov    $0x8012d314,%eax
8010381d:	eb 10                	jmp    8010382f <send+0x6f>
8010381f:	90                   	nop
80103820:	05 78 01 00 00       	add    $0x178,%eax
80103825:	83 c3 01             	add    $0x1,%ebx
80103828:	3d 14 31 13 80       	cmp    $0x80133114,%eax
8010382d:	73 05                	jae    80103834 <send+0x74>
    if(p->pid ==rec_pid)
8010382f:	39 50 10             	cmp    %edx,0x10(%eax)
80103832:	75 ec                	jne    80103820 <send+0x60>
  if(idx==NPROC)
80103834:	83 fb 40             	cmp    $0x40,%ebx
80103837:	0f 84 b3 00 00 00    	je     801038f0 <send+0x130>
  if(process_Qs[idx].size >= (50)){
8010383d:	69 c3 4c 06 00 00    	imul   $0x64c,%ebx,%eax
80103843:	05 e0 3f 11 80       	add    $0x80113fe0,%eax
80103848:	8b b8 48 06 00 00    	mov    0x648(%eax),%edi
8010384e:	83 ff 31             	cmp    $0x31,%edi
80103851:	0f 8f b5 00 00 00    	jg     8010390c <send+0x14c>
  int tail = process_Qs[idx].t;
80103857:	8b 88 44 06 00 00    	mov    0x644(%eax),%ecx
  if(tail==50)
8010385d:	83 f9 32             	cmp    $0x32,%ecx
80103860:	74 7e                	je     801038e0 <send+0x120>
80103862:	8d 41 01             	lea    0x1(%ecx),%eax
80103865:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103868:	69 c3 4c 06 00 00    	imul   $0x64c,%ebx,%eax
    process_Qs[idx].mq[tail][i] = *(msg + i);
8010386e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103871:	c1 e1 05             	shl    $0x5,%ecx
80103874:	01 c1                	add    %eax,%ecx
80103876:	31 c0                	xor    %eax,%eax
80103878:	90                   	nop
80103879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103880:	0f be 14 06          	movsbl (%esi,%eax,1),%edx
80103884:	89 94 81 e0 3f 11 80 	mov    %edx,-0x7feec020(%ecx,%eax,4)
    i++;
8010388b:	83 c0 01             	add    $0x1,%eax
  while(i<MSG_SIZE)
8010388e:	83 f8 08             	cmp    $0x8,%eax
80103891:	75 ed                	jne    80103880 <send+0xc0>
  process_Qs[idx].t=tail+1;
80103893:	69 c3 4c 06 00 00    	imul   $0x64c,%ebx,%eax
  process_Qs[idx].size += 1;
80103899:	83 c7 01             	add    $0x1,%edi
  process_Qs[idx].t=tail+1;
8010389c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
  if(p->state == SLEEPING){
8010389f:	69 db 78 01 00 00    	imul   $0x178,%ebx,%ebx
  process_Qs[idx].t=tail+1;
801038a5:	89 b0 24 46 11 80    	mov    %esi,-0x7feeb9dc(%eax)
  process_Qs[idx].size += 1;
801038ab:	89 b8 28 46 11 80    	mov    %edi,-0x7feeb9d8(%eax)
  if(p->state == SLEEPING){
801038b1:	81 c3 e0 d2 12 80    	add    $0x8012d2e0,%ebx
801038b7:	83 7b 40 02          	cmpl   $0x2,0x40(%ebx)
801038bb:	75 07                	jne    801038c4 <send+0x104>
    p->state=RUNNABLE;
801038bd:	c7 43 40 03 00 00 00 	movl   $0x3,0x40(%ebx)
  release(&ptable.lock);
801038c4:	83 ec 0c             	sub    $0xc,%esp
801038c7:	68 e0 d2 12 80       	push   $0x8012d2e0
801038cc:	e8 9f 12 00 00       	call   80104b70 <release>
  return 0;
801038d1:	83 c4 10             	add    $0x10,%esp
801038d4:	31 c0                	xor    %eax,%eax
}
801038d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038d9:	5b                   	pop    %ebx
801038da:	5e                   	pop    %esi
801038db:	5f                   	pop    %edi
801038dc:	5d                   	pop    %ebp
801038dd:	c3                   	ret    
801038de:	66 90                	xchg   %ax,%ax
801038e0:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    tail=0;
801038e7:	31 c9                	xor    %ecx,%ecx
801038e9:	e9 7a ff ff ff       	jmp    80103868 <send+0xa8>
801038ee:	66 90                	xchg   %ax,%ax
    cprintf("idx==NPROC\n");
801038f0:	83 ec 0c             	sub    $0xc,%esp
801038f3:	68 95 7c 10 80       	push   $0x80107c95
801038f8:	e8 63 cd ff ff       	call   80100660 <cprintf>
801038fd:	83 c4 10             	add    $0x10,%esp
80103900:	e9 38 ff ff ff       	jmp    8010383d <send+0x7d>
  if(argstr(2,&msg) < 0) {return -1;}
80103905:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010390a:	eb ca                	jmp    801038d6 <send+0x116>
    cprintf("processQ is full\n");
8010390c:	83 ec 0c             	sub    $0xc,%esp
8010390f:	68 a1 7c 10 80       	push   $0x80107ca1
80103914:	e8 47 cd ff ff       	call   80100660 <cprintf>
    release(&ptable.lock);
80103919:	c7 04 24 e0 d2 12 80 	movl   $0x8012d2e0,(%esp)
80103920:	e8 4b 12 00 00       	call   80104b70 <release>
    return -1;
80103925:	83 c4 10             	add    $0x10,%esp
80103928:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010392d:	eb a7                	jmp    801038d6 <send+0x116>
8010392f:	90                   	nop

80103930 <toggle>:
  if(state1==TRACE_OFF){
80103930:	a1 58 b8 10 80       	mov    0x8010b858,%eax
void toggle(void){
80103935:	55                   	push   %ebp
80103936:	89 e5                	mov    %esp,%ebp
  if(state1==TRACE_OFF){
80103938:	85 c0                	test   %eax,%eax
8010393a:	75 2c                	jne    80103968 <toggle+0x38>
    state1=TRACE_ON;
8010393c:	c7 05 58 b8 10 80 01 	movl   $0x1,0x8010b858
80103943:	00 00 00 
80103946:	b8 20 31 13 80       	mov    $0x80133120,%eax
8010394b:	90                   	nop
8010394c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      sys_count[i]=0;
80103950:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103956:	83 c0 04             	add    $0x4,%eax
    for(int i=0;i<33;i++)
80103959:	3d a4 31 13 80       	cmp    $0x801331a4,%eax
8010395e:	75 f0                	jne    80103950 <toggle+0x20>
}
80103960:	5d                   	pop    %ebp
80103961:	c3                   	ret    
80103962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    state1=TRACE_OFF;
80103968:	c7 05 58 b8 10 80 00 	movl   $0x0,0x8010b858
8010396f:	00 00 00 
}
80103972:	5d                   	pop    %ebp
80103973:	c3                   	ret    
80103974:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010397a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103980 <print_count>:
  if(state1==TRACE_ON){
80103980:	83 3d 58 b8 10 80 01 	cmpl   $0x1,0x8010b858
80103987:	74 07                	je     80103990 <print_count+0x10>
80103989:	f3 c3                	repz ret 
8010398b:	90                   	nop
8010398c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void print_count(void){
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	53                   	push   %ebx
    for(int i=0;i<33;i++){
80103994:	31 db                	xor    %ebx,%ebx
void print_count(void){
80103996:	83 ec 04             	sub    $0x4,%esp
80103999:	eb 0d                	jmp    801039a8 <print_count+0x28>
8010399b:	90                   	nop
8010399c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(int i=0;i<33;i++){
801039a0:	83 c3 01             	add    $0x1,%ebx
801039a3:	83 fb 21             	cmp    $0x21,%ebx
801039a6:	74 2f                	je     801039d7 <print_count+0x57>
      if(sys_count[i]!=0)
801039a8:	8b 04 9d 20 31 13 80 	mov    -0x7feccee0(,%ebx,4),%eax
801039af:	85 c0                	test   %eax,%eax
801039b1:	74 ed                	je     801039a0 <print_count+0x20>
        cprintf("%s %d\n",sys_names[i],sys_count[i]);
801039b3:	83 ec 04             	sub    $0x4,%esp
801039b6:	50                   	push   %eax
801039b7:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
    for(int i=0;i<33;i++){
801039ba:	83 c3 01             	add    $0x1,%ebx
        cprintf("%s %d\n",sys_names[i],sys_count[i]);
801039bd:	8d 04 85 20 b0 10 80 	lea    -0x7fef4fe0(,%eax,4),%eax
801039c4:	50                   	push   %eax
801039c5:	68 b3 7c 10 80       	push   $0x80107cb3
801039ca:	e8 91 cc ff ff       	call   80100660 <cprintf>
801039cf:	83 c4 10             	add    $0x10,%esp
    for(int i=0;i<33;i++){
801039d2:	83 fb 21             	cmp    $0x21,%ebx
801039d5:	75 d1                	jne    801039a8 <print_count+0x28>
}
801039d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039da:	c9                   	leave  
801039db:	c3                   	ret    
801039dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801039e0 <add>:
int add(void){
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	83 ec 20             	sub    $0x20,%esp
  argint(0,&arg1);
801039e6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801039e9:	50                   	push   %eax
801039ea:	6a 00                	push   $0x0
801039ec:	e8 cf 14 00 00       	call   80104ec0 <argint>
  argint(1,&arg2);
801039f1:	58                   	pop    %eax
801039f2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801039f5:	5a                   	pop    %edx
801039f6:	50                   	push   %eax
801039f7:	6a 01                	push   $0x1
801039f9:	e8 c2 14 00 00       	call   80104ec0 <argint>
  int sum=arg1+arg2;
801039fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a01:	03 45 f0             	add    -0x10(%ebp),%eax
}
80103a04:	c9                   	leave  
80103a05:	c3                   	ret    
80103a06:	8d 76 00             	lea    0x0(%esi),%esi
80103a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a10 <ps>:
void ps(void){
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	53                   	push   %ebx
  for(process=ptable.proc;process<&ptable.proc[NPROC];process++)
80103a14:	bb 14 d3 12 80       	mov    $0x8012d314,%ebx
void ps(void){
80103a19:	83 ec 04             	sub    $0x4,%esp
80103a1c:	eb 10                	jmp    80103a2e <ps+0x1e>
80103a1e:	66 90                	xchg   %ax,%ax
  for(process=ptable.proc;process<&ptable.proc[NPROC];process++)
80103a20:	81 c3 78 01 00 00    	add    $0x178,%ebx
80103a26:	81 fb 14 31 13 80    	cmp    $0x80133114,%ebx
80103a2c:	73 33                	jae    80103a61 <ps+0x51>
    if((process->state==SLEEPING)||(process->state==RUNNABLE)||(process->state==RUNNING))
80103a2e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a31:	83 e8 02             	sub    $0x2,%eax
80103a34:	83 f8 02             	cmp    $0x2,%eax
80103a37:	77 e7                	ja     80103a20 <ps+0x10>
      cprintf("pid:%d name:%s\n",process->pid,process->name);
80103a39:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a3c:	83 ec 04             	sub    $0x4,%esp
  for(process=ptable.proc;process<&ptable.proc[NPROC];process++)
80103a3f:	81 c3 78 01 00 00    	add    $0x178,%ebx
      cprintf("pid:%d name:%s\n",process->pid,process->name);
80103a45:	50                   	push   %eax
80103a46:	ff b3 98 fe ff ff    	pushl  -0x168(%ebx)
80103a4c:	68 ba 7c 10 80       	push   $0x80107cba
80103a51:	e8 0a cc ff ff       	call   80100660 <cprintf>
80103a56:	83 c4 10             	add    $0x10,%esp
  for(process=ptable.proc;process<&ptable.proc[NPROC];process++)
80103a59:	81 fb 14 31 13 80    	cmp    $0x80133114,%ebx
80103a5f:	72 cd                	jb     80103a2e <ps+0x1e>
}
80103a61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a64:	c9                   	leave  
80103a65:	c3                   	ret    
80103a66:	8d 76 00             	lea    0x0(%esi),%esi
80103a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a70 <pinit>:
{
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103a76:	68 ca 7c 10 80       	push   $0x80107cca
80103a7b:	68 e0 d2 12 80       	push   $0x8012d2e0
80103a80:	e8 eb 0e 00 00       	call   80104970 <initlock>
80103a85:	b8 20 46 11 80       	mov    $0x80114620,%eax
80103a8a:	83 c4 10             	add    $0x10,%esp
80103a8d:	8d 76 00             	lea    0x0(%esi),%esi
    process_Qs[j].h=0;
80103a90:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    process_Qs[j].t=0;
80103a96:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
80103a9d:	05 4c 06 00 00       	add    $0x64c,%eax
    process_Qs[j].size=0;
80103aa2:	c7 80 bc f9 ff ff 00 	movl   $0x0,-0x644(%eax)
80103aa9:	00 00 00 
  for(int j=0;j<NPROC;j++){
80103aac:	3d 20 d9 12 80       	cmp    $0x8012d920,%eax
80103ab1:	75 dd                	jne    80103a90 <pinit+0x20>
}
80103ab3:	c9                   	leave  
80103ab4:	c3                   	ret    
80103ab5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ac0 <mycpu>:
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	56                   	push   %esi
80103ac4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ac5:	9c                   	pushf  
80103ac6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ac7:	f6 c4 02             	test   $0x2,%ah
80103aca:	75 5e                	jne    80103b2a <mycpu+0x6a>
  apicid = lapicid();
80103acc:	e8 6f ec ff ff       	call   80102740 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103ad1:	8b 35 c0 3f 11 80    	mov    0x80113fc0,%esi
80103ad7:	85 f6                	test   %esi,%esi
80103ad9:	7e 42                	jle    80103b1d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103adb:	0f b6 15 40 3a 11 80 	movzbl 0x80113a40,%edx
80103ae2:	39 d0                	cmp    %edx,%eax
80103ae4:	74 30                	je     80103b16 <mycpu+0x56>
80103ae6:	b9 f0 3a 11 80       	mov    $0x80113af0,%ecx
  for (i = 0; i < ncpu; ++i) {
80103aeb:	31 d2                	xor    %edx,%edx
80103aed:	8d 76 00             	lea    0x0(%esi),%esi
80103af0:	83 c2 01             	add    $0x1,%edx
80103af3:	39 f2                	cmp    %esi,%edx
80103af5:	74 26                	je     80103b1d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103af7:	0f b6 19             	movzbl (%ecx),%ebx
80103afa:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103b00:	39 c3                	cmp    %eax,%ebx
80103b02:	75 ec                	jne    80103af0 <mycpu+0x30>
80103b04:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103b0a:	05 40 3a 11 80       	add    $0x80113a40,%eax
}
80103b0f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b12:	5b                   	pop    %ebx
80103b13:	5e                   	pop    %esi
80103b14:	5d                   	pop    %ebp
80103b15:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103b16:	b8 40 3a 11 80       	mov    $0x80113a40,%eax
      return &cpus[i];
80103b1b:	eb f2                	jmp    80103b0f <mycpu+0x4f>
  panic("unknown apicid\n");
80103b1d:	83 ec 0c             	sub    $0xc,%esp
80103b20:	68 d1 7c 10 80       	push   $0x80107cd1
80103b25:	e8 66 c8 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103b2a:	83 ec 0c             	sub    $0xc,%esp
80103b2d:	68 ac 7d 10 80       	push   $0x80107dac
80103b32:	e8 59 c8 ff ff       	call   80100390 <panic>
80103b37:	89 f6                	mov    %esi,%esi
80103b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b40 <cpuid>:
cpuid() {
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103b46:	e8 75 ff ff ff       	call   80103ac0 <mycpu>
80103b4b:	2d 40 3a 11 80       	sub    $0x80113a40,%eax
}
80103b50:	c9                   	leave  
  return mycpu()-cpus;
80103b51:	c1 f8 04             	sar    $0x4,%eax
80103b54:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103b5a:	c3                   	ret    
80103b5b:	90                   	nop
80103b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b60 <myproc>:
myproc(void) {
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	53                   	push   %ebx
80103b64:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103b67:	e8 74 0e 00 00       	call   801049e0 <pushcli>
  c = mycpu();
80103b6c:	e8 4f ff ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80103b71:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b77:	e8 a4 0e 00 00       	call   80104a20 <popcli>
}
80103b7c:	83 c4 04             	add    $0x4,%esp
80103b7f:	89 d8                	mov    %ebx,%eax
80103b81:	5b                   	pop    %ebx
80103b82:	5d                   	pop    %ebp
80103b83:	c3                   	ret    
80103b84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103b8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103b90 <userinit>:
{
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	53                   	push   %ebx
80103b94:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103b97:	e8 74 fa ff ff       	call   80103610 <allocproc>
80103b9c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103b9e:	a3 5c b8 10 80       	mov    %eax,0x8010b85c
  if((p->pgdir = setupkvm()) == 0)
80103ba3:	e8 f8 38 00 00       	call   801074a0 <setupkvm>
80103ba8:	85 c0                	test   %eax,%eax
80103baa:	89 43 04             	mov    %eax,0x4(%ebx)
80103bad:	0f 84 bd 00 00 00    	je     80103c70 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103bb3:	83 ec 04             	sub    $0x4,%esp
80103bb6:	68 2c 00 00 00       	push   $0x2c
80103bbb:	68 00 b7 10 80       	push   $0x8010b700
80103bc0:	50                   	push   %eax
80103bc1:	e8 ba 35 00 00       	call   80107180 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103bc6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103bc9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103bcf:	6a 4c                	push   $0x4c
80103bd1:	6a 00                	push   $0x0
80103bd3:	ff 73 18             	pushl  0x18(%ebx)
80103bd6:	e8 e5 0f 00 00       	call   80104bc0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103bdb:	8b 43 18             	mov    0x18(%ebx),%eax
80103bde:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103be3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103be8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103beb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103bef:	8b 43 18             	mov    0x18(%ebx),%eax
80103bf2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103bf6:	8b 43 18             	mov    0x18(%ebx),%eax
80103bf9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103bfd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103c01:	8b 43 18             	mov    0x18(%ebx),%eax
80103c04:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c08:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103c0c:	8b 43 18             	mov    0x18(%ebx),%eax
80103c0f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103c16:	8b 43 18             	mov    0x18(%ebx),%eax
80103c19:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103c20:	8b 43 18             	mov    0x18(%ebx),%eax
80103c23:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c2a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c2d:	6a 10                	push   $0x10
80103c2f:	68 fa 7c 10 80       	push   $0x80107cfa
80103c34:	50                   	push   %eax
80103c35:	e8 66 11 00 00       	call   80104da0 <safestrcpy>
  p->cwd = namei("/");
80103c3a:	c7 04 24 03 7d 10 80 	movl   $0x80107d03,(%esp)
80103c41:	e8 aa e2 ff ff       	call   80101ef0 <namei>
80103c46:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103c49:	c7 04 24 e0 d2 12 80 	movl   $0x8012d2e0,(%esp)
80103c50:	e8 5b 0e 00 00       	call   80104ab0 <acquire>
  p->state = RUNNABLE;
80103c55:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103c5c:	c7 04 24 e0 d2 12 80 	movl   $0x8012d2e0,(%esp)
80103c63:	e8 08 0f 00 00       	call   80104b70 <release>
}
80103c68:	83 c4 10             	add    $0x10,%esp
80103c6b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c6e:	c9                   	leave  
80103c6f:	c3                   	ret    
    panic("userinit: out of memory?");
80103c70:	83 ec 0c             	sub    $0xc,%esp
80103c73:	68 e1 7c 10 80       	push   $0x80107ce1
80103c78:	e8 13 c7 ff ff       	call   80100390 <panic>
80103c7d:	8d 76 00             	lea    0x0(%esi),%esi

80103c80 <growproc>:
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	56                   	push   %esi
80103c84:	53                   	push   %ebx
80103c85:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103c88:	e8 53 0d 00 00       	call   801049e0 <pushcli>
  c = mycpu();
80103c8d:	e8 2e fe ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80103c92:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c98:	e8 83 0d 00 00       	call   80104a20 <popcli>
  if(n > 0){
80103c9d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103ca0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ca2:	7f 1c                	jg     80103cc0 <growproc+0x40>
  } else if(n < 0){
80103ca4:	75 3a                	jne    80103ce0 <growproc+0x60>
  switchuvm(curproc);
80103ca6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103ca9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103cab:	53                   	push   %ebx
80103cac:	e8 bf 33 00 00       	call   80107070 <switchuvm>
  return 0;
80103cb1:	83 c4 10             	add    $0x10,%esp
80103cb4:	31 c0                	xor    %eax,%eax
}
80103cb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cb9:	5b                   	pop    %ebx
80103cba:	5e                   	pop    %esi
80103cbb:	5d                   	pop    %ebp
80103cbc:	c3                   	ret    
80103cbd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103cc0:	83 ec 04             	sub    $0x4,%esp
80103cc3:	01 c6                	add    %eax,%esi
80103cc5:	56                   	push   %esi
80103cc6:	50                   	push   %eax
80103cc7:	ff 73 04             	pushl  0x4(%ebx)
80103cca:	e8 f1 35 00 00       	call   801072c0 <allocuvm>
80103ccf:	83 c4 10             	add    $0x10,%esp
80103cd2:	85 c0                	test   %eax,%eax
80103cd4:	75 d0                	jne    80103ca6 <growproc+0x26>
      return -1;
80103cd6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cdb:	eb d9                	jmp    80103cb6 <growproc+0x36>
80103cdd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ce0:	83 ec 04             	sub    $0x4,%esp
80103ce3:	01 c6                	add    %eax,%esi
80103ce5:	56                   	push   %esi
80103ce6:	50                   	push   %eax
80103ce7:	ff 73 04             	pushl  0x4(%ebx)
80103cea:	e8 01 37 00 00       	call   801073f0 <deallocuvm>
80103cef:	83 c4 10             	add    $0x10,%esp
80103cf2:	85 c0                	test   %eax,%eax
80103cf4:	75 b0                	jne    80103ca6 <growproc+0x26>
80103cf6:	eb de                	jmp    80103cd6 <growproc+0x56>
80103cf8:	90                   	nop
80103cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d00 <fork>:
{
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	57                   	push   %edi
80103d04:	56                   	push   %esi
80103d05:	53                   	push   %ebx
80103d06:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103d09:	e8 d2 0c 00 00       	call   801049e0 <pushcli>
  c = mycpu();
80103d0e:	e8 ad fd ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80103d13:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d19:	e8 02 0d 00 00       	call   80104a20 <popcli>
  if((np = allocproc()) == 0){
80103d1e:	e8 ed f8 ff ff       	call   80103610 <allocproc>
80103d23:	85 c0                	test   %eax,%eax
80103d25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103d28:	0f 84 bd 00 00 00    	je     80103deb <fork+0xeb>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d2e:	83 ec 08             	sub    $0x8,%esp
80103d31:	ff 33                	pushl  (%ebx)
80103d33:	ff 73 04             	pushl  0x4(%ebx)
80103d36:	89 c7                	mov    %eax,%edi
80103d38:	e8 33 38 00 00       	call   80107570 <copyuvm>
80103d3d:	83 c4 10             	add    $0x10,%esp
80103d40:	85 c0                	test   %eax,%eax
80103d42:	89 47 04             	mov    %eax,0x4(%edi)
80103d45:	0f 84 a7 00 00 00    	je     80103df2 <fork+0xf2>
  np->sz = curproc->sz;
80103d4b:	8b 03                	mov    (%ebx),%eax
80103d4d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103d50:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103d52:	89 59 14             	mov    %ebx,0x14(%ecx)
80103d55:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103d57:	8b 79 18             	mov    0x18(%ecx),%edi
80103d5a:	8b 73 18             	mov    0x18(%ebx),%esi
80103d5d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103d62:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103d64:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103d66:	8b 40 18             	mov    0x18(%eax),%eax
80103d69:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103d70:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103d74:	85 c0                	test   %eax,%eax
80103d76:	74 13                	je     80103d8b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d78:	83 ec 0c             	sub    $0xc,%esp
80103d7b:	50                   	push   %eax
80103d7c:	e8 6f d0 ff ff       	call   80100df0 <filedup>
80103d81:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103d84:	83 c4 10             	add    $0x10,%esp
80103d87:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103d8b:	83 c6 01             	add    $0x1,%esi
80103d8e:	83 fe 10             	cmp    $0x10,%esi
80103d91:	75 dd                	jne    80103d70 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103d93:	83 ec 0c             	sub    $0xc,%esp
80103d96:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d99:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103d9c:	e8 bf d8 ff ff       	call   80101660 <idup>
80103da1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103da4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103da7:	89 47 68             	mov    %eax,0x68(%edi)
  np->sighandler = curproc->sighandler; // copy the parent's signal handler
80103daa:	8b 43 10             	mov    0x10(%ebx),%eax
80103dad:	89 47 7c             	mov    %eax,0x7c(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103db0:	8d 47 6c             	lea    0x6c(%edi),%eax
80103db3:	6a 10                	push   $0x10
80103db5:	53                   	push   %ebx
80103db6:	50                   	push   %eax
80103db7:	e8 e4 0f 00 00       	call   80104da0 <safestrcpy>
  pid = np->pid;
80103dbc:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103dbf:	c7 04 24 e0 d2 12 80 	movl   $0x8012d2e0,(%esp)
80103dc6:	e8 e5 0c 00 00       	call   80104ab0 <acquire>
  np->state = RUNNABLE;
80103dcb:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103dd2:	c7 04 24 e0 d2 12 80 	movl   $0x8012d2e0,(%esp)
80103dd9:	e8 92 0d 00 00       	call   80104b70 <release>
  return pid;
80103dde:	83 c4 10             	add    $0x10,%esp
}
80103de1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103de4:	89 d8                	mov    %ebx,%eax
80103de6:	5b                   	pop    %ebx
80103de7:	5e                   	pop    %esi
80103de8:	5f                   	pop    %edi
80103de9:	5d                   	pop    %ebp
80103dea:	c3                   	ret    
    return -1;
80103deb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103df0:	eb ef                	jmp    80103de1 <fork+0xe1>
    kfree(np->kstack);
80103df2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103df5:	83 ec 0c             	sub    $0xc,%esp
80103df8:	ff 73 08             	pushl  0x8(%ebx)
80103dfb:	e8 20 e5 ff ff       	call   80102320 <kfree>
    np->kstack = 0;
80103e00:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103e07:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103e0e:	83 c4 10             	add    $0x10,%esp
80103e11:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e16:	eb c9                	jmp    80103de1 <fork+0xe1>
80103e18:	90                   	nop
80103e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e20 <scheduler>:
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	57                   	push   %edi
80103e24:	56                   	push   %esi
80103e25:	53                   	push   %ebx
80103e26:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103e29:	e8 92 fc ff ff       	call   80103ac0 <mycpu>
80103e2e:	8d 78 04             	lea    0x4(%eax),%edi
80103e31:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103e33:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103e3a:	00 00 00 
80103e3d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103e40:	fb                   	sti    
    acquire(&ptable.lock);
80103e41:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e44:	bb 14 d3 12 80       	mov    $0x8012d314,%ebx
    acquire(&ptable.lock);
80103e49:	68 e0 d2 12 80       	push   $0x8012d2e0
80103e4e:	e8 5d 0c 00 00       	call   80104ab0 <acquire>
80103e53:	83 c4 10             	add    $0x10,%esp
80103e56:	8d 76 00             	lea    0x0(%esi),%esi
80103e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103e60:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103e64:	75 33                	jne    80103e99 <scheduler+0x79>
      switchuvm(p);
80103e66:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103e69:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103e6f:	53                   	push   %ebx
80103e70:	e8 fb 31 00 00       	call   80107070 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103e75:	58                   	pop    %eax
80103e76:	5a                   	pop    %edx
80103e77:	ff 73 1c             	pushl  0x1c(%ebx)
80103e7a:	57                   	push   %edi
      p->state = RUNNING;
80103e7b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103e82:	e8 74 0f 00 00       	call   80104dfb <swtch>
      switchkvm();
80103e87:	e8 c4 31 00 00       	call   80107050 <switchkvm>
      c->proc = 0;
80103e8c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103e93:	00 00 00 
80103e96:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e99:	81 c3 78 01 00 00    	add    $0x178,%ebx
80103e9f:	81 fb 14 31 13 80    	cmp    $0x80133114,%ebx
80103ea5:	72 b9                	jb     80103e60 <scheduler+0x40>
    release(&ptable.lock);
80103ea7:	83 ec 0c             	sub    $0xc,%esp
80103eaa:	68 e0 d2 12 80       	push   $0x8012d2e0
80103eaf:	e8 bc 0c 00 00       	call   80104b70 <release>
    sti();
80103eb4:	83 c4 10             	add    $0x10,%esp
80103eb7:	eb 87                	jmp    80103e40 <scheduler+0x20>
80103eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ec0 <checkSignals>:
void checkSignals(struct trapframe *tf){
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	56                   	push   %esi
80103ec4:	53                   	push   %ebx
  pushcli();
80103ec5:	e8 16 0b 00 00       	call   801049e0 <pushcli>
  c = mycpu();
80103eca:	e8 f1 fb ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80103ecf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ed5:	e8 46 0b 00 00       	call   80104a20 <popcli>
  if (proc == 0)
80103eda:	85 db                	test   %ebx,%ebx
80103edc:	74 10                	je     80103eee <checkSignals+0x2e>
  if ((tf->cs & 3) != DPL_USER)
80103ede:	8b 45 08             	mov    0x8(%ebp),%eax
80103ee1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80103ee5:	83 e0 03             	and    $0x3,%eax
80103ee8:	66 83 f8 03          	cmp    $0x3,%ax
80103eec:	74 0a                	je     80103ef8 <checkSignals+0x38>
}
80103eee:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ef1:	5b                   	pop    %ebx
80103ef2:	5e                   	pop    %esi
80103ef3:	5d                   	pop    %ebp
80103ef4:	c3                   	ret    
80103ef5:	8d 76 00             	lea    0x0(%esi),%esi
  if(proc->size==0)
80103ef8:	8b 83 cc 00 00 00    	mov    0xcc(%ebx),%eax
80103efe:	85 c0                	test   %eax,%eax
80103f00:	74 ec                	je     80103eee <checkSignals+0x2e>
  if(proc->sighandler == (sig_handler)-1)
80103f02:	83 7b 7c ff          	cmpl   $0xffffffff,0x7c(%ebx)
80103f06:	74 e6                	je     80103eee <checkSignals+0x2e>
  memmove(&proc->oldTf, proc->tf, sizeof(struct trapframe));//backing up trap frame
80103f08:	8d 83 80 00 00 00    	lea    0x80(%ebx),%eax
80103f0e:	83 ec 04             	sub    $0x4,%esp
80103f11:	6a 4c                	push   $0x4c
80103f13:	ff 73 18             	pushl  0x18(%ebx)
80103f16:	50                   	push   %eax
80103f17:	e8 54 0d 00 00       	call   80104c70 <memmove>
          proc->tf->esp -= (uint)&invoke_sigret_end - (uint)&invoke_sigret_start;
80103f1c:	8b 53 18             	mov    0x18(%ebx),%edx
80103f1f:	b8 32 77 10 80       	mov    $0x80107732,%eax
          memmove((void*)proc->tf->esp, invoke_sigret_start, (uint)&invoke_sigret_end - (uint)&invoke_sigret_start);
80103f24:	83 c4 0c             	add    $0xc,%esp
          proc->tf->esp -= (uint)&invoke_sigret_end - (uint)&invoke_sigret_start;
80103f27:	2d 39 77 10 80       	sub    $0x80107739,%eax
80103f2c:	01 42 44             	add    %eax,0x44(%edx)
          memmove((void*)proc->tf->esp, invoke_sigret_start, (uint)&invoke_sigret_end - (uint)&invoke_sigret_start);
80103f2f:	b8 39 77 10 80       	mov    $0x80107739,%eax
80103f34:	2d 32 77 10 80       	sub    $0x80107732,%eax
80103f39:	50                   	push   %eax
80103f3a:	68 32 77 10 80       	push   $0x80107732
80103f3f:	8b 43 18             	mov    0x18(%ebx),%eax
80103f42:	ff 70 44             	pushl  0x44(%eax)
80103f45:	e8 26 0d 00 00       	call   80104c70 <memmove>
          int h=proc->h;
80103f4a:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
          if(h==20)
80103f50:	83 c4 10             	add    $0x10,%esp
80103f53:	83 f8 14             	cmp    $0x14,%eax
80103f56:	8d 50 01             	lea    0x1(%eax),%edx
80103f59:	75 07                	jne    80103f62 <checkSignals+0xa2>
80103f5b:	ba 01 00 00 00       	mov    $0x1,%edx
            h=0;
80103f60:	31 c0                	xor    %eax,%eax
          *((int*)(proc->tf->esp - 4)) = (int)proc->signal_arr[h][1];
80103f62:	8b 4b 18             	mov    0x18(%ebx),%ecx
80103f65:	8b b4 c3 d4 00 00 00 	mov    0xd4(%ebx,%eax,8),%esi
80103f6c:	8b 49 44             	mov    0x44(%ecx),%ecx
80103f6f:	89 71 fc             	mov    %esi,-0x4(%ecx)
          *((int*)(proc->tf->esp - 8)) = (int)proc->signal_arr[h][0];
80103f72:	8b 8c c3 d0 00 00 00 	mov    0xd0(%ebx,%eax,8),%ecx
80103f79:	8b 43 18             	mov    0x18(%ebx),%eax
80103f7c:	8b 40 44             	mov    0x44(%eax),%eax
80103f7f:	89 48 f8             	mov    %ecx,-0x8(%eax)
          *((int*)(proc->tf->esp - 12)) = proc->tf->esp; // sigret system call code address
80103f82:	8b 43 18             	mov    0x18(%ebx),%eax
80103f85:	8b 40 44             	mov    0x44(%eax),%eax
80103f88:	89 40 f4             	mov    %eax,-0xc(%eax)
          proc->tf->esp -= 12;
80103f8b:	8b 43 18             	mov    0x18(%ebx),%eax
80103f8e:	83 68 44 0c          	subl   $0xc,0x44(%eax)
          proc->tf->eip = (uint)proc->sighandler; // trapret will resume into signal handler
80103f92:	8b 43 18             	mov    0x18(%ebx),%eax
80103f95:	8b 4b 7c             	mov    0x7c(%ebx),%ecx
80103f98:	89 48 38             	mov    %ecx,0x38(%eax)
          proc->h=h+1;
80103f9b:	89 93 70 01 00 00    	mov    %edx,0x170(%ebx)
          proc->size=proc->size-1; // free the cstackframe
80103fa1:	83 ab cc 00 00 00 01 	subl   $0x1,0xcc(%ebx)
80103fa8:	e9 41 ff ff ff       	jmp    80103eee <checkSignals+0x2e>
80103fad:	8d 76 00             	lea    0x0(%esi),%esi

80103fb0 <sched>:
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	56                   	push   %esi
80103fb4:	53                   	push   %ebx
  pushcli();
80103fb5:	e8 26 0a 00 00       	call   801049e0 <pushcli>
  c = mycpu();
80103fba:	e8 01 fb ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80103fbf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fc5:	e8 56 0a 00 00       	call   80104a20 <popcli>
  if(!holding(&ptable.lock))
80103fca:	83 ec 0c             	sub    $0xc,%esp
80103fcd:	68 e0 d2 12 80       	push   $0x8012d2e0
80103fd2:	e8 a9 0a 00 00       	call   80104a80 <holding>
80103fd7:	83 c4 10             	add    $0x10,%esp
80103fda:	85 c0                	test   %eax,%eax
80103fdc:	74 4f                	je     8010402d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103fde:	e8 dd fa ff ff       	call   80103ac0 <mycpu>
80103fe3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103fea:	75 68                	jne    80104054 <sched+0xa4>
  if(p->state == RUNNING)
80103fec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103ff0:	74 55                	je     80104047 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ff2:	9c                   	pushf  
80103ff3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ff4:	f6 c4 02             	test   $0x2,%ah
80103ff7:	75 41                	jne    8010403a <sched+0x8a>
  intena = mycpu()->intena;
80103ff9:	e8 c2 fa ff ff       	call   80103ac0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103ffe:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104001:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104007:	e8 b4 fa ff ff       	call   80103ac0 <mycpu>
8010400c:	83 ec 08             	sub    $0x8,%esp
8010400f:	ff 70 04             	pushl  0x4(%eax)
80104012:	53                   	push   %ebx
80104013:	e8 e3 0d 00 00       	call   80104dfb <swtch>
  mycpu()->intena = intena;
80104018:	e8 a3 fa ff ff       	call   80103ac0 <mycpu>
}
8010401d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104020:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104026:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104029:	5b                   	pop    %ebx
8010402a:	5e                   	pop    %esi
8010402b:	5d                   	pop    %ebp
8010402c:	c3                   	ret    
    panic("sched ptable.lock");
8010402d:	83 ec 0c             	sub    $0xc,%esp
80104030:	68 05 7d 10 80       	push   $0x80107d05
80104035:	e8 56 c3 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010403a:	83 ec 0c             	sub    $0xc,%esp
8010403d:	68 31 7d 10 80       	push   $0x80107d31
80104042:	e8 49 c3 ff ff       	call   80100390 <panic>
    panic("sched running");
80104047:	83 ec 0c             	sub    $0xc,%esp
8010404a:	68 23 7d 10 80       	push   $0x80107d23
8010404f:	e8 3c c3 ff ff       	call   80100390 <panic>
    panic("sched locks");
80104054:	83 ec 0c             	sub    $0xc,%esp
80104057:	68 17 7d 10 80       	push   $0x80107d17
8010405c:	e8 2f c3 ff ff       	call   80100390 <panic>
80104061:	eb 0d                	jmp    80104070 <recv>
80104063:	90                   	nop
80104064:	90                   	nop
80104065:	90                   	nop
80104066:	90                   	nop
80104067:	90                   	nop
80104068:	90                   	nop
80104069:	90                   	nop
8010406a:	90                   	nop
8010406b:	90                   	nop
8010406c:	90                   	nop
8010406d:	90                   	nop
8010406e:	90                   	nop
8010406f:	90                   	nop

80104070 <recv>:
{
80104070:	55                   	push   %ebp
80104071:	89 e5                	mov    %esp,%ebp
80104073:	57                   	push   %edi
80104074:	56                   	push   %esi
80104075:	53                   	push   %ebx
80104076:	83 ec 28             	sub    $0x28,%esp
  acquire(&ptable.lock);
80104079:	68 e0 d2 12 80       	push   $0x8012d2e0
8010407e:	e8 2d 0a 00 00       	call   80104ab0 <acquire>
  pushcli();
80104083:	e8 58 09 00 00       	call   801049e0 <pushcli>
  c = mycpu();
80104088:	e8 33 fa ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
8010408d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104093:	e8 88 09 00 00       	call   80104a20 <popcli>
  if(argstr(0,&msg) < 0) {return -1;}
80104098:	5a                   	pop    %edx
  int rec_pid = myproc()->pid;
80104099:	8b 73 10             	mov    0x10(%ebx),%esi
  if(argstr(0,&msg) < 0) {return -1;}
8010409c:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
8010409f:	59                   	pop    %ecx
801040a0:	53                   	push   %ebx
801040a1:	6a 00                	push   $0x0
801040a3:	e8 c8 0e 00 00       	call   80104f70 <argstr>
801040a8:	83 c4 10             	add    $0x10,%esp
801040ab:	85 c0                	test   %eax,%eax
801040ad:	0f 88 d7 00 00 00    	js     8010418a <recv+0x11a>
  argstr(0,&msg);
801040b3:	83 ec 08             	sub    $0x8,%esp
801040b6:	53                   	push   %ebx
801040b7:	6a 00                	push   $0x0
  int idx=0;
801040b9:	31 db                	xor    %ebx,%ebx
  argstr(0,&msg);
801040bb:	e8 b0 0e 00 00       	call   80104f70 <argstr>
801040c0:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++,idx++)
801040c3:	b8 14 d3 12 80       	mov    $0x8012d314,%eax
801040c8:	eb 15                	jmp    801040df <recv+0x6f>
801040ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801040d0:	05 78 01 00 00       	add    $0x178,%eax
801040d5:	83 c3 01             	add    $0x1,%ebx
801040d8:	3d 14 31 13 80       	cmp    $0x80133114,%eax
801040dd:	73 05                	jae    801040e4 <recv+0x74>
    if(p->pid ==rec_pid)
801040df:	39 70 10             	cmp    %esi,0x10(%eax)
801040e2:	75 ec                	jne    801040d0 <recv+0x60>
  if(process_Qs[idx].size <= 0){
801040e4:	69 c3 4c 06 00 00    	imul   $0x64c,%ebx,%eax
801040ea:	8b 80 28 46 11 80    	mov    -0x7feeb9d8(%eax),%eax
801040f0:	85 c0                	test   %eax,%eax
801040f2:	7e 7c                	jle    80104170 <recv+0x100>
  int h = process_Qs[idx].h;
801040f4:	69 c3 4c 06 00 00    	imul   $0x64c,%ebx,%eax
801040fa:	8b b0 20 46 11 80    	mov    -0x7feeb9e0(%eax),%esi
  if(h==50)
80104100:	83 fe 32             	cmp    $0x32,%esi
80104103:	8d 4e 01             	lea    0x1(%esi),%ecx
80104106:	75 07                	jne    8010410f <recv+0x9f>
80104108:	b9 01 00 00 00       	mov    $0x1,%ecx
    h=0;
8010410d:	31 f6                	xor    %esi,%esi
8010410f:	69 c3 4c 06 00 00    	imul   $0x64c,%ebx,%eax
80104115:	c1 e6 05             	shl    $0x5,%esi
80104118:	01 c6                	add    %eax,%esi
  for(int i = 0;i < MSG_SIZE; i++){
8010411a:	31 c0                	xor    %eax,%eax
8010411c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *(msg + i) =  process_Qs[idx].mq[h][i]; 
80104120:	8b 94 86 e0 3f 11 80 	mov    -0x7feec020(%esi,%eax,4),%edx
80104127:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010412a:	88 14 07             	mov    %dl,(%edi,%eax,1)
  for(int i = 0;i < MSG_SIZE; i++){
8010412d:	83 c0 01             	add    $0x1,%eax
80104130:	83 f8 08             	cmp    $0x8,%eax
80104133:	75 eb                	jne    80104120 <recv+0xb0>
  process_Qs[idx].h=h+1;
80104135:	69 db 4c 06 00 00    	imul   $0x64c,%ebx,%ebx
  release(&ptable.lock);
8010413b:	83 ec 0c             	sub    $0xc,%esp
  process_Qs[idx].h=h+1;
8010413e:	89 8b 20 46 11 80    	mov    %ecx,-0x7feeb9e0(%ebx)
80104144:	81 c3 e0 3f 11 80    	add    $0x80113fe0,%ebx
  process_Qs[idx].size =process_Qs[idx].size- 1;
8010414a:	83 ab 48 06 00 00 01 	subl   $0x1,0x648(%ebx)
  release(&ptable.lock);
80104151:	68 e0 d2 12 80       	push   $0x8012d2e0
80104156:	e8 15 0a 00 00       	call   80104b70 <release>
  return 0;
8010415b:	83 c4 10             	add    $0x10,%esp
8010415e:	31 c0                	xor    %eax,%eax
}
80104160:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104163:	5b                   	pop    %ebx
80104164:	5e                   	pop    %esi
80104165:	5f                   	pop    %edi
80104166:	5d                   	pop    %ebp
80104167:	c3                   	ret    
80104168:	90                   	nop
80104169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->state=SLEEPING;
80104170:	69 c3 78 01 00 00    	imul   $0x178,%ebx,%eax
80104176:	c7 80 20 d3 12 80 02 	movl   $0x2,-0x7fed2ce0(%eax)
8010417d:	00 00 00 
    sched();
80104180:	e8 2b fe ff ff       	call   80103fb0 <sched>
80104185:	e9 6a ff ff ff       	jmp    801040f4 <recv+0x84>
  if(argstr(0,&msg) < 0) {return -1;}
8010418a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010418f:	eb cf                	jmp    80104160 <recv+0xf0>
80104191:	eb 0d                	jmp    801041a0 <exit>
80104193:	90                   	nop
80104194:	90                   	nop
80104195:	90                   	nop
80104196:	90                   	nop
80104197:	90                   	nop
80104198:	90                   	nop
80104199:	90                   	nop
8010419a:	90                   	nop
8010419b:	90                   	nop
8010419c:	90                   	nop
8010419d:	90                   	nop
8010419e:	90                   	nop
8010419f:	90                   	nop

801041a0 <exit>:
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	57                   	push   %edi
801041a4:	56                   	push   %esi
801041a5:	53                   	push   %ebx
801041a6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801041a9:	e8 32 08 00 00       	call   801049e0 <pushcli>
  c = mycpu();
801041ae:	e8 0d f9 ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
801041b3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801041b9:	e8 62 08 00 00       	call   80104a20 <popcli>
  if(curproc == initproc)
801041be:	39 35 5c b8 10 80    	cmp    %esi,0x8010b85c
801041c4:	8d 5e 28             	lea    0x28(%esi),%ebx
801041c7:	8d 7e 68             	lea    0x68(%esi),%edi
801041ca:	0f 84 f1 00 00 00    	je     801042c1 <exit+0x121>
    if(curproc->ofile[fd]){
801041d0:	8b 03                	mov    (%ebx),%eax
801041d2:	85 c0                	test   %eax,%eax
801041d4:	74 12                	je     801041e8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
801041d6:	83 ec 0c             	sub    $0xc,%esp
801041d9:	50                   	push   %eax
801041da:	e8 61 cc ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
801041df:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801041e5:	83 c4 10             	add    $0x10,%esp
801041e8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
801041eb:	39 fb                	cmp    %edi,%ebx
801041ed:	75 e1                	jne    801041d0 <exit+0x30>
  begin_op();
801041ef:	e8 bc e9 ff ff       	call   80102bb0 <begin_op>
  iput(curproc->cwd);
801041f4:	83 ec 0c             	sub    $0xc,%esp
801041f7:	ff 76 68             	pushl  0x68(%esi)
801041fa:	e8 c1 d5 ff ff       	call   801017c0 <iput>
  end_op();
801041ff:	e8 1c ea ff ff       	call   80102c20 <end_op>
  curproc->cwd = 0;
80104204:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010420b:	c7 04 24 e0 d2 12 80 	movl   $0x8012d2e0,(%esp)
80104212:	e8 99 08 00 00       	call   80104ab0 <acquire>
  wakeup1(curproc->parent);
80104217:	8b 56 14             	mov    0x14(%esi),%edx
8010421a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010421d:	b8 14 d3 12 80       	mov    $0x8012d314,%eax
80104222:	eb 10                	jmp    80104234 <exit+0x94>
80104224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104228:	05 78 01 00 00       	add    $0x178,%eax
8010422d:	3d 14 31 13 80       	cmp    $0x80133114,%eax
80104232:	73 1e                	jae    80104252 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80104234:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104238:	75 ee                	jne    80104228 <exit+0x88>
8010423a:	3b 50 20             	cmp    0x20(%eax),%edx
8010423d:	75 e9                	jne    80104228 <exit+0x88>
      p->state = RUNNABLE;
8010423f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104246:	05 78 01 00 00       	add    $0x178,%eax
8010424b:	3d 14 31 13 80       	cmp    $0x80133114,%eax
80104250:	72 e2                	jb     80104234 <exit+0x94>
      p->parent = initproc;
80104252:	8b 0d 5c b8 10 80    	mov    0x8010b85c,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104258:	ba 14 d3 12 80       	mov    $0x8012d314,%edx
8010425d:	eb 0f                	jmp    8010426e <exit+0xce>
8010425f:	90                   	nop
80104260:	81 c2 78 01 00 00    	add    $0x178,%edx
80104266:	81 fa 14 31 13 80    	cmp    $0x80133114,%edx
8010426c:	73 3a                	jae    801042a8 <exit+0x108>
    if(p->parent == curproc){
8010426e:	39 72 14             	cmp    %esi,0x14(%edx)
80104271:	75 ed                	jne    80104260 <exit+0xc0>
      if(p->state == ZOMBIE)
80104273:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104277:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010427a:	75 e4                	jne    80104260 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010427c:	b8 14 d3 12 80       	mov    $0x8012d314,%eax
80104281:	eb 11                	jmp    80104294 <exit+0xf4>
80104283:	90                   	nop
80104284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104288:	05 78 01 00 00       	add    $0x178,%eax
8010428d:	3d 14 31 13 80       	cmp    $0x80133114,%eax
80104292:	73 cc                	jae    80104260 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104294:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104298:	75 ee                	jne    80104288 <exit+0xe8>
8010429a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010429d:	75 e9                	jne    80104288 <exit+0xe8>
      p->state = RUNNABLE;
8010429f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801042a6:	eb e0                	jmp    80104288 <exit+0xe8>
  curproc->state = ZOMBIE;
801042a8:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801042af:	e8 fc fc ff ff       	call   80103fb0 <sched>
  panic("zombie exit");
801042b4:	83 ec 0c             	sub    $0xc,%esp
801042b7:	68 52 7d 10 80       	push   $0x80107d52
801042bc:	e8 cf c0 ff ff       	call   80100390 <panic>
    panic("init exiting");
801042c1:	83 ec 0c             	sub    $0xc,%esp
801042c4:	68 45 7d 10 80       	push   $0x80107d45
801042c9:	e8 c2 c0 ff ff       	call   80100390 <panic>
801042ce:	66 90                	xchg   %ax,%ax

801042d0 <yield>:
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	53                   	push   %ebx
801042d4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801042d7:	68 e0 d2 12 80       	push   $0x8012d2e0
801042dc:	e8 cf 07 00 00       	call   80104ab0 <acquire>
  pushcli();
801042e1:	e8 fa 06 00 00       	call   801049e0 <pushcli>
  c = mycpu();
801042e6:	e8 d5 f7 ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
801042eb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042f1:	e8 2a 07 00 00       	call   80104a20 <popcli>
  myproc()->state = RUNNABLE;
801042f6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801042fd:	e8 ae fc ff ff       	call   80103fb0 <sched>
  release(&ptable.lock);
80104302:	c7 04 24 e0 d2 12 80 	movl   $0x8012d2e0,(%esp)
80104309:	e8 62 08 00 00       	call   80104b70 <release>
}
8010430e:	83 c4 10             	add    $0x10,%esp
80104311:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104314:	c9                   	leave  
80104315:	c3                   	ret    
80104316:	8d 76 00             	lea    0x0(%esi),%esi
80104319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104320 <sleep>:
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	57                   	push   %edi
80104324:	56                   	push   %esi
80104325:	53                   	push   %ebx
80104326:	83 ec 0c             	sub    $0xc,%esp
80104329:	8b 7d 08             	mov    0x8(%ebp),%edi
8010432c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010432f:	e8 ac 06 00 00       	call   801049e0 <pushcli>
  c = mycpu();
80104334:	e8 87 f7 ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80104339:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010433f:	e8 dc 06 00 00       	call   80104a20 <popcli>
  if(p == 0)
80104344:	85 db                	test   %ebx,%ebx
80104346:	0f 84 87 00 00 00    	je     801043d3 <sleep+0xb3>
  if(lk == 0)
8010434c:	85 f6                	test   %esi,%esi
8010434e:	74 76                	je     801043c6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104350:	81 fe e0 d2 12 80    	cmp    $0x8012d2e0,%esi
80104356:	74 50                	je     801043a8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104358:	83 ec 0c             	sub    $0xc,%esp
8010435b:	68 e0 d2 12 80       	push   $0x8012d2e0
80104360:	e8 4b 07 00 00       	call   80104ab0 <acquire>
    release(lk);
80104365:	89 34 24             	mov    %esi,(%esp)
80104368:	e8 03 08 00 00       	call   80104b70 <release>
  p->chan = chan;
8010436d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104370:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104377:	e8 34 fc ff ff       	call   80103fb0 <sched>
  p->chan = 0;
8010437c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104383:	c7 04 24 e0 d2 12 80 	movl   $0x8012d2e0,(%esp)
8010438a:	e8 e1 07 00 00       	call   80104b70 <release>
    acquire(lk);
8010438f:	89 75 08             	mov    %esi,0x8(%ebp)
80104392:	83 c4 10             	add    $0x10,%esp
}
80104395:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104398:	5b                   	pop    %ebx
80104399:	5e                   	pop    %esi
8010439a:	5f                   	pop    %edi
8010439b:	5d                   	pop    %ebp
    acquire(lk);
8010439c:	e9 0f 07 00 00       	jmp    80104ab0 <acquire>
801043a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801043a8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801043ab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801043b2:	e8 f9 fb ff ff       	call   80103fb0 <sched>
  p->chan = 0;
801043b7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801043be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043c1:	5b                   	pop    %ebx
801043c2:	5e                   	pop    %esi
801043c3:	5f                   	pop    %edi
801043c4:	5d                   	pop    %ebp
801043c5:	c3                   	ret    
    panic("sleep without lk");
801043c6:	83 ec 0c             	sub    $0xc,%esp
801043c9:	68 64 7d 10 80       	push   $0x80107d64
801043ce:	e8 bd bf ff ff       	call   80100390 <panic>
    panic("sleep");
801043d3:	83 ec 0c             	sub    $0xc,%esp
801043d6:	68 5e 7d 10 80       	push   $0x80107d5e
801043db:	e8 b0 bf ff ff       	call   80100390 <panic>

801043e0 <wait>:
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
  pushcli();
801043e5:	e8 f6 05 00 00       	call   801049e0 <pushcli>
  c = mycpu();
801043ea:	e8 d1 f6 ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
801043ef:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801043f5:	e8 26 06 00 00       	call   80104a20 <popcli>
  acquire(&ptable.lock);
801043fa:	83 ec 0c             	sub    $0xc,%esp
801043fd:	68 e0 d2 12 80       	push   $0x8012d2e0
80104402:	e8 a9 06 00 00       	call   80104ab0 <acquire>
80104407:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010440a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010440c:	bb 14 d3 12 80       	mov    $0x8012d314,%ebx
80104411:	eb 13                	jmp    80104426 <wait+0x46>
80104413:	90                   	nop
80104414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104418:	81 c3 78 01 00 00    	add    $0x178,%ebx
8010441e:	81 fb 14 31 13 80    	cmp    $0x80133114,%ebx
80104424:	73 1e                	jae    80104444 <wait+0x64>
      if(p->parent != curproc)
80104426:	39 73 14             	cmp    %esi,0x14(%ebx)
80104429:	75 ed                	jne    80104418 <wait+0x38>
      if(p->state == ZOMBIE){
8010442b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010442f:	74 37                	je     80104468 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104431:	81 c3 78 01 00 00    	add    $0x178,%ebx
      havekids = 1;
80104437:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010443c:	81 fb 14 31 13 80    	cmp    $0x80133114,%ebx
80104442:	72 e2                	jb     80104426 <wait+0x46>
    if(!havekids || curproc->killed){
80104444:	85 c0                	test   %eax,%eax
80104446:	74 76                	je     801044be <wait+0xde>
80104448:	8b 46 24             	mov    0x24(%esi),%eax
8010444b:	85 c0                	test   %eax,%eax
8010444d:	75 6f                	jne    801044be <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010444f:	83 ec 08             	sub    $0x8,%esp
80104452:	68 e0 d2 12 80       	push   $0x8012d2e0
80104457:	56                   	push   %esi
80104458:	e8 c3 fe ff ff       	call   80104320 <sleep>
    havekids = 0;
8010445d:	83 c4 10             	add    $0x10,%esp
80104460:	eb a8                	jmp    8010440a <wait+0x2a>
80104462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104468:	83 ec 0c             	sub    $0xc,%esp
8010446b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010446e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104471:	e8 aa de ff ff       	call   80102320 <kfree>
        freevm(p->pgdir);
80104476:	5a                   	pop    %edx
80104477:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010447a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104481:	e8 9a 2f 00 00       	call   80107420 <freevm>
        release(&ptable.lock);
80104486:	c7 04 24 e0 d2 12 80 	movl   $0x8012d2e0,(%esp)
        p->pid = 0;
8010448d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104494:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010449b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010449f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801044a6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801044ad:	e8 be 06 00 00       	call   80104b70 <release>
        return pid;
801044b2:	83 c4 10             	add    $0x10,%esp
}
801044b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044b8:	89 f0                	mov    %esi,%eax
801044ba:	5b                   	pop    %ebx
801044bb:	5e                   	pop    %esi
801044bc:	5d                   	pop    %ebp
801044bd:	c3                   	ret    
      release(&ptable.lock);
801044be:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801044c1:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801044c6:	68 e0 d2 12 80       	push   $0x8012d2e0
801044cb:	e8 a0 06 00 00       	call   80104b70 <release>
      return -1;
801044d0:	83 c4 10             	add    $0x10,%esp
801044d3:	eb e0                	jmp    801044b5 <wait+0xd5>
801044d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044e0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	53                   	push   %ebx
801044e4:	83 ec 10             	sub    $0x10,%esp
801044e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801044ea:	68 e0 d2 12 80       	push   $0x8012d2e0
801044ef:	e8 bc 05 00 00       	call   80104ab0 <acquire>
801044f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044f7:	b8 14 d3 12 80       	mov    $0x8012d314,%eax
801044fc:	eb 0e                	jmp    8010450c <wakeup+0x2c>
801044fe:	66 90                	xchg   %ax,%ax
80104500:	05 78 01 00 00       	add    $0x178,%eax
80104505:	3d 14 31 13 80       	cmp    $0x80133114,%eax
8010450a:	73 1e                	jae    8010452a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010450c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104510:	75 ee                	jne    80104500 <wakeup+0x20>
80104512:	3b 58 20             	cmp    0x20(%eax),%ebx
80104515:	75 e9                	jne    80104500 <wakeup+0x20>
      p->state = RUNNABLE;
80104517:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010451e:	05 78 01 00 00       	add    $0x178,%eax
80104523:	3d 14 31 13 80       	cmp    $0x80133114,%eax
80104528:	72 e2                	jb     8010450c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010452a:	c7 45 08 e0 d2 12 80 	movl   $0x8012d2e0,0x8(%ebp)
}
80104531:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104534:	c9                   	leave  
  release(&ptable.lock);
80104535:	e9 36 06 00 00       	jmp    80104b70 <release>
8010453a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104540 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
80104544:	83 ec 10             	sub    $0x10,%esp
80104547:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010454a:	68 e0 d2 12 80       	push   $0x8012d2e0
8010454f:	e8 5c 05 00 00       	call   80104ab0 <acquire>
80104554:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104557:	b8 14 d3 12 80       	mov    $0x8012d314,%eax
8010455c:	eb 0e                	jmp    8010456c <kill+0x2c>
8010455e:	66 90                	xchg   %ax,%ax
80104560:	05 78 01 00 00       	add    $0x178,%eax
80104565:	3d 14 31 13 80       	cmp    $0x80133114,%eax
8010456a:	73 34                	jae    801045a0 <kill+0x60>
    if(p->pid == pid){
8010456c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010456f:	75 ef                	jne    80104560 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104571:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104575:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010457c:	75 07                	jne    80104585 <kill+0x45>
        p->state = RUNNABLE;
8010457e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104585:	83 ec 0c             	sub    $0xc,%esp
80104588:	68 e0 d2 12 80       	push   $0x8012d2e0
8010458d:	e8 de 05 00 00       	call   80104b70 <release>
      return 0;
80104592:	83 c4 10             	add    $0x10,%esp
80104595:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104597:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010459a:	c9                   	leave  
8010459b:	c3                   	ret    
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801045a0:	83 ec 0c             	sub    $0xc,%esp
801045a3:	68 e0 d2 12 80       	push   $0x8012d2e0
801045a8:	e8 c3 05 00 00       	call   80104b70 <release>
  return -1;
801045ad:	83 c4 10             	add    $0x10,%esp
801045b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801045b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045b8:	c9                   	leave  
801045b9:	c3                   	ret    
801045ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045c0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	57                   	push   %edi
801045c4:	56                   	push   %esi
801045c5:	53                   	push   %ebx
801045c6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045c9:	bb 14 d3 12 80       	mov    $0x8012d314,%ebx
{
801045ce:	83 ec 3c             	sub    $0x3c,%esp
801045d1:	eb 27                	jmp    801045fa <procdump+0x3a>
801045d3:	90                   	nop
801045d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801045d8:	83 ec 0c             	sub    $0xc,%esp
801045db:	68 43 81 10 80       	push   $0x80108143
801045e0:	e8 7b c0 ff ff       	call   80100660 <cprintf>
801045e5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045e8:	81 c3 78 01 00 00    	add    $0x178,%ebx
801045ee:	81 fb 14 31 13 80    	cmp    $0x80133114,%ebx
801045f4:	0f 83 86 00 00 00    	jae    80104680 <procdump+0xc0>
    if(p->state == UNUSED)
801045fa:	8b 43 0c             	mov    0xc(%ebx),%eax
801045fd:	85 c0                	test   %eax,%eax
801045ff:	74 e7                	je     801045e8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104601:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104604:	ba 75 7d 10 80       	mov    $0x80107d75,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104609:	77 11                	ja     8010461c <procdump+0x5c>
8010460b:	8b 14 85 f8 7d 10 80 	mov    -0x7fef8208(,%eax,4),%edx
      state = "???";
80104612:	b8 75 7d 10 80       	mov    $0x80107d75,%eax
80104617:	85 d2                	test   %edx,%edx
80104619:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010461c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010461f:	50                   	push   %eax
80104620:	52                   	push   %edx
80104621:	ff 73 10             	pushl  0x10(%ebx)
80104624:	68 79 7d 10 80       	push   $0x80107d79
80104629:	e8 32 c0 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010462e:	83 c4 10             	add    $0x10,%esp
80104631:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104635:	75 a1                	jne    801045d8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104637:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010463a:	83 ec 08             	sub    $0x8,%esp
8010463d:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104640:	50                   	push   %eax
80104641:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104644:	8b 40 0c             	mov    0xc(%eax),%eax
80104647:	83 c0 08             	add    $0x8,%eax
8010464a:	50                   	push   %eax
8010464b:	e8 40 03 00 00       	call   80104990 <getcallerpcs>
80104650:	83 c4 10             	add    $0x10,%esp
80104653:	90                   	nop
80104654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104658:	8b 17                	mov    (%edi),%edx
8010465a:	85 d2                	test   %edx,%edx
8010465c:	0f 84 76 ff ff ff    	je     801045d8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104662:	83 ec 08             	sub    $0x8,%esp
80104665:	83 c7 04             	add    $0x4,%edi
80104668:	52                   	push   %edx
80104669:	68 81 77 10 80       	push   $0x80107781
8010466e:	e8 ed bf ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104673:	83 c4 10             	add    $0x10,%esp
80104676:	39 fe                	cmp    %edi,%esi
80104678:	75 de                	jne    80104658 <procdump+0x98>
8010467a:	e9 59 ff ff ff       	jmp    801045d8 <procdump+0x18>
8010467f:	90                   	nop
  }
}
80104680:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104683:	5b                   	pop    %ebx
80104684:	5e                   	pop    %esi
80104685:	5f                   	pop    %edi
80104686:	5d                   	pop    %ebp
80104687:	c3                   	ret    
80104688:	90                   	nop
80104689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104690 <sigset>:

sig_handler sigset(sig_handler new_sig_handler) {
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	53                   	push   %ebx
80104694:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104697:	e8 44 03 00 00       	call   801049e0 <pushcli>
  c = mycpu();
8010469c:	e8 1f f4 ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
801046a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046a7:	e8 74 03 00 00       	call   80104a20 <popcli>
  struct proc *curproc = myproc();
  sig_handler old_sig_handler = curproc->sighandler;
  curproc->sighandler = new_sig_handler;
801046ac:	8b 55 08             	mov    0x8(%ebp),%edx
  sig_handler old_sig_handler = curproc->sighandler;
801046af:	8b 43 7c             	mov    0x7c(%ebx),%eax
  curproc->sighandler = new_sig_handler;
801046b2:	89 53 7c             	mov    %edx,0x7c(%ebx)
  return old_sig_handler;
}
801046b5:	83 c4 04             	add    $0x4,%esp
801046b8:	5b                   	pop    %ebx
801046b9:	5d                   	pop    %ebp
801046ba:	c3                   	ret    
801046bb:	90                   	nop
801046bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046c0 <sigsend>:

int sigsend(int dest_pid, int msg) {
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	57                   	push   %edi
801046c4:	56                   	push   %esi
801046c5:	53                   	push   %ebx
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046c6:	bb 14 d3 12 80       	mov    $0x8012d314,%ebx
int sigsend(int dest_pid, int msg) {
801046cb:	83 ec 0c             	sub    $0xc,%esp
801046ce:	8b 45 08             	mov    0x8(%ebp),%eax
801046d1:	8b 75 0c             	mov    0xc(%ebp),%esi
801046d4:	eb 18                	jmp    801046ee <sigsend+0x2e>
801046d6:	8d 76 00             	lea    0x0(%esi),%esi
801046d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046e0:	81 c3 78 01 00 00    	add    $0x178,%ebx
801046e6:	81 fb 14 31 13 80    	cmp    $0x80133114,%ebx
801046ec:	73 72                	jae    80104760 <sigsend+0xa0>
    if (p->pid == dest_pid)
801046ee:	39 43 10             	cmp    %eax,0x10(%ebx)
801046f1:	75 ed                	jne    801046e0 <sigsend+0x20>
      goto sigsend_dest_pid_found;
  }
  return -1; // dest_pid wan't found, meaning it's not a valid pid. return error
sigsend_dest_pid_found:
  acquire(&ptable.lock);
801046f3:	83 ec 0c             	sub    $0xc,%esp
801046f6:	68 e0 d2 12 80       	push   $0x8012d2e0
801046fb:	e8 b0 03 00 00       	call   80104ab0 <acquire>
  if(p->size==20)
80104700:	8b 83 cc 00 00 00    	mov    0xcc(%ebx),%eax
80104706:	83 c4 10             	add    $0x10,%esp
80104709:	83 f8 14             	cmp    $0x14,%eax
8010470c:	74 52                	je     80104760 <sigsend+0xa0>
    return -1; // pending signal stack is full. return error
  int t=p->t;
8010470e:	8b 93 74 01 00 00    	mov    0x174(%ebx),%edx
  if(t==20)
80104714:	83 fa 14             	cmp    $0x14,%edx
80104717:	8d 4a 01             	lea    0x1(%edx),%ecx
8010471a:	75 07                	jne    80104723 <sigsend+0x63>
8010471c:	b9 01 00 00 00       	mov    $0x1,%ecx
    t=0;
80104721:	31 d2                	xor    %edx,%edx
  int* message=(int*) msg;
  p->signal_arr[t][0]=*message;
80104723:	8b 3e                	mov    (%esi),%edi
  p->signal_arr[t][1]=*(message+1);
  p->size=p->size+1;
  p->t=t+1;
  release(&ptable.lock);
80104725:	83 ec 0c             	sub    $0xc,%esp
  p->size=p->size+1;
80104728:	83 c0 01             	add    $0x1,%eax
  p->signal_arr[t][0]=*message;
8010472b:	89 bc d3 d0 00 00 00 	mov    %edi,0xd0(%ebx,%edx,8)
  p->signal_arr[t][1]=*(message+1);
80104732:	8b 76 04             	mov    0x4(%esi),%esi
  release(&ptable.lock);
80104735:	68 e0 d2 12 80       	push   $0x8012d2e0
  p->signal_arr[t][1]=*(message+1);
8010473a:	89 b4 d3 d4 00 00 00 	mov    %esi,0xd4(%ebx,%edx,8)
  p->size=p->size+1;
80104741:	89 83 cc 00 00 00    	mov    %eax,0xcc(%ebx)
  p->t=t+1;
80104747:	89 8b 74 01 00 00    	mov    %ecx,0x174(%ebx)
  release(&ptable.lock);
8010474d:	e8 1e 04 00 00       	call   80104b70 <release>
  // cprintf("p->size=%d\n",p->size);
  return 0; // successful execution
80104752:	83 c4 10             	add    $0x10,%esp
}
80104755:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0; // successful execution
80104758:	31 c0                	xor    %eax,%eax
}
8010475a:	5b                   	pop    %ebx
8010475b:	5e                   	pop    %esi
8010475c:	5f                   	pop    %edi
8010475d:	5d                   	pop    %ebp
8010475e:	c3                   	ret    
8010475f:	90                   	nop
80104760:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1; // dest_pid wan't found, meaning it's not a valid pid. return error
80104763:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104768:	5b                   	pop    %ebx
80104769:	5e                   	pop    %esi
8010476a:	5f                   	pop    %edi
8010476b:	5d                   	pop    %ebp
8010476c:	c3                   	ret    
8010476d:	8d 76 00             	lea    0x0(%esi),%esi

80104770 <sigret>:

void sigret(void) {
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	53                   	push   %ebx
80104774:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104777:	e8 64 02 00 00       	call   801049e0 <pushcli>
  c = mycpu();
8010477c:	e8 3f f3 ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80104781:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104787:	e8 94 02 00 00       	call   80104a20 <popcli>
  struct proc *proc = myproc();
  memmove(proc->tf, &proc->oldTf, sizeof(struct trapframe));
8010478c:	83 ec 04             	sub    $0x4,%esp
8010478f:	8d 83 80 00 00 00    	lea    0x80(%ebx),%eax
80104795:	6a 4c                	push   $0x4c
80104797:	50                   	push   %eax
80104798:	ff 73 18             	pushl  0x18(%ebx)
8010479b:	e8 d0 04 00 00       	call   80104c70 <memmove>
  // cprintf("return called");
}
801047a0:	83 c4 10             	add    $0x10,%esp
801047a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047a6:	c9                   	leave  
801047a7:	c3                   	ret    
801047a8:	90                   	nop
801047a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047b0 <sigpause>:

void sigpause(void) {
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	53                   	push   %ebx
801047b4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801047b7:	68 e0 d2 12 80       	push   $0x8012d2e0
801047bc:	e8 ef 02 00 00       	call   80104ab0 <acquire>
  pushcli();
801047c1:	e8 1a 02 00 00       	call   801049e0 <pushcli>
  c = mycpu();
801047c6:	e8 f5 f2 ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
801047cb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047d1:	e8 4a 02 00 00       	call   80104a20 <popcli>
  int rec_pid = myproc()->pid;
801047d6:	83 c4 10             	add    $0x10,%esp
  struct proc *p;
  int idx=0;
801047d9:	31 d2                	xor    %edx,%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++,idx++)
801047db:	b8 14 d3 12 80       	mov    $0x8012d314,%eax
  int rec_pid = myproc()->pid;
801047e0:	8b 4b 10             	mov    0x10(%ebx),%ecx
801047e3:	eb 12                	jmp    801047f7 <sigpause+0x47>
801047e5:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++,idx++)
801047e8:	05 78 01 00 00       	add    $0x178,%eax
801047ed:	83 c2 01             	add    $0x1,%edx
801047f0:	3d 14 31 13 80       	cmp    $0x80133114,%eax
801047f5:	73 05                	jae    801047fc <sigpause+0x4c>
  {
    if(p->pid ==rec_pid)
801047f7:	39 48 10             	cmp    %ecx,0x10(%eax)
801047fa:	75 ec                	jne    801047e8 <sigpause+0x38>
      break;
  }
  cprintf("Qsize=%d and head=%d and tail=%d\n",process_Qs[idx].size,process_Qs[idx].h,process_Qs[idx].t);
801047fc:	69 d2 4c 06 00 00    	imul   $0x64c,%edx,%edx
80104802:	ff b2 24 46 11 80    	pushl  -0x7feeb9dc(%edx)
80104808:	ff b2 20 46 11 80    	pushl  -0x7feeb9e0(%edx)
8010480e:	ff b2 28 46 11 80    	pushl  -0x7feeb9d8(%edx)
80104814:	68 d4 7d 10 80       	push   $0x80107dd4
80104819:	e8 42 be ff ff       	call   80100660 <cprintf>
  // // }
  // // else{
  // //   if(!cas(&proc->state, SLEEPING, RUNNING))
  // //     panic("sigpause: cas #2 failed");
  // // }
  release(&ptable.lock);
8010481e:	c7 04 24 e0 d2 12 80 	movl   $0x8012d2e0,(%esp)
80104825:	e8 46 03 00 00       	call   80104b70 <release>
  // popcli();
}
8010482a:	83 c4 10             	add    $0x10,%esp
8010482d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104830:	c9                   	leave  
80104831:	c3                   	ret    
80104832:	66 90                	xchg   %ax,%ax
80104834:	66 90                	xchg   %ax,%ax
80104836:	66 90                	xchg   %ax,%ax
80104838:	66 90                	xchg   %ax,%ax
8010483a:	66 90                	xchg   %ax,%ax
8010483c:	66 90                	xchg   %ax,%ax
8010483e:	66 90                	xchg   %ax,%ax

80104840 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	53                   	push   %ebx
80104844:	83 ec 0c             	sub    $0xc,%esp
80104847:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010484a:	68 10 7e 10 80       	push   $0x80107e10
8010484f:	8d 43 04             	lea    0x4(%ebx),%eax
80104852:	50                   	push   %eax
80104853:	e8 18 01 00 00       	call   80104970 <initlock>
  lk->name = name;
80104858:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010485b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104861:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104864:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010486b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010486e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104871:	c9                   	leave  
80104872:	c3                   	ret    
80104873:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104880 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	56                   	push   %esi
80104884:	53                   	push   %ebx
80104885:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104888:	83 ec 0c             	sub    $0xc,%esp
8010488b:	8d 73 04             	lea    0x4(%ebx),%esi
8010488e:	56                   	push   %esi
8010488f:	e8 1c 02 00 00       	call   80104ab0 <acquire>
  while (lk->locked) {
80104894:	8b 13                	mov    (%ebx),%edx
80104896:	83 c4 10             	add    $0x10,%esp
80104899:	85 d2                	test   %edx,%edx
8010489b:	74 16                	je     801048b3 <acquiresleep+0x33>
8010489d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801048a0:	83 ec 08             	sub    $0x8,%esp
801048a3:	56                   	push   %esi
801048a4:	53                   	push   %ebx
801048a5:	e8 76 fa ff ff       	call   80104320 <sleep>
  while (lk->locked) {
801048aa:	8b 03                	mov    (%ebx),%eax
801048ac:	83 c4 10             	add    $0x10,%esp
801048af:	85 c0                	test   %eax,%eax
801048b1:	75 ed                	jne    801048a0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801048b3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801048b9:	e8 a2 f2 ff ff       	call   80103b60 <myproc>
801048be:	8b 40 10             	mov    0x10(%eax),%eax
801048c1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801048c4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801048c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048ca:	5b                   	pop    %ebx
801048cb:	5e                   	pop    %esi
801048cc:	5d                   	pop    %ebp
  release(&lk->lk);
801048cd:	e9 9e 02 00 00       	jmp    80104b70 <release>
801048d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048e0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	56                   	push   %esi
801048e4:	53                   	push   %ebx
801048e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801048e8:	83 ec 0c             	sub    $0xc,%esp
801048eb:	8d 73 04             	lea    0x4(%ebx),%esi
801048ee:	56                   	push   %esi
801048ef:	e8 bc 01 00 00       	call   80104ab0 <acquire>
  lk->locked = 0;
801048f4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801048fa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104901:	89 1c 24             	mov    %ebx,(%esp)
80104904:	e8 d7 fb ff ff       	call   801044e0 <wakeup>
  release(&lk->lk);
80104909:	89 75 08             	mov    %esi,0x8(%ebp)
8010490c:	83 c4 10             	add    $0x10,%esp
}
8010490f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104912:	5b                   	pop    %ebx
80104913:	5e                   	pop    %esi
80104914:	5d                   	pop    %ebp
  release(&lk->lk);
80104915:	e9 56 02 00 00       	jmp    80104b70 <release>
8010491a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104920 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	57                   	push   %edi
80104924:	56                   	push   %esi
80104925:	53                   	push   %ebx
80104926:	31 ff                	xor    %edi,%edi
80104928:	83 ec 18             	sub    $0x18,%esp
8010492b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010492e:	8d 73 04             	lea    0x4(%ebx),%esi
80104931:	56                   	push   %esi
80104932:	e8 79 01 00 00       	call   80104ab0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104937:	8b 03                	mov    (%ebx),%eax
80104939:	83 c4 10             	add    $0x10,%esp
8010493c:	85 c0                	test   %eax,%eax
8010493e:	74 13                	je     80104953 <holdingsleep+0x33>
80104940:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104943:	e8 18 f2 ff ff       	call   80103b60 <myproc>
80104948:	39 58 10             	cmp    %ebx,0x10(%eax)
8010494b:	0f 94 c0             	sete   %al
8010494e:	0f b6 c0             	movzbl %al,%eax
80104951:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104953:	83 ec 0c             	sub    $0xc,%esp
80104956:	56                   	push   %esi
80104957:	e8 14 02 00 00       	call   80104b70 <release>
  return r;
}
8010495c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010495f:	89 f8                	mov    %edi,%eax
80104961:	5b                   	pop    %ebx
80104962:	5e                   	pop    %esi
80104963:	5f                   	pop    %edi
80104964:	5d                   	pop    %ebp
80104965:	c3                   	ret    
80104966:	66 90                	xchg   %ax,%ax
80104968:	66 90                	xchg   %ax,%ax
8010496a:	66 90                	xchg   %ax,%ax
8010496c:	66 90                	xchg   %ax,%ax
8010496e:	66 90                	xchg   %ax,%ax

80104970 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104976:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104979:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010497f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104982:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104989:	5d                   	pop    %ebp
8010498a:	c3                   	ret    
8010498b:	90                   	nop
8010498c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104990 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104990:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104991:	31 d2                	xor    %edx,%edx
{
80104993:	89 e5                	mov    %esp,%ebp
80104995:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104996:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104999:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010499c:	83 e8 08             	sub    $0x8,%eax
8010499f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801049a0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801049a6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801049ac:	77 1a                	ja     801049c8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801049ae:	8b 58 04             	mov    0x4(%eax),%ebx
801049b1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801049b4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801049b7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801049b9:	83 fa 0a             	cmp    $0xa,%edx
801049bc:	75 e2                	jne    801049a0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801049be:	5b                   	pop    %ebx
801049bf:	5d                   	pop    %ebp
801049c0:	c3                   	ret    
801049c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049c8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801049cb:	83 c1 28             	add    $0x28,%ecx
801049ce:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801049d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801049d6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801049d9:	39 c1                	cmp    %eax,%ecx
801049db:	75 f3                	jne    801049d0 <getcallerpcs+0x40>
}
801049dd:	5b                   	pop    %ebx
801049de:	5d                   	pop    %ebp
801049df:	c3                   	ret    

801049e0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	53                   	push   %ebx
801049e4:	83 ec 04             	sub    $0x4,%esp
801049e7:	9c                   	pushf  
801049e8:	5b                   	pop    %ebx
  asm volatile("cli");
801049e9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801049ea:	e8 d1 f0 ff ff       	call   80103ac0 <mycpu>
801049ef:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801049f5:	85 c0                	test   %eax,%eax
801049f7:	75 11                	jne    80104a0a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801049f9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801049ff:	e8 bc f0 ff ff       	call   80103ac0 <mycpu>
80104a04:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104a0a:	e8 b1 f0 ff ff       	call   80103ac0 <mycpu>
80104a0f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104a16:	83 c4 04             	add    $0x4,%esp
80104a19:	5b                   	pop    %ebx
80104a1a:	5d                   	pop    %ebp
80104a1b:	c3                   	ret    
80104a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a20 <popcli>:

void
popcli(void)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104a26:	9c                   	pushf  
80104a27:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104a28:	f6 c4 02             	test   $0x2,%ah
80104a2b:	75 35                	jne    80104a62 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104a2d:	e8 8e f0 ff ff       	call   80103ac0 <mycpu>
80104a32:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104a39:	78 34                	js     80104a6f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104a3b:	e8 80 f0 ff ff       	call   80103ac0 <mycpu>
80104a40:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104a46:	85 d2                	test   %edx,%edx
80104a48:	74 06                	je     80104a50 <popcli+0x30>
    sti();
}
80104a4a:	c9                   	leave  
80104a4b:	c3                   	ret    
80104a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104a50:	e8 6b f0 ff ff       	call   80103ac0 <mycpu>
80104a55:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104a5b:	85 c0                	test   %eax,%eax
80104a5d:	74 eb                	je     80104a4a <popcli+0x2a>
  asm volatile("sti");
80104a5f:	fb                   	sti    
}
80104a60:	c9                   	leave  
80104a61:	c3                   	ret    
    panic("popcli - interruptible");
80104a62:	83 ec 0c             	sub    $0xc,%esp
80104a65:	68 1b 7e 10 80       	push   $0x80107e1b
80104a6a:	e8 21 b9 ff ff       	call   80100390 <panic>
    panic("popcli");
80104a6f:	83 ec 0c             	sub    $0xc,%esp
80104a72:	68 32 7e 10 80       	push   $0x80107e32
80104a77:	e8 14 b9 ff ff       	call   80100390 <panic>
80104a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a80 <holding>:
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	56                   	push   %esi
80104a84:	53                   	push   %ebx
80104a85:	8b 75 08             	mov    0x8(%ebp),%esi
80104a88:	31 db                	xor    %ebx,%ebx
  pushcli();
80104a8a:	e8 51 ff ff ff       	call   801049e0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104a8f:	8b 06                	mov    (%esi),%eax
80104a91:	85 c0                	test   %eax,%eax
80104a93:	74 10                	je     80104aa5 <holding+0x25>
80104a95:	8b 5e 08             	mov    0x8(%esi),%ebx
80104a98:	e8 23 f0 ff ff       	call   80103ac0 <mycpu>
80104a9d:	39 c3                	cmp    %eax,%ebx
80104a9f:	0f 94 c3             	sete   %bl
80104aa2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104aa5:	e8 76 ff ff ff       	call   80104a20 <popcli>
}
80104aaa:	89 d8                	mov    %ebx,%eax
80104aac:	5b                   	pop    %ebx
80104aad:	5e                   	pop    %esi
80104aae:	5d                   	pop    %ebp
80104aaf:	c3                   	ret    

80104ab0 <acquire>:
{
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	56                   	push   %esi
80104ab4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104ab5:	e8 26 ff ff ff       	call   801049e0 <pushcli>
  if(holding(lk))
80104aba:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104abd:	83 ec 0c             	sub    $0xc,%esp
80104ac0:	53                   	push   %ebx
80104ac1:	e8 ba ff ff ff       	call   80104a80 <holding>
80104ac6:	83 c4 10             	add    $0x10,%esp
80104ac9:	85 c0                	test   %eax,%eax
80104acb:	0f 85 83 00 00 00    	jne    80104b54 <acquire+0xa4>
80104ad1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104ad3:	ba 01 00 00 00       	mov    $0x1,%edx
80104ad8:	eb 09                	jmp    80104ae3 <acquire+0x33>
80104ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ae0:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ae3:	89 d0                	mov    %edx,%eax
80104ae5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104ae8:	85 c0                	test   %eax,%eax
80104aea:	75 f4                	jne    80104ae0 <acquire+0x30>
  __sync_synchronize();
80104aec:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104af1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104af4:	e8 c7 ef ff ff       	call   80103ac0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104af9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80104afc:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104aff:	89 e8                	mov    %ebp,%eax
80104b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b08:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80104b0e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104b14:	77 1a                	ja     80104b30 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104b16:	8b 48 04             	mov    0x4(%eax),%ecx
80104b19:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80104b1c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104b1f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104b21:	83 fe 0a             	cmp    $0xa,%esi
80104b24:	75 e2                	jne    80104b08 <acquire+0x58>
}
80104b26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b29:	5b                   	pop    %ebx
80104b2a:	5e                   	pop    %esi
80104b2b:	5d                   	pop    %ebp
80104b2c:	c3                   	ret    
80104b2d:	8d 76 00             	lea    0x0(%esi),%esi
80104b30:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104b33:	83 c2 28             	add    $0x28,%edx
80104b36:	8d 76 00             	lea    0x0(%esi),%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104b40:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104b46:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104b49:	39 d0                	cmp    %edx,%eax
80104b4b:	75 f3                	jne    80104b40 <acquire+0x90>
}
80104b4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b50:	5b                   	pop    %ebx
80104b51:	5e                   	pop    %esi
80104b52:	5d                   	pop    %ebp
80104b53:	c3                   	ret    
    panic("acquire");
80104b54:	83 ec 0c             	sub    $0xc,%esp
80104b57:	68 39 7e 10 80       	push   $0x80107e39
80104b5c:	e8 2f b8 ff ff       	call   80100390 <panic>
80104b61:	eb 0d                	jmp    80104b70 <release>
80104b63:	90                   	nop
80104b64:	90                   	nop
80104b65:	90                   	nop
80104b66:	90                   	nop
80104b67:	90                   	nop
80104b68:	90                   	nop
80104b69:	90                   	nop
80104b6a:	90                   	nop
80104b6b:	90                   	nop
80104b6c:	90                   	nop
80104b6d:	90                   	nop
80104b6e:	90                   	nop
80104b6f:	90                   	nop

80104b70 <release>:
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	53                   	push   %ebx
80104b74:	83 ec 10             	sub    $0x10,%esp
80104b77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104b7a:	53                   	push   %ebx
80104b7b:	e8 00 ff ff ff       	call   80104a80 <holding>
80104b80:	83 c4 10             	add    $0x10,%esp
80104b83:	85 c0                	test   %eax,%eax
80104b85:	74 22                	je     80104ba9 <release+0x39>
  lk->pcs[0] = 0;
80104b87:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104b8e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104b95:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104b9a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104ba0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ba3:	c9                   	leave  
  popcli();
80104ba4:	e9 77 fe ff ff       	jmp    80104a20 <popcli>
    panic("release");
80104ba9:	83 ec 0c             	sub    $0xc,%esp
80104bac:	68 41 7e 10 80       	push   $0x80107e41
80104bb1:	e8 da b7 ff ff       	call   80100390 <panic>
80104bb6:	66 90                	xchg   %ax,%ax
80104bb8:	66 90                	xchg   %ax,%ax
80104bba:	66 90                	xchg   %ax,%ax
80104bbc:	66 90                	xchg   %ax,%ax
80104bbe:	66 90                	xchg   %ax,%ax

80104bc0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	57                   	push   %edi
80104bc4:	53                   	push   %ebx
80104bc5:	8b 55 08             	mov    0x8(%ebp),%edx
80104bc8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104bcb:	f6 c2 03             	test   $0x3,%dl
80104bce:	75 05                	jne    80104bd5 <memset+0x15>
80104bd0:	f6 c1 03             	test   $0x3,%cl
80104bd3:	74 13                	je     80104be8 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104bd5:	89 d7                	mov    %edx,%edi
80104bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bda:	fc                   	cld    
80104bdb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104bdd:	5b                   	pop    %ebx
80104bde:	89 d0                	mov    %edx,%eax
80104be0:	5f                   	pop    %edi
80104be1:	5d                   	pop    %ebp
80104be2:	c3                   	ret    
80104be3:	90                   	nop
80104be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104be8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104bec:	c1 e9 02             	shr    $0x2,%ecx
80104bef:	89 f8                	mov    %edi,%eax
80104bf1:	89 fb                	mov    %edi,%ebx
80104bf3:	c1 e0 18             	shl    $0x18,%eax
80104bf6:	c1 e3 10             	shl    $0x10,%ebx
80104bf9:	09 d8                	or     %ebx,%eax
80104bfb:	09 f8                	or     %edi,%eax
80104bfd:	c1 e7 08             	shl    $0x8,%edi
80104c00:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104c02:	89 d7                	mov    %edx,%edi
80104c04:	fc                   	cld    
80104c05:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104c07:	5b                   	pop    %ebx
80104c08:	89 d0                	mov    %edx,%eax
80104c0a:	5f                   	pop    %edi
80104c0b:	5d                   	pop    %ebp
80104c0c:	c3                   	ret    
80104c0d:	8d 76 00             	lea    0x0(%esi),%esi

80104c10 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	57                   	push   %edi
80104c14:	56                   	push   %esi
80104c15:	53                   	push   %ebx
80104c16:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104c19:	8b 75 08             	mov    0x8(%ebp),%esi
80104c1c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104c1f:	85 db                	test   %ebx,%ebx
80104c21:	74 29                	je     80104c4c <memcmp+0x3c>
    if(*s1 != *s2)
80104c23:	0f b6 16             	movzbl (%esi),%edx
80104c26:	0f b6 0f             	movzbl (%edi),%ecx
80104c29:	38 d1                	cmp    %dl,%cl
80104c2b:	75 2b                	jne    80104c58 <memcmp+0x48>
80104c2d:	b8 01 00 00 00       	mov    $0x1,%eax
80104c32:	eb 14                	jmp    80104c48 <memcmp+0x38>
80104c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c38:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104c3c:	83 c0 01             	add    $0x1,%eax
80104c3f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104c44:	38 ca                	cmp    %cl,%dl
80104c46:	75 10                	jne    80104c58 <memcmp+0x48>
  while(n-- > 0){
80104c48:	39 d8                	cmp    %ebx,%eax
80104c4a:	75 ec                	jne    80104c38 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104c4c:	5b                   	pop    %ebx
  return 0;
80104c4d:	31 c0                	xor    %eax,%eax
}
80104c4f:	5e                   	pop    %esi
80104c50:	5f                   	pop    %edi
80104c51:	5d                   	pop    %ebp
80104c52:	c3                   	ret    
80104c53:	90                   	nop
80104c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104c58:	0f b6 c2             	movzbl %dl,%eax
}
80104c5b:	5b                   	pop    %ebx
      return *s1 - *s2;
80104c5c:	29 c8                	sub    %ecx,%eax
}
80104c5e:	5e                   	pop    %esi
80104c5f:	5f                   	pop    %edi
80104c60:	5d                   	pop    %ebp
80104c61:	c3                   	ret    
80104c62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c70 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	56                   	push   %esi
80104c74:	53                   	push   %ebx
80104c75:	8b 45 08             	mov    0x8(%ebp),%eax
80104c78:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104c7b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104c7e:	39 c3                	cmp    %eax,%ebx
80104c80:	73 26                	jae    80104ca8 <memmove+0x38>
80104c82:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104c85:	39 c8                	cmp    %ecx,%eax
80104c87:	73 1f                	jae    80104ca8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104c89:	85 f6                	test   %esi,%esi
80104c8b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104c8e:	74 0f                	je     80104c9f <memmove+0x2f>
      *--d = *--s;
80104c90:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104c94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104c97:	83 ea 01             	sub    $0x1,%edx
80104c9a:	83 fa ff             	cmp    $0xffffffff,%edx
80104c9d:	75 f1                	jne    80104c90 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104c9f:	5b                   	pop    %ebx
80104ca0:	5e                   	pop    %esi
80104ca1:	5d                   	pop    %ebp
80104ca2:	c3                   	ret    
80104ca3:	90                   	nop
80104ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104ca8:	31 d2                	xor    %edx,%edx
80104caa:	85 f6                	test   %esi,%esi
80104cac:	74 f1                	je     80104c9f <memmove+0x2f>
80104cae:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104cb0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104cb4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104cb7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104cba:	39 d6                	cmp    %edx,%esi
80104cbc:	75 f2                	jne    80104cb0 <memmove+0x40>
}
80104cbe:	5b                   	pop    %ebx
80104cbf:	5e                   	pop    %esi
80104cc0:	5d                   	pop    %ebp
80104cc1:	c3                   	ret    
80104cc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cd0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104cd3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104cd4:	eb 9a                	jmp    80104c70 <memmove>
80104cd6:	8d 76 00             	lea    0x0(%esi),%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ce0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	57                   	push   %edi
80104ce4:	56                   	push   %esi
80104ce5:	8b 7d 10             	mov    0x10(%ebp),%edi
80104ce8:	53                   	push   %ebx
80104ce9:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104cec:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104cef:	85 ff                	test   %edi,%edi
80104cf1:	74 2f                	je     80104d22 <strncmp+0x42>
80104cf3:	0f b6 01             	movzbl (%ecx),%eax
80104cf6:	0f b6 1e             	movzbl (%esi),%ebx
80104cf9:	84 c0                	test   %al,%al
80104cfb:	74 37                	je     80104d34 <strncmp+0x54>
80104cfd:	38 c3                	cmp    %al,%bl
80104cff:	75 33                	jne    80104d34 <strncmp+0x54>
80104d01:	01 f7                	add    %esi,%edi
80104d03:	eb 13                	jmp    80104d18 <strncmp+0x38>
80104d05:	8d 76 00             	lea    0x0(%esi),%esi
80104d08:	0f b6 01             	movzbl (%ecx),%eax
80104d0b:	84 c0                	test   %al,%al
80104d0d:	74 21                	je     80104d30 <strncmp+0x50>
80104d0f:	0f b6 1a             	movzbl (%edx),%ebx
80104d12:	89 d6                	mov    %edx,%esi
80104d14:	38 d8                	cmp    %bl,%al
80104d16:	75 1c                	jne    80104d34 <strncmp+0x54>
    n--, p++, q++;
80104d18:	8d 56 01             	lea    0x1(%esi),%edx
80104d1b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104d1e:	39 fa                	cmp    %edi,%edx
80104d20:	75 e6                	jne    80104d08 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104d22:	5b                   	pop    %ebx
    return 0;
80104d23:	31 c0                	xor    %eax,%eax
}
80104d25:	5e                   	pop    %esi
80104d26:	5f                   	pop    %edi
80104d27:	5d                   	pop    %ebp
80104d28:	c3                   	ret    
80104d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d30:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104d34:	29 d8                	sub    %ebx,%eax
}
80104d36:	5b                   	pop    %ebx
80104d37:	5e                   	pop    %esi
80104d38:	5f                   	pop    %edi
80104d39:	5d                   	pop    %ebp
80104d3a:	c3                   	ret    
80104d3b:	90                   	nop
80104d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d40 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	56                   	push   %esi
80104d44:	53                   	push   %ebx
80104d45:	8b 45 08             	mov    0x8(%ebp),%eax
80104d48:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104d4b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104d4e:	89 c2                	mov    %eax,%edx
80104d50:	eb 19                	jmp    80104d6b <strncpy+0x2b>
80104d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d58:	83 c3 01             	add    $0x1,%ebx
80104d5b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104d5f:	83 c2 01             	add    $0x1,%edx
80104d62:	84 c9                	test   %cl,%cl
80104d64:	88 4a ff             	mov    %cl,-0x1(%edx)
80104d67:	74 09                	je     80104d72 <strncpy+0x32>
80104d69:	89 f1                	mov    %esi,%ecx
80104d6b:	85 c9                	test   %ecx,%ecx
80104d6d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104d70:	7f e6                	jg     80104d58 <strncpy+0x18>
    ;
  while(n-- > 0)
80104d72:	31 c9                	xor    %ecx,%ecx
80104d74:	85 f6                	test   %esi,%esi
80104d76:	7e 17                	jle    80104d8f <strncpy+0x4f>
80104d78:	90                   	nop
80104d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104d80:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104d84:	89 f3                	mov    %esi,%ebx
80104d86:	83 c1 01             	add    $0x1,%ecx
80104d89:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104d8b:	85 db                	test   %ebx,%ebx
80104d8d:	7f f1                	jg     80104d80 <strncpy+0x40>
  return os;
}
80104d8f:	5b                   	pop    %ebx
80104d90:	5e                   	pop    %esi
80104d91:	5d                   	pop    %ebp
80104d92:	c3                   	ret    
80104d93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104da0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104da0:	55                   	push   %ebp
80104da1:	89 e5                	mov    %esp,%ebp
80104da3:	56                   	push   %esi
80104da4:	53                   	push   %ebx
80104da5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104da8:	8b 45 08             	mov    0x8(%ebp),%eax
80104dab:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104dae:	85 c9                	test   %ecx,%ecx
80104db0:	7e 26                	jle    80104dd8 <safestrcpy+0x38>
80104db2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104db6:	89 c1                	mov    %eax,%ecx
80104db8:	eb 17                	jmp    80104dd1 <safestrcpy+0x31>
80104dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104dc0:	83 c2 01             	add    $0x1,%edx
80104dc3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104dc7:	83 c1 01             	add    $0x1,%ecx
80104dca:	84 db                	test   %bl,%bl
80104dcc:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104dcf:	74 04                	je     80104dd5 <safestrcpy+0x35>
80104dd1:	39 f2                	cmp    %esi,%edx
80104dd3:	75 eb                	jne    80104dc0 <safestrcpy+0x20>
    ;
  *s = 0;
80104dd5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104dd8:	5b                   	pop    %ebx
80104dd9:	5e                   	pop    %esi
80104dda:	5d                   	pop    %ebp
80104ddb:	c3                   	ret    
80104ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104de0 <strlen>:

int
strlen(const char *s)
{
80104de0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104de1:	31 c0                	xor    %eax,%eax
{
80104de3:	89 e5                	mov    %esp,%ebp
80104de5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104de8:	80 3a 00             	cmpb   $0x0,(%edx)
80104deb:	74 0c                	je     80104df9 <strlen+0x19>
80104ded:	8d 76 00             	lea    0x0(%esi),%esi
80104df0:	83 c0 01             	add    $0x1,%eax
80104df3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104df7:	75 f7                	jne    80104df0 <strlen+0x10>
    ;
  return n;
}
80104df9:	5d                   	pop    %ebp
80104dfa:	c3                   	ret    

80104dfb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104dfb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104dff:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104e03:	55                   	push   %ebp
  pushl %ebx
80104e04:	53                   	push   %ebx
  pushl %esi
80104e05:	56                   	push   %esi
  pushl %edi
80104e06:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104e07:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104e09:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104e0b:	5f                   	pop    %edi
  popl %esi
80104e0c:	5e                   	pop    %esi
  popl %ebx
80104e0d:	5b                   	pop    %ebx
  popl %ebp
80104e0e:	5d                   	pop    %ebp
  ret
80104e0f:	c3                   	ret    

80104e10 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	53                   	push   %ebx
80104e14:	83 ec 04             	sub    $0x4,%esp
80104e17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104e1a:	e8 41 ed ff ff       	call   80103b60 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104e1f:	8b 00                	mov    (%eax),%eax
80104e21:	39 d8                	cmp    %ebx,%eax
80104e23:	76 1b                	jbe    80104e40 <fetchint+0x30>
80104e25:	8d 53 04             	lea    0x4(%ebx),%edx
80104e28:	39 d0                	cmp    %edx,%eax
80104e2a:	72 14                	jb     80104e40 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e2f:	8b 13                	mov    (%ebx),%edx
80104e31:	89 10                	mov    %edx,(%eax)
  return 0;
80104e33:	31 c0                	xor    %eax,%eax
}
80104e35:	83 c4 04             	add    $0x4,%esp
80104e38:	5b                   	pop    %ebx
80104e39:	5d                   	pop    %ebp
80104e3a:	c3                   	ret    
80104e3b:	90                   	nop
80104e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e45:	eb ee                	jmp    80104e35 <fetchint+0x25>
80104e47:	89 f6                	mov    %esi,%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e50 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	53                   	push   %ebx
80104e54:	83 ec 04             	sub    $0x4,%esp
80104e57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104e5a:	e8 01 ed ff ff       	call   80103b60 <myproc>

  if(addr >= curproc->sz)
80104e5f:	39 18                	cmp    %ebx,(%eax)
80104e61:	76 29                	jbe    80104e8c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104e63:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104e66:	89 da                	mov    %ebx,%edx
80104e68:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104e6a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104e6c:	39 c3                	cmp    %eax,%ebx
80104e6e:	73 1c                	jae    80104e8c <fetchstr+0x3c>
    if(*s == 0)
80104e70:	80 3b 00             	cmpb   $0x0,(%ebx)
80104e73:	75 10                	jne    80104e85 <fetchstr+0x35>
80104e75:	eb 39                	jmp    80104eb0 <fetchstr+0x60>
80104e77:	89 f6                	mov    %esi,%esi
80104e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104e80:	80 3a 00             	cmpb   $0x0,(%edx)
80104e83:	74 1b                	je     80104ea0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104e85:	83 c2 01             	add    $0x1,%edx
80104e88:	39 d0                	cmp    %edx,%eax
80104e8a:	77 f4                	ja     80104e80 <fetchstr+0x30>
    return -1;
80104e8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104e91:	83 c4 04             	add    $0x4,%esp
80104e94:	5b                   	pop    %ebx
80104e95:	5d                   	pop    %ebp
80104e96:	c3                   	ret    
80104e97:	89 f6                	mov    %esi,%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ea0:	83 c4 04             	add    $0x4,%esp
80104ea3:	89 d0                	mov    %edx,%eax
80104ea5:	29 d8                	sub    %ebx,%eax
80104ea7:	5b                   	pop    %ebx
80104ea8:	5d                   	pop    %ebp
80104ea9:	c3                   	ret    
80104eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104eb0:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104eb2:	eb dd                	jmp    80104e91 <fetchstr+0x41>
80104eb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104eba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ec0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	56                   	push   %esi
80104ec4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ec5:	e8 96 ec ff ff       	call   80103b60 <myproc>
80104eca:	8b 40 18             	mov    0x18(%eax),%eax
80104ecd:	8b 55 08             	mov    0x8(%ebp),%edx
80104ed0:	8b 40 44             	mov    0x44(%eax),%eax
80104ed3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104ed6:	e8 85 ec ff ff       	call   80103b60 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104edb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104edd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ee0:	39 c6                	cmp    %eax,%esi
80104ee2:	73 1c                	jae    80104f00 <argint+0x40>
80104ee4:	8d 53 08             	lea    0x8(%ebx),%edx
80104ee7:	39 d0                	cmp    %edx,%eax
80104ee9:	72 15                	jb     80104f00 <argint+0x40>
  *ip = *(int*)(addr);
80104eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104eee:	8b 53 04             	mov    0x4(%ebx),%edx
80104ef1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ef3:	31 c0                	xor    %eax,%eax
}
80104ef5:	5b                   	pop    %ebx
80104ef6:	5e                   	pop    %esi
80104ef7:	5d                   	pop    %ebp
80104ef8:	c3                   	ret    
80104ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f05:	eb ee                	jmp    80104ef5 <argint+0x35>
80104f07:	89 f6                	mov    %esi,%esi
80104f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f10 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	56                   	push   %esi
80104f14:	53                   	push   %ebx
80104f15:	83 ec 10             	sub    $0x10,%esp
80104f18:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104f1b:	e8 40 ec ff ff       	call   80103b60 <myproc>
80104f20:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104f22:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f25:	83 ec 08             	sub    $0x8,%esp
80104f28:	50                   	push   %eax
80104f29:	ff 75 08             	pushl  0x8(%ebp)
80104f2c:	e8 8f ff ff ff       	call   80104ec0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104f31:	83 c4 10             	add    $0x10,%esp
80104f34:	85 c0                	test   %eax,%eax
80104f36:	78 28                	js     80104f60 <argptr+0x50>
80104f38:	85 db                	test   %ebx,%ebx
80104f3a:	78 24                	js     80104f60 <argptr+0x50>
80104f3c:	8b 16                	mov    (%esi),%edx
80104f3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f41:	39 c2                	cmp    %eax,%edx
80104f43:	76 1b                	jbe    80104f60 <argptr+0x50>
80104f45:	01 c3                	add    %eax,%ebx
80104f47:	39 da                	cmp    %ebx,%edx
80104f49:	72 15                	jb     80104f60 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104f4b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f4e:	89 02                	mov    %eax,(%edx)
  return 0;
80104f50:	31 c0                	xor    %eax,%eax
}
80104f52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f55:	5b                   	pop    %ebx
80104f56:	5e                   	pop    %esi
80104f57:	5d                   	pop    %ebp
80104f58:	c3                   	ret    
80104f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104f60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f65:	eb eb                	jmp    80104f52 <argptr+0x42>
80104f67:	89 f6                	mov    %esi,%esi
80104f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f70 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104f76:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f79:	50                   	push   %eax
80104f7a:	ff 75 08             	pushl  0x8(%ebp)
80104f7d:	e8 3e ff ff ff       	call   80104ec0 <argint>
80104f82:	83 c4 10             	add    $0x10,%esp
80104f85:	85 c0                	test   %eax,%eax
80104f87:	78 17                	js     80104fa0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104f89:	83 ec 08             	sub    $0x8,%esp
80104f8c:	ff 75 0c             	pushl  0xc(%ebp)
80104f8f:	ff 75 f4             	pushl  -0xc(%ebp)
80104f92:	e8 b9 fe ff ff       	call   80104e50 <fetchstr>
80104f97:	83 c4 10             	add    $0x10,%esp
}
80104f9a:	c9                   	leave  
80104f9b:	c3                   	ret    
80104f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104fa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fa5:	c9                   	leave  
80104fa6:	c3                   	ret    
80104fa7:	89 f6                	mov    %esi,%esi
80104fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fb0 <syscall>:

};

void
syscall(void)
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	53                   	push   %ebx
80104fb4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104fb7:	e8 a4 eb ff ff       	call   80103b60 <myproc>
80104fbc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104fbe:	8b 40 18             	mov    0x18(%eax),%eax
80104fc1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104fc4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104fc7:	83 fa 1f             	cmp    $0x1f,%edx
80104fca:	77 2c                	ja     80104ff8 <syscall+0x48>
80104fcc:	8b 14 85 80 7e 10 80 	mov    -0x7fef8180(,%eax,4),%edx
80104fd3:	85 d2                	test   %edx,%edx
80104fd5:	74 21                	je     80104ff8 <syscall+0x48>
    if(state1==TRACE_ON)
80104fd7:	83 3d 58 b8 10 80 01 	cmpl   $0x1,0x8010b858
80104fde:	75 08                	jne    80104fe8 <syscall+0x38>
      sys_count[num]++;
80104fe0:	83 04 85 20 31 13 80 	addl   $0x1,-0x7feccee0(,%eax,4)
80104fe7:	01 
    curproc->tf->eax = syscalls[num]();
80104fe8:	ff d2                	call   *%edx
80104fea:	8b 53 18             	mov    0x18(%ebx),%edx
80104fed:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104ff0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ff3:	c9                   	leave  
80104ff4:	c3                   	ret    
80104ff5:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104ff8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104ff9:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104ffc:	50                   	push   %eax
80104ffd:	ff 73 10             	pushl  0x10(%ebx)
80105000:	68 49 7e 10 80       	push   $0x80107e49
80105005:	e8 56 b6 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
8010500a:	8b 43 18             	mov    0x18(%ebx),%eax
8010500d:	83 c4 10             	add    $0x10,%esp
80105010:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105017:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010501a:	c9                   	leave  
8010501b:	c3                   	ret    
8010501c:	66 90                	xchg   %ax,%ax
8010501e:	66 90                	xchg   %ax,%ax

80105020 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	57                   	push   %edi
80105024:	56                   	push   %esi
80105025:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105026:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105029:	83 ec 44             	sub    $0x44,%esp
8010502c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010502f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105032:	56                   	push   %esi
80105033:	50                   	push   %eax
{
80105034:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105037:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010503a:	e8 d1 ce ff ff       	call   80101f10 <nameiparent>
8010503f:	83 c4 10             	add    $0x10,%esp
80105042:	85 c0                	test   %eax,%eax
80105044:	0f 84 46 01 00 00    	je     80105190 <create+0x170>
    return 0;
  ilock(dp);
8010504a:	83 ec 0c             	sub    $0xc,%esp
8010504d:	89 c3                	mov    %eax,%ebx
8010504f:	50                   	push   %eax
80105050:	e8 3b c6 ff ff       	call   80101690 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105055:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105058:	83 c4 0c             	add    $0xc,%esp
8010505b:	50                   	push   %eax
8010505c:	56                   	push   %esi
8010505d:	53                   	push   %ebx
8010505e:	e8 5d cb ff ff       	call   80101bc0 <dirlookup>
80105063:	83 c4 10             	add    $0x10,%esp
80105066:	85 c0                	test   %eax,%eax
80105068:	89 c7                	mov    %eax,%edi
8010506a:	74 34                	je     801050a0 <create+0x80>
    iunlockput(dp);
8010506c:	83 ec 0c             	sub    $0xc,%esp
8010506f:	53                   	push   %ebx
80105070:	e8 ab c8 ff ff       	call   80101920 <iunlockput>
    ilock(ip);
80105075:	89 3c 24             	mov    %edi,(%esp)
80105078:	e8 13 c6 ff ff       	call   80101690 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010507d:	83 c4 10             	add    $0x10,%esp
80105080:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105085:	0f 85 95 00 00 00    	jne    80105120 <create+0x100>
8010508b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105090:	0f 85 8a 00 00 00    	jne    80105120 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105096:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105099:	89 f8                	mov    %edi,%eax
8010509b:	5b                   	pop    %ebx
8010509c:	5e                   	pop    %esi
8010509d:	5f                   	pop    %edi
8010509e:	5d                   	pop    %ebp
8010509f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
801050a0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
801050a4:	83 ec 08             	sub    $0x8,%esp
801050a7:	50                   	push   %eax
801050a8:	ff 33                	pushl  (%ebx)
801050aa:	e8 71 c4 ff ff       	call   80101520 <ialloc>
801050af:	83 c4 10             	add    $0x10,%esp
801050b2:	85 c0                	test   %eax,%eax
801050b4:	89 c7                	mov    %eax,%edi
801050b6:	0f 84 e8 00 00 00    	je     801051a4 <create+0x184>
  ilock(ip);
801050bc:	83 ec 0c             	sub    $0xc,%esp
801050bf:	50                   	push   %eax
801050c0:	e8 cb c5 ff ff       	call   80101690 <ilock>
  ip->major = major;
801050c5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
801050c9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
801050cd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
801050d1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
801050d5:	b8 01 00 00 00       	mov    $0x1,%eax
801050da:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
801050de:	89 3c 24             	mov    %edi,(%esp)
801050e1:	e8 fa c4 ff ff       	call   801015e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801050e6:	83 c4 10             	add    $0x10,%esp
801050e9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
801050ee:	74 50                	je     80105140 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801050f0:	83 ec 04             	sub    $0x4,%esp
801050f3:	ff 77 04             	pushl  0x4(%edi)
801050f6:	56                   	push   %esi
801050f7:	53                   	push   %ebx
801050f8:	e8 33 cd ff ff       	call   80101e30 <dirlink>
801050fd:	83 c4 10             	add    $0x10,%esp
80105100:	85 c0                	test   %eax,%eax
80105102:	0f 88 8f 00 00 00    	js     80105197 <create+0x177>
  iunlockput(dp);
80105108:	83 ec 0c             	sub    $0xc,%esp
8010510b:	53                   	push   %ebx
8010510c:	e8 0f c8 ff ff       	call   80101920 <iunlockput>
  return ip;
80105111:	83 c4 10             	add    $0x10,%esp
}
80105114:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105117:	89 f8                	mov    %edi,%eax
80105119:	5b                   	pop    %ebx
8010511a:	5e                   	pop    %esi
8010511b:	5f                   	pop    %edi
8010511c:	5d                   	pop    %ebp
8010511d:	c3                   	ret    
8010511e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105120:	83 ec 0c             	sub    $0xc,%esp
80105123:	57                   	push   %edi
    return 0;
80105124:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105126:	e8 f5 c7 ff ff       	call   80101920 <iunlockput>
    return 0;
8010512b:	83 c4 10             	add    $0x10,%esp
}
8010512e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105131:	89 f8                	mov    %edi,%eax
80105133:	5b                   	pop    %ebx
80105134:	5e                   	pop    %esi
80105135:	5f                   	pop    %edi
80105136:	5d                   	pop    %ebp
80105137:	c3                   	ret    
80105138:	90                   	nop
80105139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105140:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105145:	83 ec 0c             	sub    $0xc,%esp
80105148:	53                   	push   %ebx
80105149:	e8 92 c4 ff ff       	call   801015e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010514e:	83 c4 0c             	add    $0xc,%esp
80105151:	ff 77 04             	pushl  0x4(%edi)
80105154:	68 20 7f 10 80       	push   $0x80107f20
80105159:	57                   	push   %edi
8010515a:	e8 d1 cc ff ff       	call   80101e30 <dirlink>
8010515f:	83 c4 10             	add    $0x10,%esp
80105162:	85 c0                	test   %eax,%eax
80105164:	78 1c                	js     80105182 <create+0x162>
80105166:	83 ec 04             	sub    $0x4,%esp
80105169:	ff 73 04             	pushl  0x4(%ebx)
8010516c:	68 1f 7f 10 80       	push   $0x80107f1f
80105171:	57                   	push   %edi
80105172:	e8 b9 cc ff ff       	call   80101e30 <dirlink>
80105177:	83 c4 10             	add    $0x10,%esp
8010517a:	85 c0                	test   %eax,%eax
8010517c:	0f 89 6e ff ff ff    	jns    801050f0 <create+0xd0>
      panic("create dots");
80105182:	83 ec 0c             	sub    $0xc,%esp
80105185:	68 13 7f 10 80       	push   $0x80107f13
8010518a:	e8 01 b2 ff ff       	call   80100390 <panic>
8010518f:	90                   	nop
    return 0;
80105190:	31 ff                	xor    %edi,%edi
80105192:	e9 ff fe ff ff       	jmp    80105096 <create+0x76>
    panic("create: dirlink");
80105197:	83 ec 0c             	sub    $0xc,%esp
8010519a:	68 22 7f 10 80       	push   $0x80107f22
8010519f:	e8 ec b1 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
801051a4:	83 ec 0c             	sub    $0xc,%esp
801051a7:	68 04 7f 10 80       	push   $0x80107f04
801051ac:	e8 df b1 ff ff       	call   80100390 <panic>
801051b1:	eb 0d                	jmp    801051c0 <argfd.constprop.0>
801051b3:	90                   	nop
801051b4:	90                   	nop
801051b5:	90                   	nop
801051b6:	90                   	nop
801051b7:	90                   	nop
801051b8:	90                   	nop
801051b9:	90                   	nop
801051ba:	90                   	nop
801051bb:	90                   	nop
801051bc:	90                   	nop
801051bd:	90                   	nop
801051be:	90                   	nop
801051bf:	90                   	nop

801051c0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	56                   	push   %esi
801051c4:	53                   	push   %ebx
801051c5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
801051c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801051ca:	89 d6                	mov    %edx,%esi
801051cc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801051cf:	50                   	push   %eax
801051d0:	6a 00                	push   $0x0
801051d2:	e8 e9 fc ff ff       	call   80104ec0 <argint>
801051d7:	83 c4 10             	add    $0x10,%esp
801051da:	85 c0                	test   %eax,%eax
801051dc:	78 2a                	js     80105208 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801051de:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801051e2:	77 24                	ja     80105208 <argfd.constprop.0+0x48>
801051e4:	e8 77 e9 ff ff       	call   80103b60 <myproc>
801051e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051ec:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801051f0:	85 c0                	test   %eax,%eax
801051f2:	74 14                	je     80105208 <argfd.constprop.0+0x48>
  if(pfd)
801051f4:	85 db                	test   %ebx,%ebx
801051f6:	74 02                	je     801051fa <argfd.constprop.0+0x3a>
    *pfd = fd;
801051f8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801051fa:	89 06                	mov    %eax,(%esi)
  return 0;
801051fc:	31 c0                	xor    %eax,%eax
}
801051fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105201:	5b                   	pop    %ebx
80105202:	5e                   	pop    %esi
80105203:	5d                   	pop    %ebp
80105204:	c3                   	ret    
80105205:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010520d:	eb ef                	jmp    801051fe <argfd.constprop.0+0x3e>
8010520f:	90                   	nop

80105210 <sys_dup>:
{
80105210:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105211:	31 c0                	xor    %eax,%eax
{
80105213:	89 e5                	mov    %esp,%ebp
80105215:	56                   	push   %esi
80105216:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105217:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010521a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010521d:	e8 9e ff ff ff       	call   801051c0 <argfd.constprop.0>
80105222:	85 c0                	test   %eax,%eax
80105224:	78 42                	js     80105268 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80105226:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105229:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010522b:	e8 30 e9 ff ff       	call   80103b60 <myproc>
80105230:	eb 0e                	jmp    80105240 <sys_dup+0x30>
80105232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105238:	83 c3 01             	add    $0x1,%ebx
8010523b:	83 fb 10             	cmp    $0x10,%ebx
8010523e:	74 28                	je     80105268 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105240:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105244:	85 d2                	test   %edx,%edx
80105246:	75 f0                	jne    80105238 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105248:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010524c:	83 ec 0c             	sub    $0xc,%esp
8010524f:	ff 75 f4             	pushl  -0xc(%ebp)
80105252:	e8 99 bb ff ff       	call   80100df0 <filedup>
  return fd;
80105257:	83 c4 10             	add    $0x10,%esp
}
8010525a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010525d:	89 d8                	mov    %ebx,%eax
8010525f:	5b                   	pop    %ebx
80105260:	5e                   	pop    %esi
80105261:	5d                   	pop    %ebp
80105262:	c3                   	ret    
80105263:	90                   	nop
80105264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105268:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010526b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105270:	89 d8                	mov    %ebx,%eax
80105272:	5b                   	pop    %ebx
80105273:	5e                   	pop    %esi
80105274:	5d                   	pop    %ebp
80105275:	c3                   	ret    
80105276:	8d 76 00             	lea    0x0(%esi),%esi
80105279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105280 <sys_read>:
{
80105280:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105281:	31 c0                	xor    %eax,%eax
{
80105283:	89 e5                	mov    %esp,%ebp
80105285:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105288:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010528b:	e8 30 ff ff ff       	call   801051c0 <argfd.constprop.0>
80105290:	85 c0                	test   %eax,%eax
80105292:	78 4c                	js     801052e0 <sys_read+0x60>
80105294:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105297:	83 ec 08             	sub    $0x8,%esp
8010529a:	50                   	push   %eax
8010529b:	6a 02                	push   $0x2
8010529d:	e8 1e fc ff ff       	call   80104ec0 <argint>
801052a2:	83 c4 10             	add    $0x10,%esp
801052a5:	85 c0                	test   %eax,%eax
801052a7:	78 37                	js     801052e0 <sys_read+0x60>
801052a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052ac:	83 ec 04             	sub    $0x4,%esp
801052af:	ff 75 f0             	pushl  -0x10(%ebp)
801052b2:	50                   	push   %eax
801052b3:	6a 01                	push   $0x1
801052b5:	e8 56 fc ff ff       	call   80104f10 <argptr>
801052ba:	83 c4 10             	add    $0x10,%esp
801052bd:	85 c0                	test   %eax,%eax
801052bf:	78 1f                	js     801052e0 <sys_read+0x60>
  return fileread(f, p, n);
801052c1:	83 ec 04             	sub    $0x4,%esp
801052c4:	ff 75 f0             	pushl  -0x10(%ebp)
801052c7:	ff 75 f4             	pushl  -0xc(%ebp)
801052ca:	ff 75 ec             	pushl  -0x14(%ebp)
801052cd:	e8 8e bc ff ff       	call   80100f60 <fileread>
801052d2:	83 c4 10             	add    $0x10,%esp
}
801052d5:	c9                   	leave  
801052d6:	c3                   	ret    
801052d7:	89 f6                	mov    %esi,%esi
801052d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801052e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052e5:	c9                   	leave  
801052e6:	c3                   	ret    
801052e7:	89 f6                	mov    %esi,%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052f0 <sys_write>:
{
801052f0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801052f1:	31 c0                	xor    %eax,%eax
{
801052f3:	89 e5                	mov    %esp,%ebp
801052f5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801052f8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801052fb:	e8 c0 fe ff ff       	call   801051c0 <argfd.constprop.0>
80105300:	85 c0                	test   %eax,%eax
80105302:	78 4c                	js     80105350 <sys_write+0x60>
80105304:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105307:	83 ec 08             	sub    $0x8,%esp
8010530a:	50                   	push   %eax
8010530b:	6a 02                	push   $0x2
8010530d:	e8 ae fb ff ff       	call   80104ec0 <argint>
80105312:	83 c4 10             	add    $0x10,%esp
80105315:	85 c0                	test   %eax,%eax
80105317:	78 37                	js     80105350 <sys_write+0x60>
80105319:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010531c:	83 ec 04             	sub    $0x4,%esp
8010531f:	ff 75 f0             	pushl  -0x10(%ebp)
80105322:	50                   	push   %eax
80105323:	6a 01                	push   $0x1
80105325:	e8 e6 fb ff ff       	call   80104f10 <argptr>
8010532a:	83 c4 10             	add    $0x10,%esp
8010532d:	85 c0                	test   %eax,%eax
8010532f:	78 1f                	js     80105350 <sys_write+0x60>
  return filewrite(f, p, n);
80105331:	83 ec 04             	sub    $0x4,%esp
80105334:	ff 75 f0             	pushl  -0x10(%ebp)
80105337:	ff 75 f4             	pushl  -0xc(%ebp)
8010533a:	ff 75 ec             	pushl  -0x14(%ebp)
8010533d:	e8 ae bc ff ff       	call   80100ff0 <filewrite>
80105342:	83 c4 10             	add    $0x10,%esp
}
80105345:	c9                   	leave  
80105346:	c3                   	ret    
80105347:	89 f6                	mov    %esi,%esi
80105349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105355:	c9                   	leave  
80105356:	c3                   	ret    
80105357:	89 f6                	mov    %esi,%esi
80105359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105360 <sys_close>:
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105366:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105369:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010536c:	e8 4f fe ff ff       	call   801051c0 <argfd.constprop.0>
80105371:	85 c0                	test   %eax,%eax
80105373:	78 2b                	js     801053a0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105375:	e8 e6 e7 ff ff       	call   80103b60 <myproc>
8010537a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010537d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105380:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105387:	00 
  fileclose(f);
80105388:	ff 75 f4             	pushl  -0xc(%ebp)
8010538b:	e8 b0 ba ff ff       	call   80100e40 <fileclose>
  return 0;
80105390:	83 c4 10             	add    $0x10,%esp
80105393:	31 c0                	xor    %eax,%eax
}
80105395:	c9                   	leave  
80105396:	c3                   	ret    
80105397:	89 f6                	mov    %esi,%esi
80105399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801053a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053a5:	c9                   	leave  
801053a6:	c3                   	ret    
801053a7:	89 f6                	mov    %esi,%esi
801053a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053b0 <sys_fstat>:
{
801053b0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801053b1:	31 c0                	xor    %eax,%eax
{
801053b3:	89 e5                	mov    %esp,%ebp
801053b5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801053b8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801053bb:	e8 00 fe ff ff       	call   801051c0 <argfd.constprop.0>
801053c0:	85 c0                	test   %eax,%eax
801053c2:	78 2c                	js     801053f0 <sys_fstat+0x40>
801053c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053c7:	83 ec 04             	sub    $0x4,%esp
801053ca:	6a 14                	push   $0x14
801053cc:	50                   	push   %eax
801053cd:	6a 01                	push   $0x1
801053cf:	e8 3c fb ff ff       	call   80104f10 <argptr>
801053d4:	83 c4 10             	add    $0x10,%esp
801053d7:	85 c0                	test   %eax,%eax
801053d9:	78 15                	js     801053f0 <sys_fstat+0x40>
  return filestat(f, st);
801053db:	83 ec 08             	sub    $0x8,%esp
801053de:	ff 75 f4             	pushl  -0xc(%ebp)
801053e1:	ff 75 f0             	pushl  -0x10(%ebp)
801053e4:	e8 27 bb ff ff       	call   80100f10 <filestat>
801053e9:	83 c4 10             	add    $0x10,%esp
}
801053ec:	c9                   	leave  
801053ed:	c3                   	ret    
801053ee:	66 90                	xchg   %ax,%ax
    return -1;
801053f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053f5:	c9                   	leave  
801053f6:	c3                   	ret    
801053f7:	89 f6                	mov    %esi,%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105400 <sys_link>:
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	57                   	push   %edi
80105404:	56                   	push   %esi
80105405:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105406:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105409:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010540c:	50                   	push   %eax
8010540d:	6a 00                	push   $0x0
8010540f:	e8 5c fb ff ff       	call   80104f70 <argstr>
80105414:	83 c4 10             	add    $0x10,%esp
80105417:	85 c0                	test   %eax,%eax
80105419:	0f 88 fb 00 00 00    	js     8010551a <sys_link+0x11a>
8010541f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105422:	83 ec 08             	sub    $0x8,%esp
80105425:	50                   	push   %eax
80105426:	6a 01                	push   $0x1
80105428:	e8 43 fb ff ff       	call   80104f70 <argstr>
8010542d:	83 c4 10             	add    $0x10,%esp
80105430:	85 c0                	test   %eax,%eax
80105432:	0f 88 e2 00 00 00    	js     8010551a <sys_link+0x11a>
  begin_op();
80105438:	e8 73 d7 ff ff       	call   80102bb0 <begin_op>
  if((ip = namei(old)) == 0){
8010543d:	83 ec 0c             	sub    $0xc,%esp
80105440:	ff 75 d4             	pushl  -0x2c(%ebp)
80105443:	e8 a8 ca ff ff       	call   80101ef0 <namei>
80105448:	83 c4 10             	add    $0x10,%esp
8010544b:	85 c0                	test   %eax,%eax
8010544d:	89 c3                	mov    %eax,%ebx
8010544f:	0f 84 ea 00 00 00    	je     8010553f <sys_link+0x13f>
  ilock(ip);
80105455:	83 ec 0c             	sub    $0xc,%esp
80105458:	50                   	push   %eax
80105459:	e8 32 c2 ff ff       	call   80101690 <ilock>
  if(ip->type == T_DIR){
8010545e:	83 c4 10             	add    $0x10,%esp
80105461:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105466:	0f 84 bb 00 00 00    	je     80105527 <sys_link+0x127>
  ip->nlink++;
8010546c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105471:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105474:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105477:	53                   	push   %ebx
80105478:	e8 63 c1 ff ff       	call   801015e0 <iupdate>
  iunlock(ip);
8010547d:	89 1c 24             	mov    %ebx,(%esp)
80105480:	e8 eb c2 ff ff       	call   80101770 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105485:	58                   	pop    %eax
80105486:	5a                   	pop    %edx
80105487:	57                   	push   %edi
80105488:	ff 75 d0             	pushl  -0x30(%ebp)
8010548b:	e8 80 ca ff ff       	call   80101f10 <nameiparent>
80105490:	83 c4 10             	add    $0x10,%esp
80105493:	85 c0                	test   %eax,%eax
80105495:	89 c6                	mov    %eax,%esi
80105497:	74 5b                	je     801054f4 <sys_link+0xf4>
  ilock(dp);
80105499:	83 ec 0c             	sub    $0xc,%esp
8010549c:	50                   	push   %eax
8010549d:	e8 ee c1 ff ff       	call   80101690 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801054a2:	83 c4 10             	add    $0x10,%esp
801054a5:	8b 03                	mov    (%ebx),%eax
801054a7:	39 06                	cmp    %eax,(%esi)
801054a9:	75 3d                	jne    801054e8 <sys_link+0xe8>
801054ab:	83 ec 04             	sub    $0x4,%esp
801054ae:	ff 73 04             	pushl  0x4(%ebx)
801054b1:	57                   	push   %edi
801054b2:	56                   	push   %esi
801054b3:	e8 78 c9 ff ff       	call   80101e30 <dirlink>
801054b8:	83 c4 10             	add    $0x10,%esp
801054bb:	85 c0                	test   %eax,%eax
801054bd:	78 29                	js     801054e8 <sys_link+0xe8>
  iunlockput(dp);
801054bf:	83 ec 0c             	sub    $0xc,%esp
801054c2:	56                   	push   %esi
801054c3:	e8 58 c4 ff ff       	call   80101920 <iunlockput>
  iput(ip);
801054c8:	89 1c 24             	mov    %ebx,(%esp)
801054cb:	e8 f0 c2 ff ff       	call   801017c0 <iput>
  end_op();
801054d0:	e8 4b d7 ff ff       	call   80102c20 <end_op>
  return 0;
801054d5:	83 c4 10             	add    $0x10,%esp
801054d8:	31 c0                	xor    %eax,%eax
}
801054da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054dd:	5b                   	pop    %ebx
801054de:	5e                   	pop    %esi
801054df:	5f                   	pop    %edi
801054e0:	5d                   	pop    %ebp
801054e1:	c3                   	ret    
801054e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801054e8:	83 ec 0c             	sub    $0xc,%esp
801054eb:	56                   	push   %esi
801054ec:	e8 2f c4 ff ff       	call   80101920 <iunlockput>
    goto bad;
801054f1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801054f4:	83 ec 0c             	sub    $0xc,%esp
801054f7:	53                   	push   %ebx
801054f8:	e8 93 c1 ff ff       	call   80101690 <ilock>
  ip->nlink--;
801054fd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105502:	89 1c 24             	mov    %ebx,(%esp)
80105505:	e8 d6 c0 ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
8010550a:	89 1c 24             	mov    %ebx,(%esp)
8010550d:	e8 0e c4 ff ff       	call   80101920 <iunlockput>
  end_op();
80105512:	e8 09 d7 ff ff       	call   80102c20 <end_op>
  return -1;
80105517:	83 c4 10             	add    $0x10,%esp
}
8010551a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010551d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105522:	5b                   	pop    %ebx
80105523:	5e                   	pop    %esi
80105524:	5f                   	pop    %edi
80105525:	5d                   	pop    %ebp
80105526:	c3                   	ret    
    iunlockput(ip);
80105527:	83 ec 0c             	sub    $0xc,%esp
8010552a:	53                   	push   %ebx
8010552b:	e8 f0 c3 ff ff       	call   80101920 <iunlockput>
    end_op();
80105530:	e8 eb d6 ff ff       	call   80102c20 <end_op>
    return -1;
80105535:	83 c4 10             	add    $0x10,%esp
80105538:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010553d:	eb 9b                	jmp    801054da <sys_link+0xda>
    end_op();
8010553f:	e8 dc d6 ff ff       	call   80102c20 <end_op>
    return -1;
80105544:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105549:	eb 8f                	jmp    801054da <sys_link+0xda>
8010554b:	90                   	nop
8010554c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105550 <sys_unlink>:
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	57                   	push   %edi
80105554:	56                   	push   %esi
80105555:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105556:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105559:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010555c:	50                   	push   %eax
8010555d:	6a 00                	push   $0x0
8010555f:	e8 0c fa ff ff       	call   80104f70 <argstr>
80105564:	83 c4 10             	add    $0x10,%esp
80105567:	85 c0                	test   %eax,%eax
80105569:	0f 88 77 01 00 00    	js     801056e6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010556f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105572:	e8 39 d6 ff ff       	call   80102bb0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105577:	83 ec 08             	sub    $0x8,%esp
8010557a:	53                   	push   %ebx
8010557b:	ff 75 c0             	pushl  -0x40(%ebp)
8010557e:	e8 8d c9 ff ff       	call   80101f10 <nameiparent>
80105583:	83 c4 10             	add    $0x10,%esp
80105586:	85 c0                	test   %eax,%eax
80105588:	89 c6                	mov    %eax,%esi
8010558a:	0f 84 60 01 00 00    	je     801056f0 <sys_unlink+0x1a0>
  ilock(dp);
80105590:	83 ec 0c             	sub    $0xc,%esp
80105593:	50                   	push   %eax
80105594:	e8 f7 c0 ff ff       	call   80101690 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105599:	58                   	pop    %eax
8010559a:	5a                   	pop    %edx
8010559b:	68 20 7f 10 80       	push   $0x80107f20
801055a0:	53                   	push   %ebx
801055a1:	e8 fa c5 ff ff       	call   80101ba0 <namecmp>
801055a6:	83 c4 10             	add    $0x10,%esp
801055a9:	85 c0                	test   %eax,%eax
801055ab:	0f 84 03 01 00 00    	je     801056b4 <sys_unlink+0x164>
801055b1:	83 ec 08             	sub    $0x8,%esp
801055b4:	68 1f 7f 10 80       	push   $0x80107f1f
801055b9:	53                   	push   %ebx
801055ba:	e8 e1 c5 ff ff       	call   80101ba0 <namecmp>
801055bf:	83 c4 10             	add    $0x10,%esp
801055c2:	85 c0                	test   %eax,%eax
801055c4:	0f 84 ea 00 00 00    	je     801056b4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
801055ca:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801055cd:	83 ec 04             	sub    $0x4,%esp
801055d0:	50                   	push   %eax
801055d1:	53                   	push   %ebx
801055d2:	56                   	push   %esi
801055d3:	e8 e8 c5 ff ff       	call   80101bc0 <dirlookup>
801055d8:	83 c4 10             	add    $0x10,%esp
801055db:	85 c0                	test   %eax,%eax
801055dd:	89 c3                	mov    %eax,%ebx
801055df:	0f 84 cf 00 00 00    	je     801056b4 <sys_unlink+0x164>
  ilock(ip);
801055e5:	83 ec 0c             	sub    $0xc,%esp
801055e8:	50                   	push   %eax
801055e9:	e8 a2 c0 ff ff       	call   80101690 <ilock>
  if(ip->nlink < 1)
801055ee:	83 c4 10             	add    $0x10,%esp
801055f1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801055f6:	0f 8e 10 01 00 00    	jle    8010570c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801055fc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105601:	74 6d                	je     80105670 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105603:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105606:	83 ec 04             	sub    $0x4,%esp
80105609:	6a 10                	push   $0x10
8010560b:	6a 00                	push   $0x0
8010560d:	50                   	push   %eax
8010560e:	e8 ad f5 ff ff       	call   80104bc0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105613:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105616:	6a 10                	push   $0x10
80105618:	ff 75 c4             	pushl  -0x3c(%ebp)
8010561b:	50                   	push   %eax
8010561c:	56                   	push   %esi
8010561d:	e8 4e c4 ff ff       	call   80101a70 <writei>
80105622:	83 c4 20             	add    $0x20,%esp
80105625:	83 f8 10             	cmp    $0x10,%eax
80105628:	0f 85 eb 00 00 00    	jne    80105719 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010562e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105633:	0f 84 97 00 00 00    	je     801056d0 <sys_unlink+0x180>
  iunlockput(dp);
80105639:	83 ec 0c             	sub    $0xc,%esp
8010563c:	56                   	push   %esi
8010563d:	e8 de c2 ff ff       	call   80101920 <iunlockput>
  ip->nlink--;
80105642:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105647:	89 1c 24             	mov    %ebx,(%esp)
8010564a:	e8 91 bf ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
8010564f:	89 1c 24             	mov    %ebx,(%esp)
80105652:	e8 c9 c2 ff ff       	call   80101920 <iunlockput>
  end_op();
80105657:	e8 c4 d5 ff ff       	call   80102c20 <end_op>
  return 0;
8010565c:	83 c4 10             	add    $0x10,%esp
8010565f:	31 c0                	xor    %eax,%eax
}
80105661:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105664:	5b                   	pop    %ebx
80105665:	5e                   	pop    %esi
80105666:	5f                   	pop    %edi
80105667:	5d                   	pop    %ebp
80105668:	c3                   	ret    
80105669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105670:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105674:	76 8d                	jbe    80105603 <sys_unlink+0xb3>
80105676:	bf 20 00 00 00       	mov    $0x20,%edi
8010567b:	eb 0f                	jmp    8010568c <sys_unlink+0x13c>
8010567d:	8d 76 00             	lea    0x0(%esi),%esi
80105680:	83 c7 10             	add    $0x10,%edi
80105683:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105686:	0f 83 77 ff ff ff    	jae    80105603 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010568c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010568f:	6a 10                	push   $0x10
80105691:	57                   	push   %edi
80105692:	50                   	push   %eax
80105693:	53                   	push   %ebx
80105694:	e8 d7 c2 ff ff       	call   80101970 <readi>
80105699:	83 c4 10             	add    $0x10,%esp
8010569c:	83 f8 10             	cmp    $0x10,%eax
8010569f:	75 5e                	jne    801056ff <sys_unlink+0x1af>
    if(de.inum != 0)
801056a1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801056a6:	74 d8                	je     80105680 <sys_unlink+0x130>
    iunlockput(ip);
801056a8:	83 ec 0c             	sub    $0xc,%esp
801056ab:	53                   	push   %ebx
801056ac:	e8 6f c2 ff ff       	call   80101920 <iunlockput>
    goto bad;
801056b1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801056b4:	83 ec 0c             	sub    $0xc,%esp
801056b7:	56                   	push   %esi
801056b8:	e8 63 c2 ff ff       	call   80101920 <iunlockput>
  end_op();
801056bd:	e8 5e d5 ff ff       	call   80102c20 <end_op>
  return -1;
801056c2:	83 c4 10             	add    $0x10,%esp
801056c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ca:	eb 95                	jmp    80105661 <sys_unlink+0x111>
801056cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801056d0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801056d5:	83 ec 0c             	sub    $0xc,%esp
801056d8:	56                   	push   %esi
801056d9:	e8 02 bf ff ff       	call   801015e0 <iupdate>
801056de:	83 c4 10             	add    $0x10,%esp
801056e1:	e9 53 ff ff ff       	jmp    80105639 <sys_unlink+0xe9>
    return -1;
801056e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056eb:	e9 71 ff ff ff       	jmp    80105661 <sys_unlink+0x111>
    end_op();
801056f0:	e8 2b d5 ff ff       	call   80102c20 <end_op>
    return -1;
801056f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056fa:	e9 62 ff ff ff       	jmp    80105661 <sys_unlink+0x111>
      panic("isdirempty: readi");
801056ff:	83 ec 0c             	sub    $0xc,%esp
80105702:	68 44 7f 10 80       	push   $0x80107f44
80105707:	e8 84 ac ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010570c:	83 ec 0c             	sub    $0xc,%esp
8010570f:	68 32 7f 10 80       	push   $0x80107f32
80105714:	e8 77 ac ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105719:	83 ec 0c             	sub    $0xc,%esp
8010571c:	68 56 7f 10 80       	push   $0x80107f56
80105721:	e8 6a ac ff ff       	call   80100390 <panic>
80105726:	8d 76 00             	lea    0x0(%esi),%esi
80105729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105730 <sys_open>:

int
sys_open(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	57                   	push   %edi
80105734:	56                   	push   %esi
80105735:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105736:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105739:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010573c:	50                   	push   %eax
8010573d:	6a 00                	push   $0x0
8010573f:	e8 2c f8 ff ff       	call   80104f70 <argstr>
80105744:	83 c4 10             	add    $0x10,%esp
80105747:	85 c0                	test   %eax,%eax
80105749:	0f 88 1d 01 00 00    	js     8010586c <sys_open+0x13c>
8010574f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105752:	83 ec 08             	sub    $0x8,%esp
80105755:	50                   	push   %eax
80105756:	6a 01                	push   $0x1
80105758:	e8 63 f7 ff ff       	call   80104ec0 <argint>
8010575d:	83 c4 10             	add    $0x10,%esp
80105760:	85 c0                	test   %eax,%eax
80105762:	0f 88 04 01 00 00    	js     8010586c <sys_open+0x13c>
    return -1;

  begin_op();
80105768:	e8 43 d4 ff ff       	call   80102bb0 <begin_op>

  if(omode & O_CREATE){
8010576d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105771:	0f 85 a9 00 00 00    	jne    80105820 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105777:	83 ec 0c             	sub    $0xc,%esp
8010577a:	ff 75 e0             	pushl  -0x20(%ebp)
8010577d:	e8 6e c7 ff ff       	call   80101ef0 <namei>
80105782:	83 c4 10             	add    $0x10,%esp
80105785:	85 c0                	test   %eax,%eax
80105787:	89 c6                	mov    %eax,%esi
80105789:	0f 84 b2 00 00 00    	je     80105841 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010578f:	83 ec 0c             	sub    $0xc,%esp
80105792:	50                   	push   %eax
80105793:	e8 f8 be ff ff       	call   80101690 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105798:	83 c4 10             	add    $0x10,%esp
8010579b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801057a0:	0f 84 aa 00 00 00    	je     80105850 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801057a6:	e8 d5 b5 ff ff       	call   80100d80 <filealloc>
801057ab:	85 c0                	test   %eax,%eax
801057ad:	89 c7                	mov    %eax,%edi
801057af:	0f 84 a6 00 00 00    	je     8010585b <sys_open+0x12b>
  struct proc *curproc = myproc();
801057b5:	e8 a6 e3 ff ff       	call   80103b60 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801057ba:	31 db                	xor    %ebx,%ebx
801057bc:	eb 0e                	jmp    801057cc <sys_open+0x9c>
801057be:	66 90                	xchg   %ax,%ax
801057c0:	83 c3 01             	add    $0x1,%ebx
801057c3:	83 fb 10             	cmp    $0x10,%ebx
801057c6:	0f 84 ac 00 00 00    	je     80105878 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801057cc:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801057d0:	85 d2                	test   %edx,%edx
801057d2:	75 ec                	jne    801057c0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801057d4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801057d7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801057db:	56                   	push   %esi
801057dc:	e8 8f bf ff ff       	call   80101770 <iunlock>
  end_op();
801057e1:	e8 3a d4 ff ff       	call   80102c20 <end_op>

  f->type = FD_INODE;
801057e6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801057ec:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801057ef:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801057f2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801057f5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801057fc:	89 d0                	mov    %edx,%eax
801057fe:	f7 d0                	not    %eax
80105800:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105803:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105806:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105809:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010580d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105810:	89 d8                	mov    %ebx,%eax
80105812:	5b                   	pop    %ebx
80105813:	5e                   	pop    %esi
80105814:	5f                   	pop    %edi
80105815:	5d                   	pop    %ebp
80105816:	c3                   	ret    
80105817:	89 f6                	mov    %esi,%esi
80105819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105820:	83 ec 0c             	sub    $0xc,%esp
80105823:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105826:	31 c9                	xor    %ecx,%ecx
80105828:	6a 00                	push   $0x0
8010582a:	ba 02 00 00 00       	mov    $0x2,%edx
8010582f:	e8 ec f7 ff ff       	call   80105020 <create>
    if(ip == 0){
80105834:	83 c4 10             	add    $0x10,%esp
80105837:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105839:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010583b:	0f 85 65 ff ff ff    	jne    801057a6 <sys_open+0x76>
      end_op();
80105841:	e8 da d3 ff ff       	call   80102c20 <end_op>
      return -1;
80105846:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010584b:	eb c0                	jmp    8010580d <sys_open+0xdd>
8010584d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105850:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105853:	85 c9                	test   %ecx,%ecx
80105855:	0f 84 4b ff ff ff    	je     801057a6 <sys_open+0x76>
    iunlockput(ip);
8010585b:	83 ec 0c             	sub    $0xc,%esp
8010585e:	56                   	push   %esi
8010585f:	e8 bc c0 ff ff       	call   80101920 <iunlockput>
    end_op();
80105864:	e8 b7 d3 ff ff       	call   80102c20 <end_op>
    return -1;
80105869:	83 c4 10             	add    $0x10,%esp
8010586c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105871:	eb 9a                	jmp    8010580d <sys_open+0xdd>
80105873:	90                   	nop
80105874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105878:	83 ec 0c             	sub    $0xc,%esp
8010587b:	57                   	push   %edi
8010587c:	e8 bf b5 ff ff       	call   80100e40 <fileclose>
80105881:	83 c4 10             	add    $0x10,%esp
80105884:	eb d5                	jmp    8010585b <sys_open+0x12b>
80105886:	8d 76 00             	lea    0x0(%esi),%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105890 <sys_mkdir>:

int
sys_mkdir(void)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105896:	e8 15 d3 ff ff       	call   80102bb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010589b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010589e:	83 ec 08             	sub    $0x8,%esp
801058a1:	50                   	push   %eax
801058a2:	6a 00                	push   $0x0
801058a4:	e8 c7 f6 ff ff       	call   80104f70 <argstr>
801058a9:	83 c4 10             	add    $0x10,%esp
801058ac:	85 c0                	test   %eax,%eax
801058ae:	78 30                	js     801058e0 <sys_mkdir+0x50>
801058b0:	83 ec 0c             	sub    $0xc,%esp
801058b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058b6:	31 c9                	xor    %ecx,%ecx
801058b8:	6a 00                	push   $0x0
801058ba:	ba 01 00 00 00       	mov    $0x1,%edx
801058bf:	e8 5c f7 ff ff       	call   80105020 <create>
801058c4:	83 c4 10             	add    $0x10,%esp
801058c7:	85 c0                	test   %eax,%eax
801058c9:	74 15                	je     801058e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801058cb:	83 ec 0c             	sub    $0xc,%esp
801058ce:	50                   	push   %eax
801058cf:	e8 4c c0 ff ff       	call   80101920 <iunlockput>
  end_op();
801058d4:	e8 47 d3 ff ff       	call   80102c20 <end_op>
  return 0;
801058d9:	83 c4 10             	add    $0x10,%esp
801058dc:	31 c0                	xor    %eax,%eax
}
801058de:	c9                   	leave  
801058df:	c3                   	ret    
    end_op();
801058e0:	e8 3b d3 ff ff       	call   80102c20 <end_op>
    return -1;
801058e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058ea:	c9                   	leave  
801058eb:	c3                   	ret    
801058ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058f0 <sys_mknod>:

int
sys_mknod(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801058f6:	e8 b5 d2 ff ff       	call   80102bb0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801058fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801058fe:	83 ec 08             	sub    $0x8,%esp
80105901:	50                   	push   %eax
80105902:	6a 00                	push   $0x0
80105904:	e8 67 f6 ff ff       	call   80104f70 <argstr>
80105909:	83 c4 10             	add    $0x10,%esp
8010590c:	85 c0                	test   %eax,%eax
8010590e:	78 60                	js     80105970 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105910:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105913:	83 ec 08             	sub    $0x8,%esp
80105916:	50                   	push   %eax
80105917:	6a 01                	push   $0x1
80105919:	e8 a2 f5 ff ff       	call   80104ec0 <argint>
  if((argstr(0, &path)) < 0 ||
8010591e:	83 c4 10             	add    $0x10,%esp
80105921:	85 c0                	test   %eax,%eax
80105923:	78 4b                	js     80105970 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105925:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105928:	83 ec 08             	sub    $0x8,%esp
8010592b:	50                   	push   %eax
8010592c:	6a 02                	push   $0x2
8010592e:	e8 8d f5 ff ff       	call   80104ec0 <argint>
     argint(1, &major) < 0 ||
80105933:	83 c4 10             	add    $0x10,%esp
80105936:	85 c0                	test   %eax,%eax
80105938:	78 36                	js     80105970 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010593a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010593e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105941:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105945:	ba 03 00 00 00       	mov    $0x3,%edx
8010594a:	50                   	push   %eax
8010594b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010594e:	e8 cd f6 ff ff       	call   80105020 <create>
80105953:	83 c4 10             	add    $0x10,%esp
80105956:	85 c0                	test   %eax,%eax
80105958:	74 16                	je     80105970 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010595a:	83 ec 0c             	sub    $0xc,%esp
8010595d:	50                   	push   %eax
8010595e:	e8 bd bf ff ff       	call   80101920 <iunlockput>
  end_op();
80105963:	e8 b8 d2 ff ff       	call   80102c20 <end_op>
  return 0;
80105968:	83 c4 10             	add    $0x10,%esp
8010596b:	31 c0                	xor    %eax,%eax
}
8010596d:	c9                   	leave  
8010596e:	c3                   	ret    
8010596f:	90                   	nop
    end_op();
80105970:	e8 ab d2 ff ff       	call   80102c20 <end_op>
    return -1;
80105975:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010597a:	c9                   	leave  
8010597b:	c3                   	ret    
8010597c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105980 <sys_chdir>:

int
sys_chdir(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	56                   	push   %esi
80105984:	53                   	push   %ebx
80105985:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105988:	e8 d3 e1 ff ff       	call   80103b60 <myproc>
8010598d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010598f:	e8 1c d2 ff ff       	call   80102bb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105994:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105997:	83 ec 08             	sub    $0x8,%esp
8010599a:	50                   	push   %eax
8010599b:	6a 00                	push   $0x0
8010599d:	e8 ce f5 ff ff       	call   80104f70 <argstr>
801059a2:	83 c4 10             	add    $0x10,%esp
801059a5:	85 c0                	test   %eax,%eax
801059a7:	78 77                	js     80105a20 <sys_chdir+0xa0>
801059a9:	83 ec 0c             	sub    $0xc,%esp
801059ac:	ff 75 f4             	pushl  -0xc(%ebp)
801059af:	e8 3c c5 ff ff       	call   80101ef0 <namei>
801059b4:	83 c4 10             	add    $0x10,%esp
801059b7:	85 c0                	test   %eax,%eax
801059b9:	89 c3                	mov    %eax,%ebx
801059bb:	74 63                	je     80105a20 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801059bd:	83 ec 0c             	sub    $0xc,%esp
801059c0:	50                   	push   %eax
801059c1:	e8 ca bc ff ff       	call   80101690 <ilock>
  if(ip->type != T_DIR){
801059c6:	83 c4 10             	add    $0x10,%esp
801059c9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801059ce:	75 30                	jne    80105a00 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801059d0:	83 ec 0c             	sub    $0xc,%esp
801059d3:	53                   	push   %ebx
801059d4:	e8 97 bd ff ff       	call   80101770 <iunlock>
  iput(curproc->cwd);
801059d9:	58                   	pop    %eax
801059da:	ff 76 68             	pushl  0x68(%esi)
801059dd:	e8 de bd ff ff       	call   801017c0 <iput>
  end_op();
801059e2:	e8 39 d2 ff ff       	call   80102c20 <end_op>
  curproc->cwd = ip;
801059e7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801059ea:	83 c4 10             	add    $0x10,%esp
801059ed:	31 c0                	xor    %eax,%eax
}
801059ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059f2:	5b                   	pop    %ebx
801059f3:	5e                   	pop    %esi
801059f4:	5d                   	pop    %ebp
801059f5:	c3                   	ret    
801059f6:	8d 76 00             	lea    0x0(%esi),%esi
801059f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105a00:	83 ec 0c             	sub    $0xc,%esp
80105a03:	53                   	push   %ebx
80105a04:	e8 17 bf ff ff       	call   80101920 <iunlockput>
    end_op();
80105a09:	e8 12 d2 ff ff       	call   80102c20 <end_op>
    return -1;
80105a0e:	83 c4 10             	add    $0x10,%esp
80105a11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a16:	eb d7                	jmp    801059ef <sys_chdir+0x6f>
80105a18:	90                   	nop
80105a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105a20:	e8 fb d1 ff ff       	call   80102c20 <end_op>
    return -1;
80105a25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a2a:	eb c3                	jmp    801059ef <sys_chdir+0x6f>
80105a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a30 <sys_exec>:

int
sys_exec(void)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	57                   	push   %edi
80105a34:	56                   	push   %esi
80105a35:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105a36:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105a3c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105a42:	50                   	push   %eax
80105a43:	6a 00                	push   $0x0
80105a45:	e8 26 f5 ff ff       	call   80104f70 <argstr>
80105a4a:	83 c4 10             	add    $0x10,%esp
80105a4d:	85 c0                	test   %eax,%eax
80105a4f:	0f 88 87 00 00 00    	js     80105adc <sys_exec+0xac>
80105a55:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105a5b:	83 ec 08             	sub    $0x8,%esp
80105a5e:	50                   	push   %eax
80105a5f:	6a 01                	push   $0x1
80105a61:	e8 5a f4 ff ff       	call   80104ec0 <argint>
80105a66:	83 c4 10             	add    $0x10,%esp
80105a69:	85 c0                	test   %eax,%eax
80105a6b:	78 6f                	js     80105adc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105a6d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105a73:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105a76:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105a78:	68 80 00 00 00       	push   $0x80
80105a7d:	6a 00                	push   $0x0
80105a7f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105a85:	50                   	push   %eax
80105a86:	e8 35 f1 ff ff       	call   80104bc0 <memset>
80105a8b:	83 c4 10             	add    $0x10,%esp
80105a8e:	eb 2c                	jmp    80105abc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105a90:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105a96:	85 c0                	test   %eax,%eax
80105a98:	74 56                	je     80105af0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105a9a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105aa0:	83 ec 08             	sub    $0x8,%esp
80105aa3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105aa6:	52                   	push   %edx
80105aa7:	50                   	push   %eax
80105aa8:	e8 a3 f3 ff ff       	call   80104e50 <fetchstr>
80105aad:	83 c4 10             	add    $0x10,%esp
80105ab0:	85 c0                	test   %eax,%eax
80105ab2:	78 28                	js     80105adc <sys_exec+0xac>
  for(i=0;; i++){
80105ab4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105ab7:	83 fb 20             	cmp    $0x20,%ebx
80105aba:	74 20                	je     80105adc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105abc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105ac2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105ac9:	83 ec 08             	sub    $0x8,%esp
80105acc:	57                   	push   %edi
80105acd:	01 f0                	add    %esi,%eax
80105acf:	50                   	push   %eax
80105ad0:	e8 3b f3 ff ff       	call   80104e10 <fetchint>
80105ad5:	83 c4 10             	add    $0x10,%esp
80105ad8:	85 c0                	test   %eax,%eax
80105ada:	79 b4                	jns    80105a90 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105adc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105adf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ae4:	5b                   	pop    %ebx
80105ae5:	5e                   	pop    %esi
80105ae6:	5f                   	pop    %edi
80105ae7:	5d                   	pop    %ebp
80105ae8:	c3                   	ret    
80105ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105af0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105af6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105af9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105b00:	00 00 00 00 
  return exec(path, argv);
80105b04:	50                   	push   %eax
80105b05:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105b0b:	e8 00 af ff ff       	call   80100a10 <exec>
80105b10:	83 c4 10             	add    $0x10,%esp
}
80105b13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b16:	5b                   	pop    %ebx
80105b17:	5e                   	pop    %esi
80105b18:	5f                   	pop    %edi
80105b19:	5d                   	pop    %ebp
80105b1a:	c3                   	ret    
80105b1b:	90                   	nop
80105b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b20 <sys_pipe>:

int
sys_pipe(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	57                   	push   %edi
80105b24:	56                   	push   %esi
80105b25:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105b26:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105b29:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105b2c:	6a 08                	push   $0x8
80105b2e:	50                   	push   %eax
80105b2f:	6a 00                	push   $0x0
80105b31:	e8 da f3 ff ff       	call   80104f10 <argptr>
80105b36:	83 c4 10             	add    $0x10,%esp
80105b39:	85 c0                	test   %eax,%eax
80105b3b:	0f 88 ae 00 00 00    	js     80105bef <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105b41:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105b44:	83 ec 08             	sub    $0x8,%esp
80105b47:	50                   	push   %eax
80105b48:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105b4b:	50                   	push   %eax
80105b4c:	e8 ff d6 ff ff       	call   80103250 <pipealloc>
80105b51:	83 c4 10             	add    $0x10,%esp
80105b54:	85 c0                	test   %eax,%eax
80105b56:	0f 88 93 00 00 00    	js     80105bef <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105b5c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105b5f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105b61:	e8 fa df ff ff       	call   80103b60 <myproc>
80105b66:	eb 10                	jmp    80105b78 <sys_pipe+0x58>
80105b68:	90                   	nop
80105b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105b70:	83 c3 01             	add    $0x1,%ebx
80105b73:	83 fb 10             	cmp    $0x10,%ebx
80105b76:	74 60                	je     80105bd8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105b78:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105b7c:	85 f6                	test   %esi,%esi
80105b7e:	75 f0                	jne    80105b70 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105b80:	8d 73 08             	lea    0x8(%ebx),%esi
80105b83:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105b87:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105b8a:	e8 d1 df ff ff       	call   80103b60 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105b8f:	31 d2                	xor    %edx,%edx
80105b91:	eb 0d                	jmp    80105ba0 <sys_pipe+0x80>
80105b93:	90                   	nop
80105b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b98:	83 c2 01             	add    $0x1,%edx
80105b9b:	83 fa 10             	cmp    $0x10,%edx
80105b9e:	74 28                	je     80105bc8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105ba0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105ba4:	85 c9                	test   %ecx,%ecx
80105ba6:	75 f0                	jne    80105b98 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105ba8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105bac:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105baf:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105bb1:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105bb4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105bb7:	31 c0                	xor    %eax,%eax
}
80105bb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bbc:	5b                   	pop    %ebx
80105bbd:	5e                   	pop    %esi
80105bbe:	5f                   	pop    %edi
80105bbf:	5d                   	pop    %ebp
80105bc0:	c3                   	ret    
80105bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105bc8:	e8 93 df ff ff       	call   80103b60 <myproc>
80105bcd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105bd4:	00 
80105bd5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105bd8:	83 ec 0c             	sub    $0xc,%esp
80105bdb:	ff 75 e0             	pushl  -0x20(%ebp)
80105bde:	e8 5d b2 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80105be3:	58                   	pop    %eax
80105be4:	ff 75 e4             	pushl  -0x1c(%ebp)
80105be7:	e8 54 b2 ff ff       	call   80100e40 <fileclose>
    return -1;
80105bec:	83 c4 10             	add    $0x10,%esp
80105bef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bf4:	eb c3                	jmp    80105bb9 <sys_pipe+0x99>
80105bf6:	66 90                	xchg   %ax,%ax
80105bf8:	66 90                	xchg   %ax,%ax
80105bfa:	66 90                	xchg   %ax,%ax
80105bfc:	66 90                	xchg   %ax,%ax
80105bfe:	66 90                	xchg   %ax,%ax

80105c00 <sys_sigset>:
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int sys_sigset(void) {
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	83 ec 20             	sub    $0x20,%esp
  int sighandler;
  argint(0, &sighandler);
80105c06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c09:	50                   	push   %eax
80105c0a:	6a 00                	push   $0x0
80105c0c:	e8 af f2 ff ff       	call   80104ec0 <argint>
  return (int) sigset((sig_handler)sighandler);
80105c11:	58                   	pop    %eax
80105c12:	ff 75 f4             	pushl  -0xc(%ebp)
80105c15:	e8 76 ea ff ff       	call   80104690 <sigset>
}
80105c1a:	c9                   	leave  
80105c1b:	c3                   	ret    
80105c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c20 <sys_sigsend>:

int sys_sigsend(int dest_pid,int msg) {
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	83 ec 10             	sub    $0x10,%esp
  argint(0, &dest_pid);
80105c26:	8d 45 08             	lea    0x8(%ebp),%eax
80105c29:	50                   	push   %eax
80105c2a:	6a 00                	push   $0x0
80105c2c:	e8 8f f2 ff ff       	call   80104ec0 <argint>
  argint(1, &msg);
80105c31:	58                   	pop    %eax
80105c32:	8d 45 0c             	lea    0xc(%ebp),%eax
80105c35:	5a                   	pop    %edx
80105c36:	50                   	push   %eax
80105c37:	6a 01                	push   $0x1
80105c39:	e8 82 f2 ff ff       	call   80104ec0 <argint>
  return sigsend(dest_pid, msg);
80105c3e:	59                   	pop    %ecx
80105c3f:	58                   	pop    %eax
80105c40:	ff 75 0c             	pushl  0xc(%ebp)
80105c43:	ff 75 08             	pushl  0x8(%ebp)
80105c46:	e8 75 ea ff ff       	call   801046c0 <sigsend>
}
80105c4b:	c9                   	leave  
80105c4c:	c3                   	ret    
80105c4d:	8d 76 00             	lea    0x0(%esi),%esi

80105c50 <sys_send_multi>:

int sys_send_multi(void) {
80105c50:	55                   	push   %ebp
  // argint(3,&length);
  // for(int i=0;i<length;i++)
  //   sys_sigsend(rec_pids[i],(int)msg);
  // popcli();
  return 0;
}
80105c51:	31 c0                	xor    %eax,%eax
int sys_send_multi(void) {
80105c53:	89 e5                	mov    %esp,%ebp
}
80105c55:	5d                   	pop    %ebp
80105c56:	c3                   	ret    
80105c57:	89 f6                	mov    %esi,%esi
80105c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c60 <sys_sigret>:

int sys_sigret(void) {
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	83 ec 08             	sub    $0x8,%esp
  sigret();
80105c66:	e8 05 eb ff ff       	call   80104770 <sigret>
  return 1;
}
80105c6b:	b8 01 00 00 00       	mov    $0x1,%eax
80105c70:	c9                   	leave  
80105c71:	c3                   	ret    
80105c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c80 <sys_sigpause>:

int sys_sigpause(void) {
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	83 ec 08             	sub    $0x8,%esp
  sigpause();
80105c86:	e8 25 eb ff ff       	call   801047b0 <sigpause>
  return 1;
}
80105c8b:	b8 01 00 00 00       	mov    $0x1,%eax
80105c90:	c9                   	leave  
80105c91:	c3                   	ret    
80105c92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ca0 <sys_toggle>:

int sys_toggle(void){
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	83 ec 08             	sub    $0x8,%esp
   toggle();
80105ca6:	e8 85 dc ff ff       	call   80103930 <toggle>
   return 0;
}
80105cab:	31 c0                	xor    %eax,%eax
80105cad:	c9                   	leave  
80105cae:	c3                   	ret    
80105caf:	90                   	nop

80105cb0 <sys_print_count>:

int sys_print_count(void){
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	83 ec 08             	sub    $0x8,%esp
    print_count();
80105cb6:	e8 c5 dc ff ff       	call   80103980 <print_count>
    return 0;
}
80105cbb:	31 c0                	xor    %eax,%eax
80105cbd:	c9                   	leave  
80105cbe:	c3                   	ret    
80105cbf:	90                   	nop

80105cc0 <sys_add>:

int sys_add(void){
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
   return add();
}
80105cc3:	5d                   	pop    %ebp
   return add();
80105cc4:	e9 17 dd ff ff       	jmp    801039e0 <add>
80105cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cd0 <sys_ps>:

int sys_ps(void){
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 08             	sub    $0x8,%esp
   ps();
80105cd6:	e8 35 dd ff ff       	call   80103a10 <ps>
   return 0;
}
80105cdb:	31 c0                	xor    %eax,%eax
80105cdd:	c9                   	leave  
80105cde:	c3                   	ret    
80105cdf:	90                   	nop

80105ce0 <sys_send>:

int sys_send(void){
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
  return send();
}
80105ce3:	5d                   	pop    %ebp
  return send();
80105ce4:	e9 d7 da ff ff       	jmp    801037c0 <send>
80105ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cf0 <sys_recv>:

int sys_recv(void){
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
  return recv();
}
80105cf3:	5d                   	pop    %ebp
  return recv();
80105cf4:	e9 77 e3 ff ff       	jmp    80104070 <recv>
80105cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d00 <sys_fork>:

int
sys_fork(void)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105d03:	5d                   	pop    %ebp
  return fork();
80105d04:	e9 f7 df ff ff       	jmp    80103d00 <fork>
80105d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d10 <sys_exit>:

int
sys_exit(void)
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	83 ec 08             	sub    $0x8,%esp
  exit();
80105d16:	e8 85 e4 ff ff       	call   801041a0 <exit>
  return 0;  // not reached
}
80105d1b:	31 c0                	xor    %eax,%eax
80105d1d:	c9                   	leave  
80105d1e:	c3                   	ret    
80105d1f:	90                   	nop

80105d20 <sys_wait>:

int
sys_wait(void)
{
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105d23:	5d                   	pop    %ebp
  return wait();
80105d24:	e9 b7 e6 ff ff       	jmp    801043e0 <wait>
80105d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d30 <sys_kill>:

int
sys_kill(void)
{
80105d30:	55                   	push   %ebp
80105d31:	89 e5                	mov    %esp,%ebp
80105d33:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105d36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d39:	50                   	push   %eax
80105d3a:	6a 00                	push   $0x0
80105d3c:	e8 7f f1 ff ff       	call   80104ec0 <argint>
80105d41:	83 c4 10             	add    $0x10,%esp
80105d44:	85 c0                	test   %eax,%eax
80105d46:	78 18                	js     80105d60 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105d48:	83 ec 0c             	sub    $0xc,%esp
80105d4b:	ff 75 f4             	pushl  -0xc(%ebp)
80105d4e:	e8 ed e7 ff ff       	call   80104540 <kill>
80105d53:	83 c4 10             	add    $0x10,%esp
}
80105d56:	c9                   	leave  
80105d57:	c3                   	ret    
80105d58:	90                   	nop
80105d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d65:	c9                   	leave  
80105d66:	c3                   	ret    
80105d67:	89 f6                	mov    %esi,%esi
80105d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d70 <sys_getpid>:

int
sys_getpid(void)
{
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
80105d73:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105d76:	e8 e5 dd ff ff       	call   80103b60 <myproc>
80105d7b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105d7e:	c9                   	leave  
80105d7f:	c3                   	ret    

80105d80 <sys_sbrk>:

int
sys_sbrk(void)
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105d84:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105d87:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105d8a:	50                   	push   %eax
80105d8b:	6a 00                	push   $0x0
80105d8d:	e8 2e f1 ff ff       	call   80104ec0 <argint>
80105d92:	83 c4 10             	add    $0x10,%esp
80105d95:	85 c0                	test   %eax,%eax
80105d97:	78 27                	js     80105dc0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105d99:	e8 c2 dd ff ff       	call   80103b60 <myproc>
  if(growproc(n) < 0)
80105d9e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105da1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105da3:	ff 75 f4             	pushl  -0xc(%ebp)
80105da6:	e8 d5 de ff ff       	call   80103c80 <growproc>
80105dab:	83 c4 10             	add    $0x10,%esp
80105dae:	85 c0                	test   %eax,%eax
80105db0:	78 0e                	js     80105dc0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105db2:	89 d8                	mov    %ebx,%eax
80105db4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105db7:	c9                   	leave  
80105db8:	c3                   	ret    
80105db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105dc0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105dc5:	eb eb                	jmp    80105db2 <sys_sbrk+0x32>
80105dc7:	89 f6                	mov    %esi,%esi
80105dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105dd0 <sys_sleep>:

int
sys_sleep(void)
{
80105dd0:	55                   	push   %ebp
80105dd1:	89 e5                	mov    %esp,%ebp
80105dd3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105dd4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105dd7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105dda:	50                   	push   %eax
80105ddb:	6a 00                	push   $0x0
80105ddd:	e8 de f0 ff ff       	call   80104ec0 <argint>
80105de2:	83 c4 10             	add    $0x10,%esp
80105de5:	85 c0                	test   %eax,%eax
80105de7:	0f 88 8a 00 00 00    	js     80105e77 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105ded:	83 ec 0c             	sub    $0xc,%esp
80105df0:	68 c0 31 13 80       	push   $0x801331c0
80105df5:	e8 b6 ec ff ff       	call   80104ab0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105dfa:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105dfd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105e00:	8b 1d 00 3a 13 80    	mov    0x80133a00,%ebx
  while(ticks - ticks0 < n){
80105e06:	85 d2                	test   %edx,%edx
80105e08:	75 27                	jne    80105e31 <sys_sleep+0x61>
80105e0a:	eb 54                	jmp    80105e60 <sys_sleep+0x90>
80105e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105e10:	83 ec 08             	sub    $0x8,%esp
80105e13:	68 c0 31 13 80       	push   $0x801331c0
80105e18:	68 00 3a 13 80       	push   $0x80133a00
80105e1d:	e8 fe e4 ff ff       	call   80104320 <sleep>
  while(ticks - ticks0 < n){
80105e22:	a1 00 3a 13 80       	mov    0x80133a00,%eax
80105e27:	83 c4 10             	add    $0x10,%esp
80105e2a:	29 d8                	sub    %ebx,%eax
80105e2c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105e2f:	73 2f                	jae    80105e60 <sys_sleep+0x90>
    if(myproc()->killed){
80105e31:	e8 2a dd ff ff       	call   80103b60 <myproc>
80105e36:	8b 40 24             	mov    0x24(%eax),%eax
80105e39:	85 c0                	test   %eax,%eax
80105e3b:	74 d3                	je     80105e10 <sys_sleep+0x40>
      release(&tickslock);
80105e3d:	83 ec 0c             	sub    $0xc,%esp
80105e40:	68 c0 31 13 80       	push   $0x801331c0
80105e45:	e8 26 ed ff ff       	call   80104b70 <release>
      return -1;
80105e4a:	83 c4 10             	add    $0x10,%esp
80105e4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105e52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e55:	c9                   	leave  
80105e56:	c3                   	ret    
80105e57:	89 f6                	mov    %esi,%esi
80105e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105e60:	83 ec 0c             	sub    $0xc,%esp
80105e63:	68 c0 31 13 80       	push   $0x801331c0
80105e68:	e8 03 ed ff ff       	call   80104b70 <release>
  return 0;
80105e6d:	83 c4 10             	add    $0x10,%esp
80105e70:	31 c0                	xor    %eax,%eax
}
80105e72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e75:	c9                   	leave  
80105e76:	c3                   	ret    
    return -1;
80105e77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e7c:	eb f4                	jmp    80105e72 <sys_sleep+0xa2>
80105e7e:	66 90                	xchg   %ax,%ax

80105e80 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105e80:	55                   	push   %ebp
80105e81:	89 e5                	mov    %esp,%ebp
80105e83:	53                   	push   %ebx
80105e84:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105e87:	68 c0 31 13 80       	push   $0x801331c0
80105e8c:	e8 1f ec ff ff       	call   80104ab0 <acquire>
  xticks = ticks;
80105e91:	8b 1d 00 3a 13 80    	mov    0x80133a00,%ebx
  release(&tickslock);
80105e97:	c7 04 24 c0 31 13 80 	movl   $0x801331c0,(%esp)
80105e9e:	e8 cd ec ff ff       	call   80104b70 <release>
  return xticks;
}
80105ea3:	89 d8                	mov    %ebx,%eax
80105ea5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ea8:	c9                   	leave  
80105ea9:	c3                   	ret    

80105eaa <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105eaa:	1e                   	push   %ds
  pushl %es
80105eab:	06                   	push   %es
  pushl %fs
80105eac:	0f a0                	push   %fs
  pushl %gs
80105eae:	0f a8                	push   %gs
  pushal
80105eb0:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105eb1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105eb5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105eb7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105eb9:	54                   	push   %esp
  call trap
80105eba:	e8 d1 00 00 00       	call   80105f90 <trap>
  addl $4, %esp
80105ebf:	83 c4 04             	add    $0x4,%esp

80105ec2 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  pushl %esp
80105ec2:	54                   	push   %esp
  call checkSignals  // Check for pending signals, and handle if not already handling.
80105ec3:	e8 f8 df ff ff       	call   80103ec0 <checkSignals>
  addl $4, %esp
80105ec8:	83 c4 04             	add    $0x4,%esp
  popal
80105ecb:	61                   	popa   
  popl %gs
80105ecc:	0f a9                	pop    %gs
  popl %fs
80105ece:	0f a1                	pop    %fs
  popl %es
80105ed0:	07                   	pop    %es
  popl %ds
80105ed1:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105ed2:	83 c4 08             	add    $0x8,%esp
  iret
80105ed5:	cf                   	iret   
80105ed6:	66 90                	xchg   %ax,%ax
80105ed8:	66 90                	xchg   %ax,%ax
80105eda:	66 90                	xchg   %ax,%ax
80105edc:	66 90                	xchg   %ax,%ax
80105ede:	66 90                	xchg   %ax,%ax

80105ee0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105ee0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105ee1:	31 c0                	xor    %eax,%eax
{
80105ee3:	89 e5                	mov    %esp,%ebp
80105ee5:	83 ec 08             	sub    $0x8,%esp
80105ee8:	90                   	nop
80105ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105ef0:	8b 14 85 b4 b2 10 80 	mov    -0x7fef4d4c(,%eax,4),%edx
80105ef7:	c7 04 c5 02 32 13 80 	movl   $0x8e000008,-0x7feccdfe(,%eax,8)
80105efe:	08 00 00 8e 
80105f02:	66 89 14 c5 00 32 13 	mov    %dx,-0x7fecce00(,%eax,8)
80105f09:	80 
80105f0a:	c1 ea 10             	shr    $0x10,%edx
80105f0d:	66 89 14 c5 06 32 13 	mov    %dx,-0x7feccdfa(,%eax,8)
80105f14:	80 
  for(i = 0; i < 256; i++)
80105f15:	83 c0 01             	add    $0x1,%eax
80105f18:	3d 00 01 00 00       	cmp    $0x100,%eax
80105f1d:	75 d1                	jne    80105ef0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105f1f:	a1 b4 b3 10 80       	mov    0x8010b3b4,%eax

  initlock(&tickslock, "time");
80105f24:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105f27:	c7 05 02 34 13 80 08 	movl   $0xef000008,0x80133402
80105f2e:	00 00 ef 
  initlock(&tickslock, "time");
80105f31:	68 65 7f 10 80       	push   $0x80107f65
80105f36:	68 c0 31 13 80       	push   $0x801331c0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105f3b:	66 a3 00 34 13 80    	mov    %ax,0x80133400
80105f41:	c1 e8 10             	shr    $0x10,%eax
80105f44:	66 a3 06 34 13 80    	mov    %ax,0x80133406
  initlock(&tickslock, "time");
80105f4a:	e8 21 ea ff ff       	call   80104970 <initlock>
}
80105f4f:	83 c4 10             	add    $0x10,%esp
80105f52:	c9                   	leave  
80105f53:	c3                   	ret    
80105f54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105f60 <idtinit>:

void
idtinit(void)
{
80105f60:	55                   	push   %ebp
  pd[0] = size-1;
80105f61:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105f66:	89 e5                	mov    %esp,%ebp
80105f68:	83 ec 10             	sub    $0x10,%esp
80105f6b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105f6f:	b8 00 32 13 80       	mov    $0x80133200,%eax
80105f74:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105f78:	c1 e8 10             	shr    $0x10,%eax
80105f7b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105f7f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105f82:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105f85:	c9                   	leave  
80105f86:	c3                   	ret    
80105f87:	89 f6                	mov    %esi,%esi
80105f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f90 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105f90:	55                   	push   %ebp
80105f91:	89 e5                	mov    %esp,%ebp
80105f93:	57                   	push   %edi
80105f94:	56                   	push   %esi
80105f95:	53                   	push   %ebx
80105f96:	83 ec 1c             	sub    $0x1c,%esp
80105f99:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105f9c:	8b 47 30             	mov    0x30(%edi),%eax
80105f9f:	83 f8 40             	cmp    $0x40,%eax
80105fa2:	0f 84 f0 00 00 00    	je     80106098 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105fa8:	83 e8 20             	sub    $0x20,%eax
80105fab:	83 f8 1f             	cmp    $0x1f,%eax
80105fae:	77 10                	ja     80105fc0 <trap+0x30>
80105fb0:	ff 24 85 0c 80 10 80 	jmp    *-0x7fef7ff4(,%eax,4)
80105fb7:	89 f6                	mov    %esi,%esi
80105fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105fc0:	e8 9b db ff ff       	call   80103b60 <myproc>
80105fc5:	85 c0                	test   %eax,%eax
80105fc7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105fca:	0f 84 14 02 00 00    	je     801061e4 <trap+0x254>
80105fd0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105fd4:	0f 84 0a 02 00 00    	je     801061e4 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105fda:	0f 20 d1             	mov    %cr2,%ecx
80105fdd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105fe0:	e8 5b db ff ff       	call   80103b40 <cpuid>
80105fe5:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105fe8:	8b 47 34             	mov    0x34(%edi),%eax
80105feb:	8b 77 30             	mov    0x30(%edi),%esi
80105fee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105ff1:	e8 6a db ff ff       	call   80103b60 <myproc>
80105ff6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ff9:	e8 62 db ff ff       	call   80103b60 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ffe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106001:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106004:	51                   	push   %ecx
80106005:	53                   	push   %ebx
80106006:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80106007:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010600a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010600d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010600e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106011:	52                   	push   %edx
80106012:	ff 70 10             	pushl  0x10(%eax)
80106015:	68 c8 7f 10 80       	push   $0x80107fc8
8010601a:	e8 41 a6 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010601f:	83 c4 20             	add    $0x20,%esp
80106022:	e8 39 db ff ff       	call   80103b60 <myproc>
80106027:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010602e:	e8 2d db ff ff       	call   80103b60 <myproc>
80106033:	85 c0                	test   %eax,%eax
80106035:	74 1d                	je     80106054 <trap+0xc4>
80106037:	e8 24 db ff ff       	call   80103b60 <myproc>
8010603c:	8b 50 24             	mov    0x24(%eax),%edx
8010603f:	85 d2                	test   %edx,%edx
80106041:	74 11                	je     80106054 <trap+0xc4>
80106043:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106047:	83 e0 03             	and    $0x3,%eax
8010604a:	66 83 f8 03          	cmp    $0x3,%ax
8010604e:	0f 84 4c 01 00 00    	je     801061a0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106054:	e8 07 db ff ff       	call   80103b60 <myproc>
80106059:	85 c0                	test   %eax,%eax
8010605b:	74 0b                	je     80106068 <trap+0xd8>
8010605d:	e8 fe da ff ff       	call   80103b60 <myproc>
80106062:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106066:	74 68                	je     801060d0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106068:	e8 f3 da ff ff       	call   80103b60 <myproc>
8010606d:	85 c0                	test   %eax,%eax
8010606f:	74 19                	je     8010608a <trap+0xfa>
80106071:	e8 ea da ff ff       	call   80103b60 <myproc>
80106076:	8b 40 24             	mov    0x24(%eax),%eax
80106079:	85 c0                	test   %eax,%eax
8010607b:	74 0d                	je     8010608a <trap+0xfa>
8010607d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106081:	83 e0 03             	and    $0x3,%eax
80106084:	66 83 f8 03          	cmp    $0x3,%ax
80106088:	74 37                	je     801060c1 <trap+0x131>
    exit();
}
8010608a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010608d:	5b                   	pop    %ebx
8010608e:	5e                   	pop    %esi
8010608f:	5f                   	pop    %edi
80106090:	5d                   	pop    %ebp
80106091:	c3                   	ret    
80106092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80106098:	e8 c3 da ff ff       	call   80103b60 <myproc>
8010609d:	8b 58 24             	mov    0x24(%eax),%ebx
801060a0:	85 db                	test   %ebx,%ebx
801060a2:	0f 85 e8 00 00 00    	jne    80106190 <trap+0x200>
    myproc()->tf = tf;
801060a8:	e8 b3 da ff ff       	call   80103b60 <myproc>
801060ad:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801060b0:	e8 fb ee ff ff       	call   80104fb0 <syscall>
    if(myproc()->killed)
801060b5:	e8 a6 da ff ff       	call   80103b60 <myproc>
801060ba:	8b 48 24             	mov    0x24(%eax),%ecx
801060bd:	85 c9                	test   %ecx,%ecx
801060bf:	74 c9                	je     8010608a <trap+0xfa>
}
801060c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060c4:	5b                   	pop    %ebx
801060c5:	5e                   	pop    %esi
801060c6:	5f                   	pop    %edi
801060c7:	5d                   	pop    %ebp
      exit();
801060c8:	e9 d3 e0 ff ff       	jmp    801041a0 <exit>
801060cd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
801060d0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801060d4:	75 92                	jne    80106068 <trap+0xd8>
    yield();
801060d6:	e8 f5 e1 ff ff       	call   801042d0 <yield>
801060db:	eb 8b                	jmp    80106068 <trap+0xd8>
801060dd:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
801060e0:	e8 5b da ff ff       	call   80103b40 <cpuid>
801060e5:	85 c0                	test   %eax,%eax
801060e7:	0f 84 c3 00 00 00    	je     801061b0 <trap+0x220>
    lapiceoi();
801060ed:	e8 6e c6 ff ff       	call   80102760 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801060f2:	e8 69 da ff ff       	call   80103b60 <myproc>
801060f7:	85 c0                	test   %eax,%eax
801060f9:	0f 85 38 ff ff ff    	jne    80106037 <trap+0xa7>
801060ff:	e9 50 ff ff ff       	jmp    80106054 <trap+0xc4>
80106104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106108:	e8 13 c5 ff ff       	call   80102620 <kbdintr>
    lapiceoi();
8010610d:	e8 4e c6 ff ff       	call   80102760 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106112:	e8 49 da ff ff       	call   80103b60 <myproc>
80106117:	85 c0                	test   %eax,%eax
80106119:	0f 85 18 ff ff ff    	jne    80106037 <trap+0xa7>
8010611f:	e9 30 ff ff ff       	jmp    80106054 <trap+0xc4>
80106124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106128:	e8 53 02 00 00       	call   80106380 <uartintr>
    lapiceoi();
8010612d:	e8 2e c6 ff ff       	call   80102760 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106132:	e8 29 da ff ff       	call   80103b60 <myproc>
80106137:	85 c0                	test   %eax,%eax
80106139:	0f 85 f8 fe ff ff    	jne    80106037 <trap+0xa7>
8010613f:	e9 10 ff ff ff       	jmp    80106054 <trap+0xc4>
80106144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106148:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010614c:	8b 77 38             	mov    0x38(%edi),%esi
8010614f:	e8 ec d9 ff ff       	call   80103b40 <cpuid>
80106154:	56                   	push   %esi
80106155:	53                   	push   %ebx
80106156:	50                   	push   %eax
80106157:	68 70 7f 10 80       	push   $0x80107f70
8010615c:	e8 ff a4 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106161:	e8 fa c5 ff ff       	call   80102760 <lapiceoi>
    break;
80106166:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106169:	e8 f2 d9 ff ff       	call   80103b60 <myproc>
8010616e:	85 c0                	test   %eax,%eax
80106170:	0f 85 c1 fe ff ff    	jne    80106037 <trap+0xa7>
80106176:	e9 d9 fe ff ff       	jmp    80106054 <trap+0xc4>
8010617b:	90                   	nop
8010617c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106180:	e8 0b bf ff ff       	call   80102090 <ideintr>
80106185:	e9 63 ff ff ff       	jmp    801060ed <trap+0x15d>
8010618a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106190:	e8 0b e0 ff ff       	call   801041a0 <exit>
80106195:	e9 0e ff ff ff       	jmp    801060a8 <trap+0x118>
8010619a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
801061a0:	e8 fb df ff ff       	call   801041a0 <exit>
801061a5:	e9 aa fe ff ff       	jmp    80106054 <trap+0xc4>
801061aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801061b0:	83 ec 0c             	sub    $0xc,%esp
801061b3:	68 c0 31 13 80       	push   $0x801331c0
801061b8:	e8 f3 e8 ff ff       	call   80104ab0 <acquire>
      wakeup(&ticks);
801061bd:	c7 04 24 00 3a 13 80 	movl   $0x80133a00,(%esp)
      ticks++;
801061c4:	83 05 00 3a 13 80 01 	addl   $0x1,0x80133a00
      wakeup(&ticks);
801061cb:	e8 10 e3 ff ff       	call   801044e0 <wakeup>
      release(&tickslock);
801061d0:	c7 04 24 c0 31 13 80 	movl   $0x801331c0,(%esp)
801061d7:	e8 94 e9 ff ff       	call   80104b70 <release>
801061dc:	83 c4 10             	add    $0x10,%esp
801061df:	e9 09 ff ff ff       	jmp    801060ed <trap+0x15d>
801061e4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801061e7:	e8 54 d9 ff ff       	call   80103b40 <cpuid>
801061ec:	83 ec 0c             	sub    $0xc,%esp
801061ef:	56                   	push   %esi
801061f0:	53                   	push   %ebx
801061f1:	50                   	push   %eax
801061f2:	ff 77 30             	pushl  0x30(%edi)
801061f5:	68 94 7f 10 80       	push   $0x80107f94
801061fa:	e8 61 a4 ff ff       	call   80100660 <cprintf>
      panic("trap");
801061ff:	83 c4 14             	add    $0x14,%esp
80106202:	68 6a 7f 10 80       	push   $0x80107f6a
80106207:	e8 84 a1 ff ff       	call   80100390 <panic>
8010620c:	66 90                	xchg   %ax,%ax
8010620e:	66 90                	xchg   %ax,%ax

80106210 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106210:	a1 60 b8 10 80       	mov    0x8010b860,%eax
{
80106215:	55                   	push   %ebp
80106216:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106218:	85 c0                	test   %eax,%eax
8010621a:	74 1c                	je     80106238 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010621c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106221:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106222:	a8 01                	test   $0x1,%al
80106224:	74 12                	je     80106238 <uartgetc+0x28>
80106226:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010622b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010622c:	0f b6 c0             	movzbl %al,%eax
}
8010622f:	5d                   	pop    %ebp
80106230:	c3                   	ret    
80106231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010623d:	5d                   	pop    %ebp
8010623e:	c3                   	ret    
8010623f:	90                   	nop

80106240 <uartputc.part.0>:
uartputc(int c)
80106240:	55                   	push   %ebp
80106241:	89 e5                	mov    %esp,%ebp
80106243:	57                   	push   %edi
80106244:	56                   	push   %esi
80106245:	53                   	push   %ebx
80106246:	89 c7                	mov    %eax,%edi
80106248:	bb 80 00 00 00       	mov    $0x80,%ebx
8010624d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106252:	83 ec 0c             	sub    $0xc,%esp
80106255:	eb 1b                	jmp    80106272 <uartputc.part.0+0x32>
80106257:	89 f6                	mov    %esi,%esi
80106259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106260:	83 ec 0c             	sub    $0xc,%esp
80106263:	6a 0a                	push   $0xa
80106265:	e8 16 c5 ff ff       	call   80102780 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010626a:	83 c4 10             	add    $0x10,%esp
8010626d:	83 eb 01             	sub    $0x1,%ebx
80106270:	74 07                	je     80106279 <uartputc.part.0+0x39>
80106272:	89 f2                	mov    %esi,%edx
80106274:	ec                   	in     (%dx),%al
80106275:	a8 20                	test   $0x20,%al
80106277:	74 e7                	je     80106260 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106279:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010627e:	89 f8                	mov    %edi,%eax
80106280:	ee                   	out    %al,(%dx)
}
80106281:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106284:	5b                   	pop    %ebx
80106285:	5e                   	pop    %esi
80106286:	5f                   	pop    %edi
80106287:	5d                   	pop    %ebp
80106288:	c3                   	ret    
80106289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106290 <uartinit>:
{
80106290:	55                   	push   %ebp
80106291:	31 c9                	xor    %ecx,%ecx
80106293:	89 c8                	mov    %ecx,%eax
80106295:	89 e5                	mov    %esp,%ebp
80106297:	57                   	push   %edi
80106298:	56                   	push   %esi
80106299:	53                   	push   %ebx
8010629a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010629f:	89 da                	mov    %ebx,%edx
801062a1:	83 ec 0c             	sub    $0xc,%esp
801062a4:	ee                   	out    %al,(%dx)
801062a5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801062aa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801062af:	89 fa                	mov    %edi,%edx
801062b1:	ee                   	out    %al,(%dx)
801062b2:	b8 0c 00 00 00       	mov    $0xc,%eax
801062b7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801062bc:	ee                   	out    %al,(%dx)
801062bd:	be f9 03 00 00       	mov    $0x3f9,%esi
801062c2:	89 c8                	mov    %ecx,%eax
801062c4:	89 f2                	mov    %esi,%edx
801062c6:	ee                   	out    %al,(%dx)
801062c7:	b8 03 00 00 00       	mov    $0x3,%eax
801062cc:	89 fa                	mov    %edi,%edx
801062ce:	ee                   	out    %al,(%dx)
801062cf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801062d4:	89 c8                	mov    %ecx,%eax
801062d6:	ee                   	out    %al,(%dx)
801062d7:	b8 01 00 00 00       	mov    $0x1,%eax
801062dc:	89 f2                	mov    %esi,%edx
801062de:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801062df:	ba fd 03 00 00       	mov    $0x3fd,%edx
801062e4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801062e5:	3c ff                	cmp    $0xff,%al
801062e7:	74 5a                	je     80106343 <uartinit+0xb3>
  uart = 1;
801062e9:	c7 05 60 b8 10 80 01 	movl   $0x1,0x8010b860
801062f0:	00 00 00 
801062f3:	89 da                	mov    %ebx,%edx
801062f5:	ec                   	in     (%dx),%al
801062f6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801062fb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801062fc:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801062ff:	bb 8c 80 10 80       	mov    $0x8010808c,%ebx
  ioapicenable(IRQ_COM1, 0);
80106304:	6a 00                	push   $0x0
80106306:	6a 04                	push   $0x4
80106308:	e8 d3 bf ff ff       	call   801022e0 <ioapicenable>
8010630d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106310:	b8 78 00 00 00       	mov    $0x78,%eax
80106315:	eb 13                	jmp    8010632a <uartinit+0x9a>
80106317:	89 f6                	mov    %esi,%esi
80106319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106320:	83 c3 01             	add    $0x1,%ebx
80106323:	0f be 03             	movsbl (%ebx),%eax
80106326:	84 c0                	test   %al,%al
80106328:	74 19                	je     80106343 <uartinit+0xb3>
  if(!uart)
8010632a:	8b 15 60 b8 10 80    	mov    0x8010b860,%edx
80106330:	85 d2                	test   %edx,%edx
80106332:	74 ec                	je     80106320 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106334:	83 c3 01             	add    $0x1,%ebx
80106337:	e8 04 ff ff ff       	call   80106240 <uartputc.part.0>
8010633c:	0f be 03             	movsbl (%ebx),%eax
8010633f:	84 c0                	test   %al,%al
80106341:	75 e7                	jne    8010632a <uartinit+0x9a>
}
80106343:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106346:	5b                   	pop    %ebx
80106347:	5e                   	pop    %esi
80106348:	5f                   	pop    %edi
80106349:	5d                   	pop    %ebp
8010634a:	c3                   	ret    
8010634b:	90                   	nop
8010634c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106350 <uartputc>:
  if(!uart)
80106350:	8b 15 60 b8 10 80    	mov    0x8010b860,%edx
{
80106356:	55                   	push   %ebp
80106357:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106359:	85 d2                	test   %edx,%edx
{
8010635b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010635e:	74 10                	je     80106370 <uartputc+0x20>
}
80106360:	5d                   	pop    %ebp
80106361:	e9 da fe ff ff       	jmp    80106240 <uartputc.part.0>
80106366:	8d 76 00             	lea    0x0(%esi),%esi
80106369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106370:	5d                   	pop    %ebp
80106371:	c3                   	ret    
80106372:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106380 <uartintr>:

void
uartintr(void)
{
80106380:	55                   	push   %ebp
80106381:	89 e5                	mov    %esp,%ebp
80106383:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106386:	68 10 62 10 80       	push   $0x80106210
8010638b:	e8 80 a4 ff ff       	call   80100810 <consoleintr>
}
80106390:	83 c4 10             	add    $0x10,%esp
80106393:	c9                   	leave  
80106394:	c3                   	ret    

80106395 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106395:	6a 00                	push   $0x0
  pushl $0
80106397:	6a 00                	push   $0x0
  jmp alltraps
80106399:	e9 0c fb ff ff       	jmp    80105eaa <alltraps>

8010639e <vector1>:
.globl vector1
vector1:
  pushl $0
8010639e:	6a 00                	push   $0x0
  pushl $1
801063a0:	6a 01                	push   $0x1
  jmp alltraps
801063a2:	e9 03 fb ff ff       	jmp    80105eaa <alltraps>

801063a7 <vector2>:
.globl vector2
vector2:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $2
801063a9:	6a 02                	push   $0x2
  jmp alltraps
801063ab:	e9 fa fa ff ff       	jmp    80105eaa <alltraps>

801063b0 <vector3>:
.globl vector3
vector3:
  pushl $0
801063b0:	6a 00                	push   $0x0
  pushl $3
801063b2:	6a 03                	push   $0x3
  jmp alltraps
801063b4:	e9 f1 fa ff ff       	jmp    80105eaa <alltraps>

801063b9 <vector4>:
.globl vector4
vector4:
  pushl $0
801063b9:	6a 00                	push   $0x0
  pushl $4
801063bb:	6a 04                	push   $0x4
  jmp alltraps
801063bd:	e9 e8 fa ff ff       	jmp    80105eaa <alltraps>

801063c2 <vector5>:
.globl vector5
vector5:
  pushl $0
801063c2:	6a 00                	push   $0x0
  pushl $5
801063c4:	6a 05                	push   $0x5
  jmp alltraps
801063c6:	e9 df fa ff ff       	jmp    80105eaa <alltraps>

801063cb <vector6>:
.globl vector6
vector6:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $6
801063cd:	6a 06                	push   $0x6
  jmp alltraps
801063cf:	e9 d6 fa ff ff       	jmp    80105eaa <alltraps>

801063d4 <vector7>:
.globl vector7
vector7:
  pushl $0
801063d4:	6a 00                	push   $0x0
  pushl $7
801063d6:	6a 07                	push   $0x7
  jmp alltraps
801063d8:	e9 cd fa ff ff       	jmp    80105eaa <alltraps>

801063dd <vector8>:
.globl vector8
vector8:
  pushl $8
801063dd:	6a 08                	push   $0x8
  jmp alltraps
801063df:	e9 c6 fa ff ff       	jmp    80105eaa <alltraps>

801063e4 <vector9>:
.globl vector9
vector9:
  pushl $0
801063e4:	6a 00                	push   $0x0
  pushl $9
801063e6:	6a 09                	push   $0x9
  jmp alltraps
801063e8:	e9 bd fa ff ff       	jmp    80105eaa <alltraps>

801063ed <vector10>:
.globl vector10
vector10:
  pushl $10
801063ed:	6a 0a                	push   $0xa
  jmp alltraps
801063ef:	e9 b6 fa ff ff       	jmp    80105eaa <alltraps>

801063f4 <vector11>:
.globl vector11
vector11:
  pushl $11
801063f4:	6a 0b                	push   $0xb
  jmp alltraps
801063f6:	e9 af fa ff ff       	jmp    80105eaa <alltraps>

801063fb <vector12>:
.globl vector12
vector12:
  pushl $12
801063fb:	6a 0c                	push   $0xc
  jmp alltraps
801063fd:	e9 a8 fa ff ff       	jmp    80105eaa <alltraps>

80106402 <vector13>:
.globl vector13
vector13:
  pushl $13
80106402:	6a 0d                	push   $0xd
  jmp alltraps
80106404:	e9 a1 fa ff ff       	jmp    80105eaa <alltraps>

80106409 <vector14>:
.globl vector14
vector14:
  pushl $14
80106409:	6a 0e                	push   $0xe
  jmp alltraps
8010640b:	e9 9a fa ff ff       	jmp    80105eaa <alltraps>

80106410 <vector15>:
.globl vector15
vector15:
  pushl $0
80106410:	6a 00                	push   $0x0
  pushl $15
80106412:	6a 0f                	push   $0xf
  jmp alltraps
80106414:	e9 91 fa ff ff       	jmp    80105eaa <alltraps>

80106419 <vector16>:
.globl vector16
vector16:
  pushl $0
80106419:	6a 00                	push   $0x0
  pushl $16
8010641b:	6a 10                	push   $0x10
  jmp alltraps
8010641d:	e9 88 fa ff ff       	jmp    80105eaa <alltraps>

80106422 <vector17>:
.globl vector17
vector17:
  pushl $17
80106422:	6a 11                	push   $0x11
  jmp alltraps
80106424:	e9 81 fa ff ff       	jmp    80105eaa <alltraps>

80106429 <vector18>:
.globl vector18
vector18:
  pushl $0
80106429:	6a 00                	push   $0x0
  pushl $18
8010642b:	6a 12                	push   $0x12
  jmp alltraps
8010642d:	e9 78 fa ff ff       	jmp    80105eaa <alltraps>

80106432 <vector19>:
.globl vector19
vector19:
  pushl $0
80106432:	6a 00                	push   $0x0
  pushl $19
80106434:	6a 13                	push   $0x13
  jmp alltraps
80106436:	e9 6f fa ff ff       	jmp    80105eaa <alltraps>

8010643b <vector20>:
.globl vector20
vector20:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $20
8010643d:	6a 14                	push   $0x14
  jmp alltraps
8010643f:	e9 66 fa ff ff       	jmp    80105eaa <alltraps>

80106444 <vector21>:
.globl vector21
vector21:
  pushl $0
80106444:	6a 00                	push   $0x0
  pushl $21
80106446:	6a 15                	push   $0x15
  jmp alltraps
80106448:	e9 5d fa ff ff       	jmp    80105eaa <alltraps>

8010644d <vector22>:
.globl vector22
vector22:
  pushl $0
8010644d:	6a 00                	push   $0x0
  pushl $22
8010644f:	6a 16                	push   $0x16
  jmp alltraps
80106451:	e9 54 fa ff ff       	jmp    80105eaa <alltraps>

80106456 <vector23>:
.globl vector23
vector23:
  pushl $0
80106456:	6a 00                	push   $0x0
  pushl $23
80106458:	6a 17                	push   $0x17
  jmp alltraps
8010645a:	e9 4b fa ff ff       	jmp    80105eaa <alltraps>

8010645f <vector24>:
.globl vector24
vector24:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $24
80106461:	6a 18                	push   $0x18
  jmp alltraps
80106463:	e9 42 fa ff ff       	jmp    80105eaa <alltraps>

80106468 <vector25>:
.globl vector25
vector25:
  pushl $0
80106468:	6a 00                	push   $0x0
  pushl $25
8010646a:	6a 19                	push   $0x19
  jmp alltraps
8010646c:	e9 39 fa ff ff       	jmp    80105eaa <alltraps>

80106471 <vector26>:
.globl vector26
vector26:
  pushl $0
80106471:	6a 00                	push   $0x0
  pushl $26
80106473:	6a 1a                	push   $0x1a
  jmp alltraps
80106475:	e9 30 fa ff ff       	jmp    80105eaa <alltraps>

8010647a <vector27>:
.globl vector27
vector27:
  pushl $0
8010647a:	6a 00                	push   $0x0
  pushl $27
8010647c:	6a 1b                	push   $0x1b
  jmp alltraps
8010647e:	e9 27 fa ff ff       	jmp    80105eaa <alltraps>

80106483 <vector28>:
.globl vector28
vector28:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $28
80106485:	6a 1c                	push   $0x1c
  jmp alltraps
80106487:	e9 1e fa ff ff       	jmp    80105eaa <alltraps>

8010648c <vector29>:
.globl vector29
vector29:
  pushl $0
8010648c:	6a 00                	push   $0x0
  pushl $29
8010648e:	6a 1d                	push   $0x1d
  jmp alltraps
80106490:	e9 15 fa ff ff       	jmp    80105eaa <alltraps>

80106495 <vector30>:
.globl vector30
vector30:
  pushl $0
80106495:	6a 00                	push   $0x0
  pushl $30
80106497:	6a 1e                	push   $0x1e
  jmp alltraps
80106499:	e9 0c fa ff ff       	jmp    80105eaa <alltraps>

8010649e <vector31>:
.globl vector31
vector31:
  pushl $0
8010649e:	6a 00                	push   $0x0
  pushl $31
801064a0:	6a 1f                	push   $0x1f
  jmp alltraps
801064a2:	e9 03 fa ff ff       	jmp    80105eaa <alltraps>

801064a7 <vector32>:
.globl vector32
vector32:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $32
801064a9:	6a 20                	push   $0x20
  jmp alltraps
801064ab:	e9 fa f9 ff ff       	jmp    80105eaa <alltraps>

801064b0 <vector33>:
.globl vector33
vector33:
  pushl $0
801064b0:	6a 00                	push   $0x0
  pushl $33
801064b2:	6a 21                	push   $0x21
  jmp alltraps
801064b4:	e9 f1 f9 ff ff       	jmp    80105eaa <alltraps>

801064b9 <vector34>:
.globl vector34
vector34:
  pushl $0
801064b9:	6a 00                	push   $0x0
  pushl $34
801064bb:	6a 22                	push   $0x22
  jmp alltraps
801064bd:	e9 e8 f9 ff ff       	jmp    80105eaa <alltraps>

801064c2 <vector35>:
.globl vector35
vector35:
  pushl $0
801064c2:	6a 00                	push   $0x0
  pushl $35
801064c4:	6a 23                	push   $0x23
  jmp alltraps
801064c6:	e9 df f9 ff ff       	jmp    80105eaa <alltraps>

801064cb <vector36>:
.globl vector36
vector36:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $36
801064cd:	6a 24                	push   $0x24
  jmp alltraps
801064cf:	e9 d6 f9 ff ff       	jmp    80105eaa <alltraps>

801064d4 <vector37>:
.globl vector37
vector37:
  pushl $0
801064d4:	6a 00                	push   $0x0
  pushl $37
801064d6:	6a 25                	push   $0x25
  jmp alltraps
801064d8:	e9 cd f9 ff ff       	jmp    80105eaa <alltraps>

801064dd <vector38>:
.globl vector38
vector38:
  pushl $0
801064dd:	6a 00                	push   $0x0
  pushl $38
801064df:	6a 26                	push   $0x26
  jmp alltraps
801064e1:	e9 c4 f9 ff ff       	jmp    80105eaa <alltraps>

801064e6 <vector39>:
.globl vector39
vector39:
  pushl $0
801064e6:	6a 00                	push   $0x0
  pushl $39
801064e8:	6a 27                	push   $0x27
  jmp alltraps
801064ea:	e9 bb f9 ff ff       	jmp    80105eaa <alltraps>

801064ef <vector40>:
.globl vector40
vector40:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $40
801064f1:	6a 28                	push   $0x28
  jmp alltraps
801064f3:	e9 b2 f9 ff ff       	jmp    80105eaa <alltraps>

801064f8 <vector41>:
.globl vector41
vector41:
  pushl $0
801064f8:	6a 00                	push   $0x0
  pushl $41
801064fa:	6a 29                	push   $0x29
  jmp alltraps
801064fc:	e9 a9 f9 ff ff       	jmp    80105eaa <alltraps>

80106501 <vector42>:
.globl vector42
vector42:
  pushl $0
80106501:	6a 00                	push   $0x0
  pushl $42
80106503:	6a 2a                	push   $0x2a
  jmp alltraps
80106505:	e9 a0 f9 ff ff       	jmp    80105eaa <alltraps>

8010650a <vector43>:
.globl vector43
vector43:
  pushl $0
8010650a:	6a 00                	push   $0x0
  pushl $43
8010650c:	6a 2b                	push   $0x2b
  jmp alltraps
8010650e:	e9 97 f9 ff ff       	jmp    80105eaa <alltraps>

80106513 <vector44>:
.globl vector44
vector44:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $44
80106515:	6a 2c                	push   $0x2c
  jmp alltraps
80106517:	e9 8e f9 ff ff       	jmp    80105eaa <alltraps>

8010651c <vector45>:
.globl vector45
vector45:
  pushl $0
8010651c:	6a 00                	push   $0x0
  pushl $45
8010651e:	6a 2d                	push   $0x2d
  jmp alltraps
80106520:	e9 85 f9 ff ff       	jmp    80105eaa <alltraps>

80106525 <vector46>:
.globl vector46
vector46:
  pushl $0
80106525:	6a 00                	push   $0x0
  pushl $46
80106527:	6a 2e                	push   $0x2e
  jmp alltraps
80106529:	e9 7c f9 ff ff       	jmp    80105eaa <alltraps>

8010652e <vector47>:
.globl vector47
vector47:
  pushl $0
8010652e:	6a 00                	push   $0x0
  pushl $47
80106530:	6a 2f                	push   $0x2f
  jmp alltraps
80106532:	e9 73 f9 ff ff       	jmp    80105eaa <alltraps>

80106537 <vector48>:
.globl vector48
vector48:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $48
80106539:	6a 30                	push   $0x30
  jmp alltraps
8010653b:	e9 6a f9 ff ff       	jmp    80105eaa <alltraps>

80106540 <vector49>:
.globl vector49
vector49:
  pushl $0
80106540:	6a 00                	push   $0x0
  pushl $49
80106542:	6a 31                	push   $0x31
  jmp alltraps
80106544:	e9 61 f9 ff ff       	jmp    80105eaa <alltraps>

80106549 <vector50>:
.globl vector50
vector50:
  pushl $0
80106549:	6a 00                	push   $0x0
  pushl $50
8010654b:	6a 32                	push   $0x32
  jmp alltraps
8010654d:	e9 58 f9 ff ff       	jmp    80105eaa <alltraps>

80106552 <vector51>:
.globl vector51
vector51:
  pushl $0
80106552:	6a 00                	push   $0x0
  pushl $51
80106554:	6a 33                	push   $0x33
  jmp alltraps
80106556:	e9 4f f9 ff ff       	jmp    80105eaa <alltraps>

8010655b <vector52>:
.globl vector52
vector52:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $52
8010655d:	6a 34                	push   $0x34
  jmp alltraps
8010655f:	e9 46 f9 ff ff       	jmp    80105eaa <alltraps>

80106564 <vector53>:
.globl vector53
vector53:
  pushl $0
80106564:	6a 00                	push   $0x0
  pushl $53
80106566:	6a 35                	push   $0x35
  jmp alltraps
80106568:	e9 3d f9 ff ff       	jmp    80105eaa <alltraps>

8010656d <vector54>:
.globl vector54
vector54:
  pushl $0
8010656d:	6a 00                	push   $0x0
  pushl $54
8010656f:	6a 36                	push   $0x36
  jmp alltraps
80106571:	e9 34 f9 ff ff       	jmp    80105eaa <alltraps>

80106576 <vector55>:
.globl vector55
vector55:
  pushl $0
80106576:	6a 00                	push   $0x0
  pushl $55
80106578:	6a 37                	push   $0x37
  jmp alltraps
8010657a:	e9 2b f9 ff ff       	jmp    80105eaa <alltraps>

8010657f <vector56>:
.globl vector56
vector56:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $56
80106581:	6a 38                	push   $0x38
  jmp alltraps
80106583:	e9 22 f9 ff ff       	jmp    80105eaa <alltraps>

80106588 <vector57>:
.globl vector57
vector57:
  pushl $0
80106588:	6a 00                	push   $0x0
  pushl $57
8010658a:	6a 39                	push   $0x39
  jmp alltraps
8010658c:	e9 19 f9 ff ff       	jmp    80105eaa <alltraps>

80106591 <vector58>:
.globl vector58
vector58:
  pushl $0
80106591:	6a 00                	push   $0x0
  pushl $58
80106593:	6a 3a                	push   $0x3a
  jmp alltraps
80106595:	e9 10 f9 ff ff       	jmp    80105eaa <alltraps>

8010659a <vector59>:
.globl vector59
vector59:
  pushl $0
8010659a:	6a 00                	push   $0x0
  pushl $59
8010659c:	6a 3b                	push   $0x3b
  jmp alltraps
8010659e:	e9 07 f9 ff ff       	jmp    80105eaa <alltraps>

801065a3 <vector60>:
.globl vector60
vector60:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $60
801065a5:	6a 3c                	push   $0x3c
  jmp alltraps
801065a7:	e9 fe f8 ff ff       	jmp    80105eaa <alltraps>

801065ac <vector61>:
.globl vector61
vector61:
  pushl $0
801065ac:	6a 00                	push   $0x0
  pushl $61
801065ae:	6a 3d                	push   $0x3d
  jmp alltraps
801065b0:	e9 f5 f8 ff ff       	jmp    80105eaa <alltraps>

801065b5 <vector62>:
.globl vector62
vector62:
  pushl $0
801065b5:	6a 00                	push   $0x0
  pushl $62
801065b7:	6a 3e                	push   $0x3e
  jmp alltraps
801065b9:	e9 ec f8 ff ff       	jmp    80105eaa <alltraps>

801065be <vector63>:
.globl vector63
vector63:
  pushl $0
801065be:	6a 00                	push   $0x0
  pushl $63
801065c0:	6a 3f                	push   $0x3f
  jmp alltraps
801065c2:	e9 e3 f8 ff ff       	jmp    80105eaa <alltraps>

801065c7 <vector64>:
.globl vector64
vector64:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $64
801065c9:	6a 40                	push   $0x40
  jmp alltraps
801065cb:	e9 da f8 ff ff       	jmp    80105eaa <alltraps>

801065d0 <vector65>:
.globl vector65
vector65:
  pushl $0
801065d0:	6a 00                	push   $0x0
  pushl $65
801065d2:	6a 41                	push   $0x41
  jmp alltraps
801065d4:	e9 d1 f8 ff ff       	jmp    80105eaa <alltraps>

801065d9 <vector66>:
.globl vector66
vector66:
  pushl $0
801065d9:	6a 00                	push   $0x0
  pushl $66
801065db:	6a 42                	push   $0x42
  jmp alltraps
801065dd:	e9 c8 f8 ff ff       	jmp    80105eaa <alltraps>

801065e2 <vector67>:
.globl vector67
vector67:
  pushl $0
801065e2:	6a 00                	push   $0x0
  pushl $67
801065e4:	6a 43                	push   $0x43
  jmp alltraps
801065e6:	e9 bf f8 ff ff       	jmp    80105eaa <alltraps>

801065eb <vector68>:
.globl vector68
vector68:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $68
801065ed:	6a 44                	push   $0x44
  jmp alltraps
801065ef:	e9 b6 f8 ff ff       	jmp    80105eaa <alltraps>

801065f4 <vector69>:
.globl vector69
vector69:
  pushl $0
801065f4:	6a 00                	push   $0x0
  pushl $69
801065f6:	6a 45                	push   $0x45
  jmp alltraps
801065f8:	e9 ad f8 ff ff       	jmp    80105eaa <alltraps>

801065fd <vector70>:
.globl vector70
vector70:
  pushl $0
801065fd:	6a 00                	push   $0x0
  pushl $70
801065ff:	6a 46                	push   $0x46
  jmp alltraps
80106601:	e9 a4 f8 ff ff       	jmp    80105eaa <alltraps>

80106606 <vector71>:
.globl vector71
vector71:
  pushl $0
80106606:	6a 00                	push   $0x0
  pushl $71
80106608:	6a 47                	push   $0x47
  jmp alltraps
8010660a:	e9 9b f8 ff ff       	jmp    80105eaa <alltraps>

8010660f <vector72>:
.globl vector72
vector72:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $72
80106611:	6a 48                	push   $0x48
  jmp alltraps
80106613:	e9 92 f8 ff ff       	jmp    80105eaa <alltraps>

80106618 <vector73>:
.globl vector73
vector73:
  pushl $0
80106618:	6a 00                	push   $0x0
  pushl $73
8010661a:	6a 49                	push   $0x49
  jmp alltraps
8010661c:	e9 89 f8 ff ff       	jmp    80105eaa <alltraps>

80106621 <vector74>:
.globl vector74
vector74:
  pushl $0
80106621:	6a 00                	push   $0x0
  pushl $74
80106623:	6a 4a                	push   $0x4a
  jmp alltraps
80106625:	e9 80 f8 ff ff       	jmp    80105eaa <alltraps>

8010662a <vector75>:
.globl vector75
vector75:
  pushl $0
8010662a:	6a 00                	push   $0x0
  pushl $75
8010662c:	6a 4b                	push   $0x4b
  jmp alltraps
8010662e:	e9 77 f8 ff ff       	jmp    80105eaa <alltraps>

80106633 <vector76>:
.globl vector76
vector76:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $76
80106635:	6a 4c                	push   $0x4c
  jmp alltraps
80106637:	e9 6e f8 ff ff       	jmp    80105eaa <alltraps>

8010663c <vector77>:
.globl vector77
vector77:
  pushl $0
8010663c:	6a 00                	push   $0x0
  pushl $77
8010663e:	6a 4d                	push   $0x4d
  jmp alltraps
80106640:	e9 65 f8 ff ff       	jmp    80105eaa <alltraps>

80106645 <vector78>:
.globl vector78
vector78:
  pushl $0
80106645:	6a 00                	push   $0x0
  pushl $78
80106647:	6a 4e                	push   $0x4e
  jmp alltraps
80106649:	e9 5c f8 ff ff       	jmp    80105eaa <alltraps>

8010664e <vector79>:
.globl vector79
vector79:
  pushl $0
8010664e:	6a 00                	push   $0x0
  pushl $79
80106650:	6a 4f                	push   $0x4f
  jmp alltraps
80106652:	e9 53 f8 ff ff       	jmp    80105eaa <alltraps>

80106657 <vector80>:
.globl vector80
vector80:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $80
80106659:	6a 50                	push   $0x50
  jmp alltraps
8010665b:	e9 4a f8 ff ff       	jmp    80105eaa <alltraps>

80106660 <vector81>:
.globl vector81
vector81:
  pushl $0
80106660:	6a 00                	push   $0x0
  pushl $81
80106662:	6a 51                	push   $0x51
  jmp alltraps
80106664:	e9 41 f8 ff ff       	jmp    80105eaa <alltraps>

80106669 <vector82>:
.globl vector82
vector82:
  pushl $0
80106669:	6a 00                	push   $0x0
  pushl $82
8010666b:	6a 52                	push   $0x52
  jmp alltraps
8010666d:	e9 38 f8 ff ff       	jmp    80105eaa <alltraps>

80106672 <vector83>:
.globl vector83
vector83:
  pushl $0
80106672:	6a 00                	push   $0x0
  pushl $83
80106674:	6a 53                	push   $0x53
  jmp alltraps
80106676:	e9 2f f8 ff ff       	jmp    80105eaa <alltraps>

8010667b <vector84>:
.globl vector84
vector84:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $84
8010667d:	6a 54                	push   $0x54
  jmp alltraps
8010667f:	e9 26 f8 ff ff       	jmp    80105eaa <alltraps>

80106684 <vector85>:
.globl vector85
vector85:
  pushl $0
80106684:	6a 00                	push   $0x0
  pushl $85
80106686:	6a 55                	push   $0x55
  jmp alltraps
80106688:	e9 1d f8 ff ff       	jmp    80105eaa <alltraps>

8010668d <vector86>:
.globl vector86
vector86:
  pushl $0
8010668d:	6a 00                	push   $0x0
  pushl $86
8010668f:	6a 56                	push   $0x56
  jmp alltraps
80106691:	e9 14 f8 ff ff       	jmp    80105eaa <alltraps>

80106696 <vector87>:
.globl vector87
vector87:
  pushl $0
80106696:	6a 00                	push   $0x0
  pushl $87
80106698:	6a 57                	push   $0x57
  jmp alltraps
8010669a:	e9 0b f8 ff ff       	jmp    80105eaa <alltraps>

8010669f <vector88>:
.globl vector88
vector88:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $88
801066a1:	6a 58                	push   $0x58
  jmp alltraps
801066a3:	e9 02 f8 ff ff       	jmp    80105eaa <alltraps>

801066a8 <vector89>:
.globl vector89
vector89:
  pushl $0
801066a8:	6a 00                	push   $0x0
  pushl $89
801066aa:	6a 59                	push   $0x59
  jmp alltraps
801066ac:	e9 f9 f7 ff ff       	jmp    80105eaa <alltraps>

801066b1 <vector90>:
.globl vector90
vector90:
  pushl $0
801066b1:	6a 00                	push   $0x0
  pushl $90
801066b3:	6a 5a                	push   $0x5a
  jmp alltraps
801066b5:	e9 f0 f7 ff ff       	jmp    80105eaa <alltraps>

801066ba <vector91>:
.globl vector91
vector91:
  pushl $0
801066ba:	6a 00                	push   $0x0
  pushl $91
801066bc:	6a 5b                	push   $0x5b
  jmp alltraps
801066be:	e9 e7 f7 ff ff       	jmp    80105eaa <alltraps>

801066c3 <vector92>:
.globl vector92
vector92:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $92
801066c5:	6a 5c                	push   $0x5c
  jmp alltraps
801066c7:	e9 de f7 ff ff       	jmp    80105eaa <alltraps>

801066cc <vector93>:
.globl vector93
vector93:
  pushl $0
801066cc:	6a 00                	push   $0x0
  pushl $93
801066ce:	6a 5d                	push   $0x5d
  jmp alltraps
801066d0:	e9 d5 f7 ff ff       	jmp    80105eaa <alltraps>

801066d5 <vector94>:
.globl vector94
vector94:
  pushl $0
801066d5:	6a 00                	push   $0x0
  pushl $94
801066d7:	6a 5e                	push   $0x5e
  jmp alltraps
801066d9:	e9 cc f7 ff ff       	jmp    80105eaa <alltraps>

801066de <vector95>:
.globl vector95
vector95:
  pushl $0
801066de:	6a 00                	push   $0x0
  pushl $95
801066e0:	6a 5f                	push   $0x5f
  jmp alltraps
801066e2:	e9 c3 f7 ff ff       	jmp    80105eaa <alltraps>

801066e7 <vector96>:
.globl vector96
vector96:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $96
801066e9:	6a 60                	push   $0x60
  jmp alltraps
801066eb:	e9 ba f7 ff ff       	jmp    80105eaa <alltraps>

801066f0 <vector97>:
.globl vector97
vector97:
  pushl $0
801066f0:	6a 00                	push   $0x0
  pushl $97
801066f2:	6a 61                	push   $0x61
  jmp alltraps
801066f4:	e9 b1 f7 ff ff       	jmp    80105eaa <alltraps>

801066f9 <vector98>:
.globl vector98
vector98:
  pushl $0
801066f9:	6a 00                	push   $0x0
  pushl $98
801066fb:	6a 62                	push   $0x62
  jmp alltraps
801066fd:	e9 a8 f7 ff ff       	jmp    80105eaa <alltraps>

80106702 <vector99>:
.globl vector99
vector99:
  pushl $0
80106702:	6a 00                	push   $0x0
  pushl $99
80106704:	6a 63                	push   $0x63
  jmp alltraps
80106706:	e9 9f f7 ff ff       	jmp    80105eaa <alltraps>

8010670b <vector100>:
.globl vector100
vector100:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $100
8010670d:	6a 64                	push   $0x64
  jmp alltraps
8010670f:	e9 96 f7 ff ff       	jmp    80105eaa <alltraps>

80106714 <vector101>:
.globl vector101
vector101:
  pushl $0
80106714:	6a 00                	push   $0x0
  pushl $101
80106716:	6a 65                	push   $0x65
  jmp alltraps
80106718:	e9 8d f7 ff ff       	jmp    80105eaa <alltraps>

8010671d <vector102>:
.globl vector102
vector102:
  pushl $0
8010671d:	6a 00                	push   $0x0
  pushl $102
8010671f:	6a 66                	push   $0x66
  jmp alltraps
80106721:	e9 84 f7 ff ff       	jmp    80105eaa <alltraps>

80106726 <vector103>:
.globl vector103
vector103:
  pushl $0
80106726:	6a 00                	push   $0x0
  pushl $103
80106728:	6a 67                	push   $0x67
  jmp alltraps
8010672a:	e9 7b f7 ff ff       	jmp    80105eaa <alltraps>

8010672f <vector104>:
.globl vector104
vector104:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $104
80106731:	6a 68                	push   $0x68
  jmp alltraps
80106733:	e9 72 f7 ff ff       	jmp    80105eaa <alltraps>

80106738 <vector105>:
.globl vector105
vector105:
  pushl $0
80106738:	6a 00                	push   $0x0
  pushl $105
8010673a:	6a 69                	push   $0x69
  jmp alltraps
8010673c:	e9 69 f7 ff ff       	jmp    80105eaa <alltraps>

80106741 <vector106>:
.globl vector106
vector106:
  pushl $0
80106741:	6a 00                	push   $0x0
  pushl $106
80106743:	6a 6a                	push   $0x6a
  jmp alltraps
80106745:	e9 60 f7 ff ff       	jmp    80105eaa <alltraps>

8010674a <vector107>:
.globl vector107
vector107:
  pushl $0
8010674a:	6a 00                	push   $0x0
  pushl $107
8010674c:	6a 6b                	push   $0x6b
  jmp alltraps
8010674e:	e9 57 f7 ff ff       	jmp    80105eaa <alltraps>

80106753 <vector108>:
.globl vector108
vector108:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $108
80106755:	6a 6c                	push   $0x6c
  jmp alltraps
80106757:	e9 4e f7 ff ff       	jmp    80105eaa <alltraps>

8010675c <vector109>:
.globl vector109
vector109:
  pushl $0
8010675c:	6a 00                	push   $0x0
  pushl $109
8010675e:	6a 6d                	push   $0x6d
  jmp alltraps
80106760:	e9 45 f7 ff ff       	jmp    80105eaa <alltraps>

80106765 <vector110>:
.globl vector110
vector110:
  pushl $0
80106765:	6a 00                	push   $0x0
  pushl $110
80106767:	6a 6e                	push   $0x6e
  jmp alltraps
80106769:	e9 3c f7 ff ff       	jmp    80105eaa <alltraps>

8010676e <vector111>:
.globl vector111
vector111:
  pushl $0
8010676e:	6a 00                	push   $0x0
  pushl $111
80106770:	6a 6f                	push   $0x6f
  jmp alltraps
80106772:	e9 33 f7 ff ff       	jmp    80105eaa <alltraps>

80106777 <vector112>:
.globl vector112
vector112:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $112
80106779:	6a 70                	push   $0x70
  jmp alltraps
8010677b:	e9 2a f7 ff ff       	jmp    80105eaa <alltraps>

80106780 <vector113>:
.globl vector113
vector113:
  pushl $0
80106780:	6a 00                	push   $0x0
  pushl $113
80106782:	6a 71                	push   $0x71
  jmp alltraps
80106784:	e9 21 f7 ff ff       	jmp    80105eaa <alltraps>

80106789 <vector114>:
.globl vector114
vector114:
  pushl $0
80106789:	6a 00                	push   $0x0
  pushl $114
8010678b:	6a 72                	push   $0x72
  jmp alltraps
8010678d:	e9 18 f7 ff ff       	jmp    80105eaa <alltraps>

80106792 <vector115>:
.globl vector115
vector115:
  pushl $0
80106792:	6a 00                	push   $0x0
  pushl $115
80106794:	6a 73                	push   $0x73
  jmp alltraps
80106796:	e9 0f f7 ff ff       	jmp    80105eaa <alltraps>

8010679b <vector116>:
.globl vector116
vector116:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $116
8010679d:	6a 74                	push   $0x74
  jmp alltraps
8010679f:	e9 06 f7 ff ff       	jmp    80105eaa <alltraps>

801067a4 <vector117>:
.globl vector117
vector117:
  pushl $0
801067a4:	6a 00                	push   $0x0
  pushl $117
801067a6:	6a 75                	push   $0x75
  jmp alltraps
801067a8:	e9 fd f6 ff ff       	jmp    80105eaa <alltraps>

801067ad <vector118>:
.globl vector118
vector118:
  pushl $0
801067ad:	6a 00                	push   $0x0
  pushl $118
801067af:	6a 76                	push   $0x76
  jmp alltraps
801067b1:	e9 f4 f6 ff ff       	jmp    80105eaa <alltraps>

801067b6 <vector119>:
.globl vector119
vector119:
  pushl $0
801067b6:	6a 00                	push   $0x0
  pushl $119
801067b8:	6a 77                	push   $0x77
  jmp alltraps
801067ba:	e9 eb f6 ff ff       	jmp    80105eaa <alltraps>

801067bf <vector120>:
.globl vector120
vector120:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $120
801067c1:	6a 78                	push   $0x78
  jmp alltraps
801067c3:	e9 e2 f6 ff ff       	jmp    80105eaa <alltraps>

801067c8 <vector121>:
.globl vector121
vector121:
  pushl $0
801067c8:	6a 00                	push   $0x0
  pushl $121
801067ca:	6a 79                	push   $0x79
  jmp alltraps
801067cc:	e9 d9 f6 ff ff       	jmp    80105eaa <alltraps>

801067d1 <vector122>:
.globl vector122
vector122:
  pushl $0
801067d1:	6a 00                	push   $0x0
  pushl $122
801067d3:	6a 7a                	push   $0x7a
  jmp alltraps
801067d5:	e9 d0 f6 ff ff       	jmp    80105eaa <alltraps>

801067da <vector123>:
.globl vector123
vector123:
  pushl $0
801067da:	6a 00                	push   $0x0
  pushl $123
801067dc:	6a 7b                	push   $0x7b
  jmp alltraps
801067de:	e9 c7 f6 ff ff       	jmp    80105eaa <alltraps>

801067e3 <vector124>:
.globl vector124
vector124:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $124
801067e5:	6a 7c                	push   $0x7c
  jmp alltraps
801067e7:	e9 be f6 ff ff       	jmp    80105eaa <alltraps>

801067ec <vector125>:
.globl vector125
vector125:
  pushl $0
801067ec:	6a 00                	push   $0x0
  pushl $125
801067ee:	6a 7d                	push   $0x7d
  jmp alltraps
801067f0:	e9 b5 f6 ff ff       	jmp    80105eaa <alltraps>

801067f5 <vector126>:
.globl vector126
vector126:
  pushl $0
801067f5:	6a 00                	push   $0x0
  pushl $126
801067f7:	6a 7e                	push   $0x7e
  jmp alltraps
801067f9:	e9 ac f6 ff ff       	jmp    80105eaa <alltraps>

801067fe <vector127>:
.globl vector127
vector127:
  pushl $0
801067fe:	6a 00                	push   $0x0
  pushl $127
80106800:	6a 7f                	push   $0x7f
  jmp alltraps
80106802:	e9 a3 f6 ff ff       	jmp    80105eaa <alltraps>

80106807 <vector128>:
.globl vector128
vector128:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $128
80106809:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010680e:	e9 97 f6 ff ff       	jmp    80105eaa <alltraps>

80106813 <vector129>:
.globl vector129
vector129:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $129
80106815:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010681a:	e9 8b f6 ff ff       	jmp    80105eaa <alltraps>

8010681f <vector130>:
.globl vector130
vector130:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $130
80106821:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106826:	e9 7f f6 ff ff       	jmp    80105eaa <alltraps>

8010682b <vector131>:
.globl vector131
vector131:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $131
8010682d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106832:	e9 73 f6 ff ff       	jmp    80105eaa <alltraps>

80106837 <vector132>:
.globl vector132
vector132:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $132
80106839:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010683e:	e9 67 f6 ff ff       	jmp    80105eaa <alltraps>

80106843 <vector133>:
.globl vector133
vector133:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $133
80106845:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010684a:	e9 5b f6 ff ff       	jmp    80105eaa <alltraps>

8010684f <vector134>:
.globl vector134
vector134:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $134
80106851:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106856:	e9 4f f6 ff ff       	jmp    80105eaa <alltraps>

8010685b <vector135>:
.globl vector135
vector135:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $135
8010685d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106862:	e9 43 f6 ff ff       	jmp    80105eaa <alltraps>

80106867 <vector136>:
.globl vector136
vector136:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $136
80106869:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010686e:	e9 37 f6 ff ff       	jmp    80105eaa <alltraps>

80106873 <vector137>:
.globl vector137
vector137:
  pushl $0
80106873:	6a 00                	push   $0x0
  pushl $137
80106875:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010687a:	e9 2b f6 ff ff       	jmp    80105eaa <alltraps>

8010687f <vector138>:
.globl vector138
vector138:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $138
80106881:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106886:	e9 1f f6 ff ff       	jmp    80105eaa <alltraps>

8010688b <vector139>:
.globl vector139
vector139:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $139
8010688d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106892:	e9 13 f6 ff ff       	jmp    80105eaa <alltraps>

80106897 <vector140>:
.globl vector140
vector140:
  pushl $0
80106897:	6a 00                	push   $0x0
  pushl $140
80106899:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010689e:	e9 07 f6 ff ff       	jmp    80105eaa <alltraps>

801068a3 <vector141>:
.globl vector141
vector141:
  pushl $0
801068a3:	6a 00                	push   $0x0
  pushl $141
801068a5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801068aa:	e9 fb f5 ff ff       	jmp    80105eaa <alltraps>

801068af <vector142>:
.globl vector142
vector142:
  pushl $0
801068af:	6a 00                	push   $0x0
  pushl $142
801068b1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801068b6:	e9 ef f5 ff ff       	jmp    80105eaa <alltraps>

801068bb <vector143>:
.globl vector143
vector143:
  pushl $0
801068bb:	6a 00                	push   $0x0
  pushl $143
801068bd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801068c2:	e9 e3 f5 ff ff       	jmp    80105eaa <alltraps>

801068c7 <vector144>:
.globl vector144
vector144:
  pushl $0
801068c7:	6a 00                	push   $0x0
  pushl $144
801068c9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801068ce:	e9 d7 f5 ff ff       	jmp    80105eaa <alltraps>

801068d3 <vector145>:
.globl vector145
vector145:
  pushl $0
801068d3:	6a 00                	push   $0x0
  pushl $145
801068d5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801068da:	e9 cb f5 ff ff       	jmp    80105eaa <alltraps>

801068df <vector146>:
.globl vector146
vector146:
  pushl $0
801068df:	6a 00                	push   $0x0
  pushl $146
801068e1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801068e6:	e9 bf f5 ff ff       	jmp    80105eaa <alltraps>

801068eb <vector147>:
.globl vector147
vector147:
  pushl $0
801068eb:	6a 00                	push   $0x0
  pushl $147
801068ed:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801068f2:	e9 b3 f5 ff ff       	jmp    80105eaa <alltraps>

801068f7 <vector148>:
.globl vector148
vector148:
  pushl $0
801068f7:	6a 00                	push   $0x0
  pushl $148
801068f9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801068fe:	e9 a7 f5 ff ff       	jmp    80105eaa <alltraps>

80106903 <vector149>:
.globl vector149
vector149:
  pushl $0
80106903:	6a 00                	push   $0x0
  pushl $149
80106905:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010690a:	e9 9b f5 ff ff       	jmp    80105eaa <alltraps>

8010690f <vector150>:
.globl vector150
vector150:
  pushl $0
8010690f:	6a 00                	push   $0x0
  pushl $150
80106911:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106916:	e9 8f f5 ff ff       	jmp    80105eaa <alltraps>

8010691b <vector151>:
.globl vector151
vector151:
  pushl $0
8010691b:	6a 00                	push   $0x0
  pushl $151
8010691d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106922:	e9 83 f5 ff ff       	jmp    80105eaa <alltraps>

80106927 <vector152>:
.globl vector152
vector152:
  pushl $0
80106927:	6a 00                	push   $0x0
  pushl $152
80106929:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010692e:	e9 77 f5 ff ff       	jmp    80105eaa <alltraps>

80106933 <vector153>:
.globl vector153
vector153:
  pushl $0
80106933:	6a 00                	push   $0x0
  pushl $153
80106935:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010693a:	e9 6b f5 ff ff       	jmp    80105eaa <alltraps>

8010693f <vector154>:
.globl vector154
vector154:
  pushl $0
8010693f:	6a 00                	push   $0x0
  pushl $154
80106941:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106946:	e9 5f f5 ff ff       	jmp    80105eaa <alltraps>

8010694b <vector155>:
.globl vector155
vector155:
  pushl $0
8010694b:	6a 00                	push   $0x0
  pushl $155
8010694d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106952:	e9 53 f5 ff ff       	jmp    80105eaa <alltraps>

80106957 <vector156>:
.globl vector156
vector156:
  pushl $0
80106957:	6a 00                	push   $0x0
  pushl $156
80106959:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010695e:	e9 47 f5 ff ff       	jmp    80105eaa <alltraps>

80106963 <vector157>:
.globl vector157
vector157:
  pushl $0
80106963:	6a 00                	push   $0x0
  pushl $157
80106965:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010696a:	e9 3b f5 ff ff       	jmp    80105eaa <alltraps>

8010696f <vector158>:
.globl vector158
vector158:
  pushl $0
8010696f:	6a 00                	push   $0x0
  pushl $158
80106971:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106976:	e9 2f f5 ff ff       	jmp    80105eaa <alltraps>

8010697b <vector159>:
.globl vector159
vector159:
  pushl $0
8010697b:	6a 00                	push   $0x0
  pushl $159
8010697d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106982:	e9 23 f5 ff ff       	jmp    80105eaa <alltraps>

80106987 <vector160>:
.globl vector160
vector160:
  pushl $0
80106987:	6a 00                	push   $0x0
  pushl $160
80106989:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010698e:	e9 17 f5 ff ff       	jmp    80105eaa <alltraps>

80106993 <vector161>:
.globl vector161
vector161:
  pushl $0
80106993:	6a 00                	push   $0x0
  pushl $161
80106995:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010699a:	e9 0b f5 ff ff       	jmp    80105eaa <alltraps>

8010699f <vector162>:
.globl vector162
vector162:
  pushl $0
8010699f:	6a 00                	push   $0x0
  pushl $162
801069a1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801069a6:	e9 ff f4 ff ff       	jmp    80105eaa <alltraps>

801069ab <vector163>:
.globl vector163
vector163:
  pushl $0
801069ab:	6a 00                	push   $0x0
  pushl $163
801069ad:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801069b2:	e9 f3 f4 ff ff       	jmp    80105eaa <alltraps>

801069b7 <vector164>:
.globl vector164
vector164:
  pushl $0
801069b7:	6a 00                	push   $0x0
  pushl $164
801069b9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801069be:	e9 e7 f4 ff ff       	jmp    80105eaa <alltraps>

801069c3 <vector165>:
.globl vector165
vector165:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $165
801069c5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801069ca:	e9 db f4 ff ff       	jmp    80105eaa <alltraps>

801069cf <vector166>:
.globl vector166
vector166:
  pushl $0
801069cf:	6a 00                	push   $0x0
  pushl $166
801069d1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801069d6:	e9 cf f4 ff ff       	jmp    80105eaa <alltraps>

801069db <vector167>:
.globl vector167
vector167:
  pushl $0
801069db:	6a 00                	push   $0x0
  pushl $167
801069dd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801069e2:	e9 c3 f4 ff ff       	jmp    80105eaa <alltraps>

801069e7 <vector168>:
.globl vector168
vector168:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $168
801069e9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801069ee:	e9 b7 f4 ff ff       	jmp    80105eaa <alltraps>

801069f3 <vector169>:
.globl vector169
vector169:
  pushl $0
801069f3:	6a 00                	push   $0x0
  pushl $169
801069f5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801069fa:	e9 ab f4 ff ff       	jmp    80105eaa <alltraps>

801069ff <vector170>:
.globl vector170
vector170:
  pushl $0
801069ff:	6a 00                	push   $0x0
  pushl $170
80106a01:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106a06:	e9 9f f4 ff ff       	jmp    80105eaa <alltraps>

80106a0b <vector171>:
.globl vector171
vector171:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $171
80106a0d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106a12:	e9 93 f4 ff ff       	jmp    80105eaa <alltraps>

80106a17 <vector172>:
.globl vector172
vector172:
  pushl $0
80106a17:	6a 00                	push   $0x0
  pushl $172
80106a19:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106a1e:	e9 87 f4 ff ff       	jmp    80105eaa <alltraps>

80106a23 <vector173>:
.globl vector173
vector173:
  pushl $0
80106a23:	6a 00                	push   $0x0
  pushl $173
80106a25:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106a2a:	e9 7b f4 ff ff       	jmp    80105eaa <alltraps>

80106a2f <vector174>:
.globl vector174
vector174:
  pushl $0
80106a2f:	6a 00                	push   $0x0
  pushl $174
80106a31:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106a36:	e9 6f f4 ff ff       	jmp    80105eaa <alltraps>

80106a3b <vector175>:
.globl vector175
vector175:
  pushl $0
80106a3b:	6a 00                	push   $0x0
  pushl $175
80106a3d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106a42:	e9 63 f4 ff ff       	jmp    80105eaa <alltraps>

80106a47 <vector176>:
.globl vector176
vector176:
  pushl $0
80106a47:	6a 00                	push   $0x0
  pushl $176
80106a49:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106a4e:	e9 57 f4 ff ff       	jmp    80105eaa <alltraps>

80106a53 <vector177>:
.globl vector177
vector177:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $177
80106a55:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106a5a:	e9 4b f4 ff ff       	jmp    80105eaa <alltraps>

80106a5f <vector178>:
.globl vector178
vector178:
  pushl $0
80106a5f:	6a 00                	push   $0x0
  pushl $178
80106a61:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106a66:	e9 3f f4 ff ff       	jmp    80105eaa <alltraps>

80106a6b <vector179>:
.globl vector179
vector179:
  pushl $0
80106a6b:	6a 00                	push   $0x0
  pushl $179
80106a6d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106a72:	e9 33 f4 ff ff       	jmp    80105eaa <alltraps>

80106a77 <vector180>:
.globl vector180
vector180:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $180
80106a79:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106a7e:	e9 27 f4 ff ff       	jmp    80105eaa <alltraps>

80106a83 <vector181>:
.globl vector181
vector181:
  pushl $0
80106a83:	6a 00                	push   $0x0
  pushl $181
80106a85:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106a8a:	e9 1b f4 ff ff       	jmp    80105eaa <alltraps>

80106a8f <vector182>:
.globl vector182
vector182:
  pushl $0
80106a8f:	6a 00                	push   $0x0
  pushl $182
80106a91:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106a96:	e9 0f f4 ff ff       	jmp    80105eaa <alltraps>

80106a9b <vector183>:
.globl vector183
vector183:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $183
80106a9d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106aa2:	e9 03 f4 ff ff       	jmp    80105eaa <alltraps>

80106aa7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106aa7:	6a 00                	push   $0x0
  pushl $184
80106aa9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106aae:	e9 f7 f3 ff ff       	jmp    80105eaa <alltraps>

80106ab3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106ab3:	6a 00                	push   $0x0
  pushl $185
80106ab5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106aba:	e9 eb f3 ff ff       	jmp    80105eaa <alltraps>

80106abf <vector186>:
.globl vector186
vector186:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $186
80106ac1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106ac6:	e9 df f3 ff ff       	jmp    80105eaa <alltraps>

80106acb <vector187>:
.globl vector187
vector187:
  pushl $0
80106acb:	6a 00                	push   $0x0
  pushl $187
80106acd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106ad2:	e9 d3 f3 ff ff       	jmp    80105eaa <alltraps>

80106ad7 <vector188>:
.globl vector188
vector188:
  pushl $0
80106ad7:	6a 00                	push   $0x0
  pushl $188
80106ad9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106ade:	e9 c7 f3 ff ff       	jmp    80105eaa <alltraps>

80106ae3 <vector189>:
.globl vector189
vector189:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $189
80106ae5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106aea:	e9 bb f3 ff ff       	jmp    80105eaa <alltraps>

80106aef <vector190>:
.globl vector190
vector190:
  pushl $0
80106aef:	6a 00                	push   $0x0
  pushl $190
80106af1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106af6:	e9 af f3 ff ff       	jmp    80105eaa <alltraps>

80106afb <vector191>:
.globl vector191
vector191:
  pushl $0
80106afb:	6a 00                	push   $0x0
  pushl $191
80106afd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106b02:	e9 a3 f3 ff ff       	jmp    80105eaa <alltraps>

80106b07 <vector192>:
.globl vector192
vector192:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $192
80106b09:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106b0e:	e9 97 f3 ff ff       	jmp    80105eaa <alltraps>

80106b13 <vector193>:
.globl vector193
vector193:
  pushl $0
80106b13:	6a 00                	push   $0x0
  pushl $193
80106b15:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106b1a:	e9 8b f3 ff ff       	jmp    80105eaa <alltraps>

80106b1f <vector194>:
.globl vector194
vector194:
  pushl $0
80106b1f:	6a 00                	push   $0x0
  pushl $194
80106b21:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106b26:	e9 7f f3 ff ff       	jmp    80105eaa <alltraps>

80106b2b <vector195>:
.globl vector195
vector195:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $195
80106b2d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106b32:	e9 73 f3 ff ff       	jmp    80105eaa <alltraps>

80106b37 <vector196>:
.globl vector196
vector196:
  pushl $0
80106b37:	6a 00                	push   $0x0
  pushl $196
80106b39:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106b3e:	e9 67 f3 ff ff       	jmp    80105eaa <alltraps>

80106b43 <vector197>:
.globl vector197
vector197:
  pushl $0
80106b43:	6a 00                	push   $0x0
  pushl $197
80106b45:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106b4a:	e9 5b f3 ff ff       	jmp    80105eaa <alltraps>

80106b4f <vector198>:
.globl vector198
vector198:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $198
80106b51:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106b56:	e9 4f f3 ff ff       	jmp    80105eaa <alltraps>

80106b5b <vector199>:
.globl vector199
vector199:
  pushl $0
80106b5b:	6a 00                	push   $0x0
  pushl $199
80106b5d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106b62:	e9 43 f3 ff ff       	jmp    80105eaa <alltraps>

80106b67 <vector200>:
.globl vector200
vector200:
  pushl $0
80106b67:	6a 00                	push   $0x0
  pushl $200
80106b69:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106b6e:	e9 37 f3 ff ff       	jmp    80105eaa <alltraps>

80106b73 <vector201>:
.globl vector201
vector201:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $201
80106b75:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106b7a:	e9 2b f3 ff ff       	jmp    80105eaa <alltraps>

80106b7f <vector202>:
.globl vector202
vector202:
  pushl $0
80106b7f:	6a 00                	push   $0x0
  pushl $202
80106b81:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106b86:	e9 1f f3 ff ff       	jmp    80105eaa <alltraps>

80106b8b <vector203>:
.globl vector203
vector203:
  pushl $0
80106b8b:	6a 00                	push   $0x0
  pushl $203
80106b8d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106b92:	e9 13 f3 ff ff       	jmp    80105eaa <alltraps>

80106b97 <vector204>:
.globl vector204
vector204:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $204
80106b99:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106b9e:	e9 07 f3 ff ff       	jmp    80105eaa <alltraps>

80106ba3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106ba3:	6a 00                	push   $0x0
  pushl $205
80106ba5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106baa:	e9 fb f2 ff ff       	jmp    80105eaa <alltraps>

80106baf <vector206>:
.globl vector206
vector206:
  pushl $0
80106baf:	6a 00                	push   $0x0
  pushl $206
80106bb1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106bb6:	e9 ef f2 ff ff       	jmp    80105eaa <alltraps>

80106bbb <vector207>:
.globl vector207
vector207:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $207
80106bbd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106bc2:	e9 e3 f2 ff ff       	jmp    80105eaa <alltraps>

80106bc7 <vector208>:
.globl vector208
vector208:
  pushl $0
80106bc7:	6a 00                	push   $0x0
  pushl $208
80106bc9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106bce:	e9 d7 f2 ff ff       	jmp    80105eaa <alltraps>

80106bd3 <vector209>:
.globl vector209
vector209:
  pushl $0
80106bd3:	6a 00                	push   $0x0
  pushl $209
80106bd5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106bda:	e9 cb f2 ff ff       	jmp    80105eaa <alltraps>

80106bdf <vector210>:
.globl vector210
vector210:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $210
80106be1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106be6:	e9 bf f2 ff ff       	jmp    80105eaa <alltraps>

80106beb <vector211>:
.globl vector211
vector211:
  pushl $0
80106beb:	6a 00                	push   $0x0
  pushl $211
80106bed:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106bf2:	e9 b3 f2 ff ff       	jmp    80105eaa <alltraps>

80106bf7 <vector212>:
.globl vector212
vector212:
  pushl $0
80106bf7:	6a 00                	push   $0x0
  pushl $212
80106bf9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106bfe:	e9 a7 f2 ff ff       	jmp    80105eaa <alltraps>

80106c03 <vector213>:
.globl vector213
vector213:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $213
80106c05:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106c0a:	e9 9b f2 ff ff       	jmp    80105eaa <alltraps>

80106c0f <vector214>:
.globl vector214
vector214:
  pushl $0
80106c0f:	6a 00                	push   $0x0
  pushl $214
80106c11:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106c16:	e9 8f f2 ff ff       	jmp    80105eaa <alltraps>

80106c1b <vector215>:
.globl vector215
vector215:
  pushl $0
80106c1b:	6a 00                	push   $0x0
  pushl $215
80106c1d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106c22:	e9 83 f2 ff ff       	jmp    80105eaa <alltraps>

80106c27 <vector216>:
.globl vector216
vector216:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $216
80106c29:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106c2e:	e9 77 f2 ff ff       	jmp    80105eaa <alltraps>

80106c33 <vector217>:
.globl vector217
vector217:
  pushl $0
80106c33:	6a 00                	push   $0x0
  pushl $217
80106c35:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106c3a:	e9 6b f2 ff ff       	jmp    80105eaa <alltraps>

80106c3f <vector218>:
.globl vector218
vector218:
  pushl $0
80106c3f:	6a 00                	push   $0x0
  pushl $218
80106c41:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106c46:	e9 5f f2 ff ff       	jmp    80105eaa <alltraps>

80106c4b <vector219>:
.globl vector219
vector219:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $219
80106c4d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106c52:	e9 53 f2 ff ff       	jmp    80105eaa <alltraps>

80106c57 <vector220>:
.globl vector220
vector220:
  pushl $0
80106c57:	6a 00                	push   $0x0
  pushl $220
80106c59:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106c5e:	e9 47 f2 ff ff       	jmp    80105eaa <alltraps>

80106c63 <vector221>:
.globl vector221
vector221:
  pushl $0
80106c63:	6a 00                	push   $0x0
  pushl $221
80106c65:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106c6a:	e9 3b f2 ff ff       	jmp    80105eaa <alltraps>

80106c6f <vector222>:
.globl vector222
vector222:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $222
80106c71:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106c76:	e9 2f f2 ff ff       	jmp    80105eaa <alltraps>

80106c7b <vector223>:
.globl vector223
vector223:
  pushl $0
80106c7b:	6a 00                	push   $0x0
  pushl $223
80106c7d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106c82:	e9 23 f2 ff ff       	jmp    80105eaa <alltraps>

80106c87 <vector224>:
.globl vector224
vector224:
  pushl $0
80106c87:	6a 00                	push   $0x0
  pushl $224
80106c89:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106c8e:	e9 17 f2 ff ff       	jmp    80105eaa <alltraps>

80106c93 <vector225>:
.globl vector225
vector225:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $225
80106c95:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106c9a:	e9 0b f2 ff ff       	jmp    80105eaa <alltraps>

80106c9f <vector226>:
.globl vector226
vector226:
  pushl $0
80106c9f:	6a 00                	push   $0x0
  pushl $226
80106ca1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106ca6:	e9 ff f1 ff ff       	jmp    80105eaa <alltraps>

80106cab <vector227>:
.globl vector227
vector227:
  pushl $0
80106cab:	6a 00                	push   $0x0
  pushl $227
80106cad:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106cb2:	e9 f3 f1 ff ff       	jmp    80105eaa <alltraps>

80106cb7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $228
80106cb9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106cbe:	e9 e7 f1 ff ff       	jmp    80105eaa <alltraps>

80106cc3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106cc3:	6a 00                	push   $0x0
  pushl $229
80106cc5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106cca:	e9 db f1 ff ff       	jmp    80105eaa <alltraps>

80106ccf <vector230>:
.globl vector230
vector230:
  pushl $0
80106ccf:	6a 00                	push   $0x0
  pushl $230
80106cd1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106cd6:	e9 cf f1 ff ff       	jmp    80105eaa <alltraps>

80106cdb <vector231>:
.globl vector231
vector231:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $231
80106cdd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106ce2:	e9 c3 f1 ff ff       	jmp    80105eaa <alltraps>

80106ce7 <vector232>:
.globl vector232
vector232:
  pushl $0
80106ce7:	6a 00                	push   $0x0
  pushl $232
80106ce9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106cee:	e9 b7 f1 ff ff       	jmp    80105eaa <alltraps>

80106cf3 <vector233>:
.globl vector233
vector233:
  pushl $0
80106cf3:	6a 00                	push   $0x0
  pushl $233
80106cf5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106cfa:	e9 ab f1 ff ff       	jmp    80105eaa <alltraps>

80106cff <vector234>:
.globl vector234
vector234:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $234
80106d01:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106d06:	e9 9f f1 ff ff       	jmp    80105eaa <alltraps>

80106d0b <vector235>:
.globl vector235
vector235:
  pushl $0
80106d0b:	6a 00                	push   $0x0
  pushl $235
80106d0d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106d12:	e9 93 f1 ff ff       	jmp    80105eaa <alltraps>

80106d17 <vector236>:
.globl vector236
vector236:
  pushl $0
80106d17:	6a 00                	push   $0x0
  pushl $236
80106d19:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106d1e:	e9 87 f1 ff ff       	jmp    80105eaa <alltraps>

80106d23 <vector237>:
.globl vector237
vector237:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $237
80106d25:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106d2a:	e9 7b f1 ff ff       	jmp    80105eaa <alltraps>

80106d2f <vector238>:
.globl vector238
vector238:
  pushl $0
80106d2f:	6a 00                	push   $0x0
  pushl $238
80106d31:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106d36:	e9 6f f1 ff ff       	jmp    80105eaa <alltraps>

80106d3b <vector239>:
.globl vector239
vector239:
  pushl $0
80106d3b:	6a 00                	push   $0x0
  pushl $239
80106d3d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106d42:	e9 63 f1 ff ff       	jmp    80105eaa <alltraps>

80106d47 <vector240>:
.globl vector240
vector240:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $240
80106d49:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106d4e:	e9 57 f1 ff ff       	jmp    80105eaa <alltraps>

80106d53 <vector241>:
.globl vector241
vector241:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $241
80106d55:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106d5a:	e9 4b f1 ff ff       	jmp    80105eaa <alltraps>

80106d5f <vector242>:
.globl vector242
vector242:
  pushl $0
80106d5f:	6a 00                	push   $0x0
  pushl $242
80106d61:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106d66:	e9 3f f1 ff ff       	jmp    80105eaa <alltraps>

80106d6b <vector243>:
.globl vector243
vector243:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $243
80106d6d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106d72:	e9 33 f1 ff ff       	jmp    80105eaa <alltraps>

80106d77 <vector244>:
.globl vector244
vector244:
  pushl $0
80106d77:	6a 00                	push   $0x0
  pushl $244
80106d79:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106d7e:	e9 27 f1 ff ff       	jmp    80105eaa <alltraps>

80106d83 <vector245>:
.globl vector245
vector245:
  pushl $0
80106d83:	6a 00                	push   $0x0
  pushl $245
80106d85:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106d8a:	e9 1b f1 ff ff       	jmp    80105eaa <alltraps>

80106d8f <vector246>:
.globl vector246
vector246:
  pushl $0
80106d8f:	6a 00                	push   $0x0
  pushl $246
80106d91:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106d96:	e9 0f f1 ff ff       	jmp    80105eaa <alltraps>

80106d9b <vector247>:
.globl vector247
vector247:
  pushl $0
80106d9b:	6a 00                	push   $0x0
  pushl $247
80106d9d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106da2:	e9 03 f1 ff ff       	jmp    80105eaa <alltraps>

80106da7 <vector248>:
.globl vector248
vector248:
  pushl $0
80106da7:	6a 00                	push   $0x0
  pushl $248
80106da9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106dae:	e9 f7 f0 ff ff       	jmp    80105eaa <alltraps>

80106db3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $249
80106db5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106dba:	e9 eb f0 ff ff       	jmp    80105eaa <alltraps>

80106dbf <vector250>:
.globl vector250
vector250:
  pushl $0
80106dbf:	6a 00                	push   $0x0
  pushl $250
80106dc1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106dc6:	e9 df f0 ff ff       	jmp    80105eaa <alltraps>

80106dcb <vector251>:
.globl vector251
vector251:
  pushl $0
80106dcb:	6a 00                	push   $0x0
  pushl $251
80106dcd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106dd2:	e9 d3 f0 ff ff       	jmp    80105eaa <alltraps>

80106dd7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $252
80106dd9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106dde:	e9 c7 f0 ff ff       	jmp    80105eaa <alltraps>

80106de3 <vector253>:
.globl vector253
vector253:
  pushl $0
80106de3:	6a 00                	push   $0x0
  pushl $253
80106de5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106dea:	e9 bb f0 ff ff       	jmp    80105eaa <alltraps>

80106def <vector254>:
.globl vector254
vector254:
  pushl $0
80106def:	6a 00                	push   $0x0
  pushl $254
80106df1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106df6:	e9 af f0 ff ff       	jmp    80105eaa <alltraps>

80106dfb <vector255>:
.globl vector255
vector255:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $255
80106dfd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106e02:	e9 a3 f0 ff ff       	jmp    80105eaa <alltraps>
80106e07:	66 90                	xchg   %ax,%ax
80106e09:	66 90                	xchg   %ax,%ax
80106e0b:	66 90                	xchg   %ax,%ax
80106e0d:	66 90                	xchg   %ax,%ax
80106e0f:	90                   	nop

80106e10 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106e10:	55                   	push   %ebp
80106e11:	89 e5                	mov    %esp,%ebp
80106e13:	57                   	push   %edi
80106e14:	56                   	push   %esi
80106e15:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106e16:	89 d3                	mov    %edx,%ebx
{
80106e18:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106e1a:	c1 eb 16             	shr    $0x16,%ebx
80106e1d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106e20:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106e23:	8b 06                	mov    (%esi),%eax
80106e25:	a8 01                	test   $0x1,%al
80106e27:	74 27                	je     80106e50 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106e29:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106e2e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106e34:	c1 ef 0a             	shr    $0xa,%edi
}
80106e37:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106e3a:	89 fa                	mov    %edi,%edx
80106e3c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106e42:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106e45:	5b                   	pop    %ebx
80106e46:	5e                   	pop    %esi
80106e47:	5f                   	pop    %edi
80106e48:	5d                   	pop    %ebp
80106e49:	c3                   	ret    
80106e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106e50:	85 c9                	test   %ecx,%ecx
80106e52:	74 2c                	je     80106e80 <walkpgdir+0x70>
80106e54:	e8 77 b6 ff ff       	call   801024d0 <kalloc>
80106e59:	85 c0                	test   %eax,%eax
80106e5b:	89 c3                	mov    %eax,%ebx
80106e5d:	74 21                	je     80106e80 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106e5f:	83 ec 04             	sub    $0x4,%esp
80106e62:	68 00 10 00 00       	push   $0x1000
80106e67:	6a 00                	push   $0x0
80106e69:	50                   	push   %eax
80106e6a:	e8 51 dd ff ff       	call   80104bc0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106e6f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e75:	83 c4 10             	add    $0x10,%esp
80106e78:	83 c8 07             	or     $0x7,%eax
80106e7b:	89 06                	mov    %eax,(%esi)
80106e7d:	eb b5                	jmp    80106e34 <walkpgdir+0x24>
80106e7f:	90                   	nop
}
80106e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106e83:	31 c0                	xor    %eax,%eax
}
80106e85:	5b                   	pop    %ebx
80106e86:	5e                   	pop    %esi
80106e87:	5f                   	pop    %edi
80106e88:	5d                   	pop    %ebp
80106e89:	c3                   	ret    
80106e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e90 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	57                   	push   %edi
80106e94:	56                   	push   %esi
80106e95:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106e96:	89 d3                	mov    %edx,%ebx
80106e98:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106e9e:	83 ec 1c             	sub    $0x1c,%esp
80106ea1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106ea4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106ea8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106eab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106eb0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106eb3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106eb6:	29 df                	sub    %ebx,%edi
80106eb8:	83 c8 01             	or     $0x1,%eax
80106ebb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106ebe:	eb 15                	jmp    80106ed5 <mappages+0x45>
    if(*pte & PTE_P)
80106ec0:	f6 00 01             	testb  $0x1,(%eax)
80106ec3:	75 45                	jne    80106f0a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106ec5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106ec8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106ecb:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106ecd:	74 31                	je     80106f00 <mappages+0x70>
      break;
    a += PGSIZE;
80106ecf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106ed5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ed8:	b9 01 00 00 00       	mov    $0x1,%ecx
80106edd:	89 da                	mov    %ebx,%edx
80106edf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106ee2:	e8 29 ff ff ff       	call   80106e10 <walkpgdir>
80106ee7:	85 c0                	test   %eax,%eax
80106ee9:	75 d5                	jne    80106ec0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106eeb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106eee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ef3:	5b                   	pop    %ebx
80106ef4:	5e                   	pop    %esi
80106ef5:	5f                   	pop    %edi
80106ef6:	5d                   	pop    %ebp
80106ef7:	c3                   	ret    
80106ef8:	90                   	nop
80106ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f00:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f03:	31 c0                	xor    %eax,%eax
}
80106f05:	5b                   	pop    %ebx
80106f06:	5e                   	pop    %esi
80106f07:	5f                   	pop    %edi
80106f08:	5d                   	pop    %ebp
80106f09:	c3                   	ret    
      panic("remap");
80106f0a:	83 ec 0c             	sub    $0xc,%esp
80106f0d:	68 94 80 10 80       	push   $0x80108094
80106f12:	e8 79 94 ff ff       	call   80100390 <panic>
80106f17:	89 f6                	mov    %esi,%esi
80106f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f20 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106f20:	55                   	push   %ebp
80106f21:	89 e5                	mov    %esp,%ebp
80106f23:	57                   	push   %edi
80106f24:	56                   	push   %esi
80106f25:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106f26:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106f2c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106f2e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106f34:	83 ec 1c             	sub    $0x1c,%esp
80106f37:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106f3a:	39 d3                	cmp    %edx,%ebx
80106f3c:	73 66                	jae    80106fa4 <deallocuvm.part.0+0x84>
80106f3e:	89 d6                	mov    %edx,%esi
80106f40:	eb 3d                	jmp    80106f7f <deallocuvm.part.0+0x5f>
80106f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106f48:	8b 10                	mov    (%eax),%edx
80106f4a:	f6 c2 01             	test   $0x1,%dl
80106f4d:	74 26                	je     80106f75 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106f4f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106f55:	74 58                	je     80106faf <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106f57:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106f5a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106f60:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106f63:	52                   	push   %edx
80106f64:	e8 b7 b3 ff ff       	call   80102320 <kfree>
      *pte = 0;
80106f69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f6c:	83 c4 10             	add    $0x10,%esp
80106f6f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106f75:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f7b:	39 f3                	cmp    %esi,%ebx
80106f7d:	73 25                	jae    80106fa4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106f7f:	31 c9                	xor    %ecx,%ecx
80106f81:	89 da                	mov    %ebx,%edx
80106f83:	89 f8                	mov    %edi,%eax
80106f85:	e8 86 fe ff ff       	call   80106e10 <walkpgdir>
    if(!pte)
80106f8a:	85 c0                	test   %eax,%eax
80106f8c:	75 ba                	jne    80106f48 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106f8e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106f94:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106f9a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106fa0:	39 f3                	cmp    %esi,%ebx
80106fa2:	72 db                	jb     80106f7f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106fa4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106fa7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106faa:	5b                   	pop    %ebx
80106fab:	5e                   	pop    %esi
80106fac:	5f                   	pop    %edi
80106fad:	5d                   	pop    %ebp
80106fae:	c3                   	ret    
        panic("kfree");
80106faf:	83 ec 0c             	sub    $0xc,%esp
80106fb2:	68 a6 79 10 80       	push   $0x801079a6
80106fb7:	e8 d4 93 ff ff       	call   80100390 <panic>
80106fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106fc0 <seginit>:
{
80106fc0:	55                   	push   %ebp
80106fc1:	89 e5                	mov    %esp,%ebp
80106fc3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106fc6:	e8 75 cb ff ff       	call   80103b40 <cpuid>
80106fcb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106fd1:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106fd6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106fda:	c7 80 b8 3a 11 80 ff 	movl   $0xffff,-0x7feec548(%eax)
80106fe1:	ff 00 00 
80106fe4:	c7 80 bc 3a 11 80 00 	movl   $0xcf9a00,-0x7feec544(%eax)
80106feb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106fee:	c7 80 c0 3a 11 80 ff 	movl   $0xffff,-0x7feec540(%eax)
80106ff5:	ff 00 00 
80106ff8:	c7 80 c4 3a 11 80 00 	movl   $0xcf9200,-0x7feec53c(%eax)
80106fff:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107002:	c7 80 c8 3a 11 80 ff 	movl   $0xffff,-0x7feec538(%eax)
80107009:	ff 00 00 
8010700c:	c7 80 cc 3a 11 80 00 	movl   $0xcffa00,-0x7feec534(%eax)
80107013:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107016:	c7 80 d0 3a 11 80 ff 	movl   $0xffff,-0x7feec530(%eax)
8010701d:	ff 00 00 
80107020:	c7 80 d4 3a 11 80 00 	movl   $0xcff200,-0x7feec52c(%eax)
80107027:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010702a:	05 b0 3a 11 80       	add    $0x80113ab0,%eax
  pd[1] = (uint)p;
8010702f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107033:	c1 e8 10             	shr    $0x10,%eax
80107036:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010703a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010703d:	0f 01 10             	lgdtl  (%eax)
}
80107040:	c9                   	leave  
80107041:	c3                   	ret    
80107042:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107050 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107050:	a1 04 3a 13 80       	mov    0x80133a04,%eax
{
80107055:	55                   	push   %ebp
80107056:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107058:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010705d:	0f 22 d8             	mov    %eax,%cr3
}
80107060:	5d                   	pop    %ebp
80107061:	c3                   	ret    
80107062:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107070 <switchuvm>:
{
80107070:	55                   	push   %ebp
80107071:	89 e5                	mov    %esp,%ebp
80107073:	57                   	push   %edi
80107074:	56                   	push   %esi
80107075:	53                   	push   %ebx
80107076:	83 ec 1c             	sub    $0x1c,%esp
80107079:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010707c:	85 db                	test   %ebx,%ebx
8010707e:	0f 84 cb 00 00 00    	je     8010714f <switchuvm+0xdf>
  if(p->kstack == 0)
80107084:	8b 43 08             	mov    0x8(%ebx),%eax
80107087:	85 c0                	test   %eax,%eax
80107089:	0f 84 da 00 00 00    	je     80107169 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010708f:	8b 43 04             	mov    0x4(%ebx),%eax
80107092:	85 c0                	test   %eax,%eax
80107094:	0f 84 c2 00 00 00    	je     8010715c <switchuvm+0xec>
  pushcli();
8010709a:	e8 41 d9 ff ff       	call   801049e0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010709f:	e8 1c ca ff ff       	call   80103ac0 <mycpu>
801070a4:	89 c6                	mov    %eax,%esi
801070a6:	e8 15 ca ff ff       	call   80103ac0 <mycpu>
801070ab:	89 c7                	mov    %eax,%edi
801070ad:	e8 0e ca ff ff       	call   80103ac0 <mycpu>
801070b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801070b5:	83 c7 08             	add    $0x8,%edi
801070b8:	e8 03 ca ff ff       	call   80103ac0 <mycpu>
801070bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801070c0:	83 c0 08             	add    $0x8,%eax
801070c3:	ba 67 00 00 00       	mov    $0x67,%edx
801070c8:	c1 e8 18             	shr    $0x18,%eax
801070cb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801070d2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801070d9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801070df:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801070e4:	83 c1 08             	add    $0x8,%ecx
801070e7:	c1 e9 10             	shr    $0x10,%ecx
801070ea:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801070f0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801070f5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801070fc:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107101:	e8 ba c9 ff ff       	call   80103ac0 <mycpu>
80107106:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010710d:	e8 ae c9 ff ff       	call   80103ac0 <mycpu>
80107112:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107116:	8b 73 08             	mov    0x8(%ebx),%esi
80107119:	e8 a2 c9 ff ff       	call   80103ac0 <mycpu>
8010711e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107124:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107127:	e8 94 c9 ff ff       	call   80103ac0 <mycpu>
8010712c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107130:	b8 28 00 00 00       	mov    $0x28,%eax
80107135:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107138:	8b 43 04             	mov    0x4(%ebx),%eax
8010713b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107140:	0f 22 d8             	mov    %eax,%cr3
}
80107143:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107146:	5b                   	pop    %ebx
80107147:	5e                   	pop    %esi
80107148:	5f                   	pop    %edi
80107149:	5d                   	pop    %ebp
  popcli();
8010714a:	e9 d1 d8 ff ff       	jmp    80104a20 <popcli>
    panic("switchuvm: no process");
8010714f:	83 ec 0c             	sub    $0xc,%esp
80107152:	68 9a 80 10 80       	push   $0x8010809a
80107157:	e8 34 92 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
8010715c:	83 ec 0c             	sub    $0xc,%esp
8010715f:	68 c5 80 10 80       	push   $0x801080c5
80107164:	e8 27 92 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80107169:	83 ec 0c             	sub    $0xc,%esp
8010716c:	68 b0 80 10 80       	push   $0x801080b0
80107171:	e8 1a 92 ff ff       	call   80100390 <panic>
80107176:	8d 76 00             	lea    0x0(%esi),%esi
80107179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107180 <inituvm>:
{
80107180:	55                   	push   %ebp
80107181:	89 e5                	mov    %esp,%ebp
80107183:	57                   	push   %edi
80107184:	56                   	push   %esi
80107185:	53                   	push   %ebx
80107186:	83 ec 1c             	sub    $0x1c,%esp
80107189:	8b 75 10             	mov    0x10(%ebp),%esi
8010718c:	8b 45 08             	mov    0x8(%ebp),%eax
8010718f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107192:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107198:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010719b:	77 49                	ja     801071e6 <inituvm+0x66>
  mem = kalloc();
8010719d:	e8 2e b3 ff ff       	call   801024d0 <kalloc>
  memset(mem, 0, PGSIZE);
801071a2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
801071a5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801071a7:	68 00 10 00 00       	push   $0x1000
801071ac:	6a 00                	push   $0x0
801071ae:	50                   	push   %eax
801071af:	e8 0c da ff ff       	call   80104bc0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801071b4:	58                   	pop    %eax
801071b5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801071bb:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071c0:	5a                   	pop    %edx
801071c1:	6a 06                	push   $0x6
801071c3:	50                   	push   %eax
801071c4:	31 d2                	xor    %edx,%edx
801071c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801071c9:	e8 c2 fc ff ff       	call   80106e90 <mappages>
  memmove(mem, init, sz);
801071ce:	89 75 10             	mov    %esi,0x10(%ebp)
801071d1:	89 7d 0c             	mov    %edi,0xc(%ebp)
801071d4:	83 c4 10             	add    $0x10,%esp
801071d7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801071da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071dd:	5b                   	pop    %ebx
801071de:	5e                   	pop    %esi
801071df:	5f                   	pop    %edi
801071e0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801071e1:	e9 8a da ff ff       	jmp    80104c70 <memmove>
    panic("inituvm: more than a page");
801071e6:	83 ec 0c             	sub    $0xc,%esp
801071e9:	68 d9 80 10 80       	push   $0x801080d9
801071ee:	e8 9d 91 ff ff       	call   80100390 <panic>
801071f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801071f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107200 <loaduvm>:
{
80107200:	55                   	push   %ebp
80107201:	89 e5                	mov    %esp,%ebp
80107203:	57                   	push   %edi
80107204:	56                   	push   %esi
80107205:	53                   	push   %ebx
80107206:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107209:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107210:	0f 85 91 00 00 00    	jne    801072a7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107216:	8b 75 18             	mov    0x18(%ebp),%esi
80107219:	31 db                	xor    %ebx,%ebx
8010721b:	85 f6                	test   %esi,%esi
8010721d:	75 1a                	jne    80107239 <loaduvm+0x39>
8010721f:	eb 6f                	jmp    80107290 <loaduvm+0x90>
80107221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107228:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010722e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107234:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107237:	76 57                	jbe    80107290 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107239:	8b 55 0c             	mov    0xc(%ebp),%edx
8010723c:	8b 45 08             	mov    0x8(%ebp),%eax
8010723f:	31 c9                	xor    %ecx,%ecx
80107241:	01 da                	add    %ebx,%edx
80107243:	e8 c8 fb ff ff       	call   80106e10 <walkpgdir>
80107248:	85 c0                	test   %eax,%eax
8010724a:	74 4e                	je     8010729a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
8010724c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010724e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80107251:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107256:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010725b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107261:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107264:	01 d9                	add    %ebx,%ecx
80107266:	05 00 00 00 80       	add    $0x80000000,%eax
8010726b:	57                   	push   %edi
8010726c:	51                   	push   %ecx
8010726d:	50                   	push   %eax
8010726e:	ff 75 10             	pushl  0x10(%ebp)
80107271:	e8 fa a6 ff ff       	call   80101970 <readi>
80107276:	83 c4 10             	add    $0x10,%esp
80107279:	39 f8                	cmp    %edi,%eax
8010727b:	74 ab                	je     80107228 <loaduvm+0x28>
}
8010727d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107285:	5b                   	pop    %ebx
80107286:	5e                   	pop    %esi
80107287:	5f                   	pop    %edi
80107288:	5d                   	pop    %ebp
80107289:	c3                   	ret    
8010728a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107290:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107293:	31 c0                	xor    %eax,%eax
}
80107295:	5b                   	pop    %ebx
80107296:	5e                   	pop    %esi
80107297:	5f                   	pop    %edi
80107298:	5d                   	pop    %ebp
80107299:	c3                   	ret    
      panic("loaduvm: address should exist");
8010729a:	83 ec 0c             	sub    $0xc,%esp
8010729d:	68 f3 80 10 80       	push   $0x801080f3
801072a2:	e8 e9 90 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801072a7:	83 ec 0c             	sub    $0xc,%esp
801072aa:	68 94 81 10 80       	push   $0x80108194
801072af:	e8 dc 90 ff ff       	call   80100390 <panic>
801072b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801072ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801072c0 <allocuvm>:
{
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	57                   	push   %edi
801072c4:	56                   	push   %esi
801072c5:	53                   	push   %ebx
801072c6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801072c9:	8b 7d 10             	mov    0x10(%ebp),%edi
801072cc:	85 ff                	test   %edi,%edi
801072ce:	0f 88 8e 00 00 00    	js     80107362 <allocuvm+0xa2>
  if(newsz < oldsz)
801072d4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801072d7:	0f 82 93 00 00 00    	jb     80107370 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
801072dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801072e0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801072e6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801072ec:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801072ef:	0f 86 7e 00 00 00    	jbe    80107373 <allocuvm+0xb3>
801072f5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801072f8:	8b 7d 08             	mov    0x8(%ebp),%edi
801072fb:	eb 42                	jmp    8010733f <allocuvm+0x7f>
801072fd:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107300:	83 ec 04             	sub    $0x4,%esp
80107303:	68 00 10 00 00       	push   $0x1000
80107308:	6a 00                	push   $0x0
8010730a:	50                   	push   %eax
8010730b:	e8 b0 d8 ff ff       	call   80104bc0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107310:	58                   	pop    %eax
80107311:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107317:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010731c:	5a                   	pop    %edx
8010731d:	6a 06                	push   $0x6
8010731f:	50                   	push   %eax
80107320:	89 da                	mov    %ebx,%edx
80107322:	89 f8                	mov    %edi,%eax
80107324:	e8 67 fb ff ff       	call   80106e90 <mappages>
80107329:	83 c4 10             	add    $0x10,%esp
8010732c:	85 c0                	test   %eax,%eax
8010732e:	78 50                	js     80107380 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80107330:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107336:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107339:	0f 86 81 00 00 00    	jbe    801073c0 <allocuvm+0x100>
    mem = kalloc();
8010733f:	e8 8c b1 ff ff       	call   801024d0 <kalloc>
    if(mem == 0){
80107344:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107346:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107348:	75 b6                	jne    80107300 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010734a:	83 ec 0c             	sub    $0xc,%esp
8010734d:	68 11 81 10 80       	push   $0x80108111
80107352:	e8 09 93 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80107357:	83 c4 10             	add    $0x10,%esp
8010735a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010735d:	39 45 10             	cmp    %eax,0x10(%ebp)
80107360:	77 6e                	ja     801073d0 <allocuvm+0x110>
}
80107362:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107365:	31 ff                	xor    %edi,%edi
}
80107367:	89 f8                	mov    %edi,%eax
80107369:	5b                   	pop    %ebx
8010736a:	5e                   	pop    %esi
8010736b:	5f                   	pop    %edi
8010736c:	5d                   	pop    %ebp
8010736d:	c3                   	ret    
8010736e:	66 90                	xchg   %ax,%ax
    return oldsz;
80107370:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107373:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107376:	89 f8                	mov    %edi,%eax
80107378:	5b                   	pop    %ebx
80107379:	5e                   	pop    %esi
8010737a:	5f                   	pop    %edi
8010737b:	5d                   	pop    %ebp
8010737c:	c3                   	ret    
8010737d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107380:	83 ec 0c             	sub    $0xc,%esp
80107383:	68 29 81 10 80       	push   $0x80108129
80107388:	e8 d3 92 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010738d:	83 c4 10             	add    $0x10,%esp
80107390:	8b 45 0c             	mov    0xc(%ebp),%eax
80107393:	39 45 10             	cmp    %eax,0x10(%ebp)
80107396:	76 0d                	jbe    801073a5 <allocuvm+0xe5>
80107398:	89 c1                	mov    %eax,%ecx
8010739a:	8b 55 10             	mov    0x10(%ebp),%edx
8010739d:	8b 45 08             	mov    0x8(%ebp),%eax
801073a0:	e8 7b fb ff ff       	call   80106f20 <deallocuvm.part.0>
      kfree(mem);
801073a5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
801073a8:	31 ff                	xor    %edi,%edi
      kfree(mem);
801073aa:	56                   	push   %esi
801073ab:	e8 70 af ff ff       	call   80102320 <kfree>
      return 0;
801073b0:	83 c4 10             	add    $0x10,%esp
}
801073b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073b6:	89 f8                	mov    %edi,%eax
801073b8:	5b                   	pop    %ebx
801073b9:	5e                   	pop    %esi
801073ba:	5f                   	pop    %edi
801073bb:	5d                   	pop    %ebp
801073bc:	c3                   	ret    
801073bd:	8d 76 00             	lea    0x0(%esi),%esi
801073c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801073c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073c6:	5b                   	pop    %ebx
801073c7:	89 f8                	mov    %edi,%eax
801073c9:	5e                   	pop    %esi
801073ca:	5f                   	pop    %edi
801073cb:	5d                   	pop    %ebp
801073cc:	c3                   	ret    
801073cd:	8d 76 00             	lea    0x0(%esi),%esi
801073d0:	89 c1                	mov    %eax,%ecx
801073d2:	8b 55 10             	mov    0x10(%ebp),%edx
801073d5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
801073d8:	31 ff                	xor    %edi,%edi
801073da:	e8 41 fb ff ff       	call   80106f20 <deallocuvm.part.0>
801073df:	eb 92                	jmp    80107373 <allocuvm+0xb3>
801073e1:	eb 0d                	jmp    801073f0 <deallocuvm>
801073e3:	90                   	nop
801073e4:	90                   	nop
801073e5:	90                   	nop
801073e6:	90                   	nop
801073e7:	90                   	nop
801073e8:	90                   	nop
801073e9:	90                   	nop
801073ea:	90                   	nop
801073eb:	90                   	nop
801073ec:	90                   	nop
801073ed:	90                   	nop
801073ee:	90                   	nop
801073ef:	90                   	nop

801073f0 <deallocuvm>:
{
801073f0:	55                   	push   %ebp
801073f1:	89 e5                	mov    %esp,%ebp
801073f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801073f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801073f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801073fc:	39 d1                	cmp    %edx,%ecx
801073fe:	73 10                	jae    80107410 <deallocuvm+0x20>
}
80107400:	5d                   	pop    %ebp
80107401:	e9 1a fb ff ff       	jmp    80106f20 <deallocuvm.part.0>
80107406:	8d 76 00             	lea    0x0(%esi),%esi
80107409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107410:	89 d0                	mov    %edx,%eax
80107412:	5d                   	pop    %ebp
80107413:	c3                   	ret    
80107414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010741a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107420 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107420:	55                   	push   %ebp
80107421:	89 e5                	mov    %esp,%ebp
80107423:	57                   	push   %edi
80107424:	56                   	push   %esi
80107425:	53                   	push   %ebx
80107426:	83 ec 0c             	sub    $0xc,%esp
80107429:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010742c:	85 f6                	test   %esi,%esi
8010742e:	74 59                	je     80107489 <freevm+0x69>
80107430:	31 c9                	xor    %ecx,%ecx
80107432:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107437:	89 f0                	mov    %esi,%eax
80107439:	e8 e2 fa ff ff       	call   80106f20 <deallocuvm.part.0>
8010743e:	89 f3                	mov    %esi,%ebx
80107440:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107446:	eb 0f                	jmp    80107457 <freevm+0x37>
80107448:	90                   	nop
80107449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107450:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107453:	39 fb                	cmp    %edi,%ebx
80107455:	74 23                	je     8010747a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107457:	8b 03                	mov    (%ebx),%eax
80107459:	a8 01                	test   $0x1,%al
8010745b:	74 f3                	je     80107450 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010745d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107462:	83 ec 0c             	sub    $0xc,%esp
80107465:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107468:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010746d:	50                   	push   %eax
8010746e:	e8 ad ae ff ff       	call   80102320 <kfree>
80107473:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107476:	39 fb                	cmp    %edi,%ebx
80107478:	75 dd                	jne    80107457 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010747a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010747d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107480:	5b                   	pop    %ebx
80107481:	5e                   	pop    %esi
80107482:	5f                   	pop    %edi
80107483:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107484:	e9 97 ae ff ff       	jmp    80102320 <kfree>
    panic("freevm: no pgdir");
80107489:	83 ec 0c             	sub    $0xc,%esp
8010748c:	68 45 81 10 80       	push   $0x80108145
80107491:	e8 fa 8e ff ff       	call   80100390 <panic>
80107496:	8d 76 00             	lea    0x0(%esi),%esi
80107499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801074a0 <setupkvm>:
{
801074a0:	55                   	push   %ebp
801074a1:	89 e5                	mov    %esp,%ebp
801074a3:	56                   	push   %esi
801074a4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801074a5:	e8 26 b0 ff ff       	call   801024d0 <kalloc>
801074aa:	85 c0                	test   %eax,%eax
801074ac:	89 c6                	mov    %eax,%esi
801074ae:	74 42                	je     801074f2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801074b0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801074b3:	bb c0 b6 10 80       	mov    $0x8010b6c0,%ebx
  memset(pgdir, 0, PGSIZE);
801074b8:	68 00 10 00 00       	push   $0x1000
801074bd:	6a 00                	push   $0x0
801074bf:	50                   	push   %eax
801074c0:	e8 fb d6 ff ff       	call   80104bc0 <memset>
801074c5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801074c8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801074cb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801074ce:	83 ec 08             	sub    $0x8,%esp
801074d1:	8b 13                	mov    (%ebx),%edx
801074d3:	ff 73 0c             	pushl  0xc(%ebx)
801074d6:	50                   	push   %eax
801074d7:	29 c1                	sub    %eax,%ecx
801074d9:	89 f0                	mov    %esi,%eax
801074db:	e8 b0 f9 ff ff       	call   80106e90 <mappages>
801074e0:	83 c4 10             	add    $0x10,%esp
801074e3:	85 c0                	test   %eax,%eax
801074e5:	78 19                	js     80107500 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801074e7:	83 c3 10             	add    $0x10,%ebx
801074ea:	81 fb 00 b7 10 80    	cmp    $0x8010b700,%ebx
801074f0:	75 d6                	jne    801074c8 <setupkvm+0x28>
}
801074f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801074f5:	89 f0                	mov    %esi,%eax
801074f7:	5b                   	pop    %ebx
801074f8:	5e                   	pop    %esi
801074f9:	5d                   	pop    %ebp
801074fa:	c3                   	ret    
801074fb:	90                   	nop
801074fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107500:	83 ec 0c             	sub    $0xc,%esp
80107503:	56                   	push   %esi
      return 0;
80107504:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107506:	e8 15 ff ff ff       	call   80107420 <freevm>
      return 0;
8010750b:	83 c4 10             	add    $0x10,%esp
}
8010750e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107511:	89 f0                	mov    %esi,%eax
80107513:	5b                   	pop    %ebx
80107514:	5e                   	pop    %esi
80107515:	5d                   	pop    %ebp
80107516:	c3                   	ret    
80107517:	89 f6                	mov    %esi,%esi
80107519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107520 <kvmalloc>:
{
80107520:	55                   	push   %ebp
80107521:	89 e5                	mov    %esp,%ebp
80107523:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107526:	e8 75 ff ff ff       	call   801074a0 <setupkvm>
8010752b:	a3 04 3a 13 80       	mov    %eax,0x80133a04
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107530:	05 00 00 00 80       	add    $0x80000000,%eax
80107535:	0f 22 d8             	mov    %eax,%cr3
}
80107538:	c9                   	leave  
80107539:	c3                   	ret    
8010753a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107540 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107540:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107541:	31 c9                	xor    %ecx,%ecx
{
80107543:	89 e5                	mov    %esp,%ebp
80107545:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107548:	8b 55 0c             	mov    0xc(%ebp),%edx
8010754b:	8b 45 08             	mov    0x8(%ebp),%eax
8010754e:	e8 bd f8 ff ff       	call   80106e10 <walkpgdir>
  if(pte == 0)
80107553:	85 c0                	test   %eax,%eax
80107555:	74 05                	je     8010755c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107557:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010755a:	c9                   	leave  
8010755b:	c3                   	ret    
    panic("clearpteu");
8010755c:	83 ec 0c             	sub    $0xc,%esp
8010755f:	68 56 81 10 80       	push   $0x80108156
80107564:	e8 27 8e ff ff       	call   80100390 <panic>
80107569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107570 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107570:	55                   	push   %ebp
80107571:	89 e5                	mov    %esp,%ebp
80107573:	57                   	push   %edi
80107574:	56                   	push   %esi
80107575:	53                   	push   %ebx
80107576:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107579:	e8 22 ff ff ff       	call   801074a0 <setupkvm>
8010757e:	85 c0                	test   %eax,%eax
80107580:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107583:	0f 84 9f 00 00 00    	je     80107628 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107589:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010758c:	85 c9                	test   %ecx,%ecx
8010758e:	0f 84 94 00 00 00    	je     80107628 <copyuvm+0xb8>
80107594:	31 ff                	xor    %edi,%edi
80107596:	eb 4a                	jmp    801075e2 <copyuvm+0x72>
80107598:	90                   	nop
80107599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801075a0:	83 ec 04             	sub    $0x4,%esp
801075a3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801075a9:	68 00 10 00 00       	push   $0x1000
801075ae:	53                   	push   %ebx
801075af:	50                   	push   %eax
801075b0:	e8 bb d6 ff ff       	call   80104c70 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801075b5:	58                   	pop    %eax
801075b6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801075bc:	b9 00 10 00 00       	mov    $0x1000,%ecx
801075c1:	5a                   	pop    %edx
801075c2:	ff 75 e4             	pushl  -0x1c(%ebp)
801075c5:	50                   	push   %eax
801075c6:	89 fa                	mov    %edi,%edx
801075c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801075cb:	e8 c0 f8 ff ff       	call   80106e90 <mappages>
801075d0:	83 c4 10             	add    $0x10,%esp
801075d3:	85 c0                	test   %eax,%eax
801075d5:	78 61                	js     80107638 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801075d7:	81 c7 00 10 00 00    	add    $0x1000,%edi
801075dd:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801075e0:	76 46                	jbe    80107628 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801075e2:	8b 45 08             	mov    0x8(%ebp),%eax
801075e5:	31 c9                	xor    %ecx,%ecx
801075e7:	89 fa                	mov    %edi,%edx
801075e9:	e8 22 f8 ff ff       	call   80106e10 <walkpgdir>
801075ee:	85 c0                	test   %eax,%eax
801075f0:	74 61                	je     80107653 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801075f2:	8b 00                	mov    (%eax),%eax
801075f4:	a8 01                	test   $0x1,%al
801075f6:	74 4e                	je     80107646 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801075f8:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
801075fa:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
801075ff:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107605:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107608:	e8 c3 ae ff ff       	call   801024d0 <kalloc>
8010760d:	85 c0                	test   %eax,%eax
8010760f:	89 c6                	mov    %eax,%esi
80107611:	75 8d                	jne    801075a0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107613:	83 ec 0c             	sub    $0xc,%esp
80107616:	ff 75 e0             	pushl  -0x20(%ebp)
80107619:	e8 02 fe ff ff       	call   80107420 <freevm>
  return 0;
8010761e:	83 c4 10             	add    $0x10,%esp
80107621:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107628:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010762b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010762e:	5b                   	pop    %ebx
8010762f:	5e                   	pop    %esi
80107630:	5f                   	pop    %edi
80107631:	5d                   	pop    %ebp
80107632:	c3                   	ret    
80107633:	90                   	nop
80107634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107638:	83 ec 0c             	sub    $0xc,%esp
8010763b:	56                   	push   %esi
8010763c:	e8 df ac ff ff       	call   80102320 <kfree>
      goto bad;
80107641:	83 c4 10             	add    $0x10,%esp
80107644:	eb cd                	jmp    80107613 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107646:	83 ec 0c             	sub    $0xc,%esp
80107649:	68 7a 81 10 80       	push   $0x8010817a
8010764e:	e8 3d 8d ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107653:	83 ec 0c             	sub    $0xc,%esp
80107656:	68 60 81 10 80       	push   $0x80108160
8010765b:	e8 30 8d ff ff       	call   80100390 <panic>

80107660 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107660:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107661:	31 c9                	xor    %ecx,%ecx
{
80107663:	89 e5                	mov    %esp,%ebp
80107665:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107668:	8b 55 0c             	mov    0xc(%ebp),%edx
8010766b:	8b 45 08             	mov    0x8(%ebp),%eax
8010766e:	e8 9d f7 ff ff       	call   80106e10 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107673:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107675:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107676:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107678:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010767d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107680:	05 00 00 00 80       	add    $0x80000000,%eax
80107685:	83 fa 05             	cmp    $0x5,%edx
80107688:	ba 00 00 00 00       	mov    $0x0,%edx
8010768d:	0f 45 c2             	cmovne %edx,%eax
}
80107690:	c3                   	ret    
80107691:	eb 0d                	jmp    801076a0 <copyout>
80107693:	90                   	nop
80107694:	90                   	nop
80107695:	90                   	nop
80107696:	90                   	nop
80107697:	90                   	nop
80107698:	90                   	nop
80107699:	90                   	nop
8010769a:	90                   	nop
8010769b:	90                   	nop
8010769c:	90                   	nop
8010769d:	90                   	nop
8010769e:	90                   	nop
8010769f:	90                   	nop

801076a0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801076a0:	55                   	push   %ebp
801076a1:	89 e5                	mov    %esp,%ebp
801076a3:	57                   	push   %edi
801076a4:	56                   	push   %esi
801076a5:	53                   	push   %ebx
801076a6:	83 ec 1c             	sub    $0x1c,%esp
801076a9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801076ac:	8b 55 0c             	mov    0xc(%ebp),%edx
801076af:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801076b2:	85 db                	test   %ebx,%ebx
801076b4:	75 40                	jne    801076f6 <copyout+0x56>
801076b6:	eb 70                	jmp    80107728 <copyout+0x88>
801076b8:	90                   	nop
801076b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801076c0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801076c3:	89 f1                	mov    %esi,%ecx
801076c5:	29 d1                	sub    %edx,%ecx
801076c7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801076cd:	39 d9                	cmp    %ebx,%ecx
801076cf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801076d2:	29 f2                	sub    %esi,%edx
801076d4:	83 ec 04             	sub    $0x4,%esp
801076d7:	01 d0                	add    %edx,%eax
801076d9:	51                   	push   %ecx
801076da:	57                   	push   %edi
801076db:	50                   	push   %eax
801076dc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801076df:	e8 8c d5 ff ff       	call   80104c70 <memmove>
    len -= n;
    buf += n;
801076e4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801076e7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801076ea:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801076f0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801076f2:	29 cb                	sub    %ecx,%ebx
801076f4:	74 32                	je     80107728 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801076f6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801076f8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801076fb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801076fe:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107704:	56                   	push   %esi
80107705:	ff 75 08             	pushl  0x8(%ebp)
80107708:	e8 53 ff ff ff       	call   80107660 <uva2ka>
    if(pa0 == 0)
8010770d:	83 c4 10             	add    $0x10,%esp
80107710:	85 c0                	test   %eax,%eax
80107712:	75 ac                	jne    801076c0 <copyout+0x20>
  }
  return 0;
}
80107714:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107717:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010771c:	5b                   	pop    %ebx
8010771d:	5e                   	pop    %esi
8010771e:	5f                   	pop    %edi
8010771f:	5d                   	pop    %ebp
80107720:	c3                   	ret    
80107721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107728:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010772b:	31 c0                	xor    %eax,%eax
}
8010772d:	5b                   	pop    %ebx
8010772e:	5e                   	pop    %esi
8010772f:	5f                   	pop    %edi
80107730:	5d                   	pop    %ebp
80107731:	c3                   	ret    

80107732 <invoke_sigret_start>:

.globl invoke_sigret_start
.globl invoke_sigret_end

invoke_sigret_start:
  movl $SYS_sigret, %eax
80107732:	b8 1e 00 00 00       	mov    $0x1e,%eax
  int $T_SYSCALL
80107737:	cd 40                	int    $0x40
