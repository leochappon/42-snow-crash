```
level13@SnowCrash:~$ ls
level13

level13@SnowCrash:~$ ./level13 
UID 2013 started us but we we expect 4242

level13@SnowCrash:~$ id -u level13
2013
```

We have to change our UID from 2013 to 4242 to get our token.

Let's use gdb on our executable to do so:

```
level13@SnowCrash:~$ gdb level13
...
Reading symbols from /home/user/level13/level13...(no debugging symbols found)...done.
```

Let's disassemble the main to see what's happening in the program:

```
(gdb) disass main
Dump of assembler code for function main:
   0x0804858c <+0>:     push   %ebp
   0x0804858d <+1>:     mov    %esp,%ebp
   0x0804858f <+3>:     and    $0xfffffff0,%esp
   0x08048592 <+6>:     sub    $0x10,%esp
   0x08048595 <+9>:     call   0x8048380 <getuid@plt>
   0x0804859a <+14>:    cmp    $0x1092,%eax
   0x0804859f <+19>:    je     0x80485cb <main+63>
   0x080485a1 <+21>:    call   0x8048380 <getuid@plt>
   0x080485a6 <+26>:    mov    $0x80486c8,%edx
...
```

Let's put a breakpoint on getuid so that when we run the program we can examine the memory at that instant.

```
(gdb) break getuid
Breakpoint 1 at 0x8048380

(gdb) run
Starting program: /home/user/level13/level13 

Breakpoint 1, 0xb7ee4cc0 in getuid () from /lib/i386-linux-gnu/libc.so.6
```

Now let's advance by a step from that breakpoint to see where the value of our UID is stored in program:

```
(gdb) step
Single stepping until exit from function getuid,
which has no line number information.
0x0804859a in main ()
```

The memory address 0x0804859a refers to a comparison of the register $eax.  

Let's print that register:

```
(gdb) print $eax
$1 = 2013
```

We found it so let's change it to the desired value 4242 and continue the program to check the result:

```
(gdb) set $eax = 4242

(gdb) print $eax
$2 = 4242

(gdb) continue
Continuing.
your token is 2A31L79asukciNyi8uppkEuSx
[Inferior 1 (process 2573) exited with code 050]
```