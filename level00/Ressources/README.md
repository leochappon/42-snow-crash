We look for the files owned by flag00, with the command find, from root and redirect the error outputs to /dev/null so we get only the useful informations:

```
level00@SnowCrash:~$ find / -user flag00 2>/dev/null
/usr/sbin/john
/rofs/usr/sbin/john

level00@SnowCrash:~$ cat /usr/sbin/john
cdiiddwpgswtgt

level00@SnowCrash:~$ cat /rofs/usr/sbin/john
cdiiddwpgswtgt
```

From both files we get the same password: `cdiiddwpgswtgt`.

This password does not work but seems to be using a caesar cypher so we go to the website dcode.fr/chiffre-cesar to decrypt it by using all the rotations.

Rotation 15 gives us the most plausible password: `nottoohardhere`.

Let's try it:

```
level00@SnowCrash:~$ su flag00
Password:
Don't forget to launch getflag !

flag00@SnowCrash:~$ getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
```
