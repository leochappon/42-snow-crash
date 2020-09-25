There seems to be nothing that belongs to level14.  

We should use gdb on getflag:

```
level14@SnowCrash:~$ gdb /bin/getflag
...
Reading symbols from /bin/getflag...(no debugging symbols found)...done.

(gdb) run
Starting program: /bin/getflag 
You should not reverse this
[Inferior 1 (process 2698) exited with code 01]
```

The program has some kind of protection so, let's check what's happening inside the main.

```
(gdb) disass main
Dump of assembler code for function main:
...
   0x08048989 <+67>:    call   0x8048540 <ptrace@plt>
...
   0x08048afd <+439>:   call   0x80484b0 <getuid@plt>
...
   0x08048b02 <+444>:   mov    %eax,0x18(%esp)
...
```

The program uses ptrace which creates a failure since the debugger already uses ptrace on the program.  

First of, let's bypass ptrace by placing a catchpoint on ptrace and using the command commands that will let us specify commands to be run on that catchpoint.

Instead of ptrace returning -1 from being run a second time by the program after the debugger, we will set the return value to 0 so we don't get blocked:

```
(gdb) catch syscall ptrace
Catchpoint 1 (syscall 'ptrace' [26])

(gdb) commands 1
Type commands for breakpoint(s) 1, one per line.
End with a line saying just "end".
>set $eax = 0
>continue
>end
```

Let's test it:

```
(gdb) run
Starting program: /bin/getflag 

Catchpoint 1 (call to syscall ptrace), 0xb7fdd428 in __kernel_vsyscall ()

Catchpoint 1 (returned from syscall ptrace), 0xb7fdd428 in __kernel_vsyscall ()
Check flag.Here is your token : 
Nope there is no token here for you sorry. Try again :)
[Inferior 1 (process 2084) exited normally]
```

It worked, we bypassed ptrace but we still need to change our UID.

On an other window, let's check our UID:

```
level14@SnowCrash:~$ id -u level14
2014

level14@SnowCrash:~$ id -u flag14
3014
```

We need to change our UID from 2014 to 3014 if we want to get the token from getflag.

Now, back to our first window in gdb:

```
(gdb) break getuid
Breakpoint 2 at 0xb7ee4cc0

(gdb) run
Starting program: /bin/getflag 

Catchpoint 1 (call to syscall ptrace), 0xb7fdd428 in __kernel_vsyscall ()

Catchpoint 1 (returned from syscall ptrace), 0xb7fdd428 in __kernel_vsyscall ()

Breakpoint 2, 0xb7ee4cc0 in getuid () from /lib/i386-linux-gnu/libc.so.6

(gdb) step
Single stepping until exit from function getuid,
which has no line number information.
0x08048b02 in main ()
```

The memory address 0x08048b02 refers to a move of the register $eax.

Let's check the value held by that register:

```
(gdb) print $eax
$1 = 2014
```

It indeed has the value of the UID of level14.  

We should change it to the value of flag14's UID and check the end result:

```
(gdb) set $eax = 3014

(gdb) print $eax
$2 = 3014

(gdb) continue
Continuing.
Check flag.Here is your token : 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
[Inferior 1 (process 2282) exited normally]
```

Now we quit gdb and test our new found token:

```
level14@SnowCrash:~$ su flag14
Password: 
Congratulation. Type getflag to get the key and send it to me the owner of this livecd :)

flag14@SnowCrash:~$ getflag
Check flag.Here is your token : 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
```