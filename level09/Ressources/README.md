```
level09@SnowCrash:~$ ls
level09  token

level09@SnowCrash:~$ cat token 
f4kmm6p|=�p�n��DB�Du{��

level09@SnowCrash:~$ ./level09 
You need to provied only one arg.

level09@SnowCrash:~$ ./level09 aaaaa
abcde
```

The executable seems to rotate above on the ASCII table, each character of the argument, the same amount of time as their index position in the string.

It seems like the file token holds the password that we want which has been passed through the executable.

So, let's make a script on our terminal called decrypt.py that does the opposite of the executable.  

Then send it to our VM:

```
scp -P 4242 decrypt.py level09@XX.XX.XXX.XX:/tmp
```

Now, let's use the python script to decrypt the content of token

```
level09@SnowCrash:~$ python /tmp/decrypt.py `cat token`
f3iji1ju5yuevaus41q1afiuq

level09@SnowCrash:~$ su flag09
Password: 
Don't forget to launch getflag !

flag09@SnowCrash:~$ getflag
Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
```