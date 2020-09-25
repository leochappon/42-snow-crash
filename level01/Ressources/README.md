On Linux, passwords are commonly found in /etc/passwd:

```
level01@SnowCrash:~$ cat /etc/passwd
...
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
...
```

Only flag01 has a hashed password: `42hDRfypTqqnw`.  

We need to [download](https://www.openwall.com/john/k/john-1.9.0.tar.xz) and execute John the Ripper on our terminal to decrypt it.

```
tar -xf john-1.9.0.tar.xz

cd john-1.9.0/src

make macosx-x86-64   

cd ../run

scp -P 4242 level01@XX.XX.XXX.XX:/etc/passwd .

./john passwd 
Loaded 1 password hash (descrypt, traditional crypt(3) [DES 128/128 SSE2])
Press 'q' or Ctrl-C to abort, almost any other key for status
abcdefg          (flag01)
1g 0:00:00:00 100% 2/3 100.0g/s 150600p/s 150600c/s 150600C/s raquel..bigman
Use the "--show" option to display all of the cracked passwords reliably
Session completed
```

We found the password for flag01 : `abcdefg`.

Let's test it:

```
level01@SnowCrash:~$ su flag01
Password: 
Don't forget to launch getflag !

flag01@SnowCrash:~$ getflag
Check flag.Here is your token : f2av5il02puano7naaf6adaaf
```