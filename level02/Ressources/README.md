```
level02@SnowCrash:~$ ls
level02.pcap
```

A .pcap file contains packet data pulled from a network scan.

From our terminal we retrieve the file:

```
scp -P 4242 level02@XX.XX.XXX.XX:~/level02.pcap .

chmod 644 level02.pcap
```

Create an account on [CoudShark](https://www.cloudshark.org/captures).

We upload our file to CloudShark, then we use `Follow Stream` in the `Analysis Tools`.

```
...
..wwwbugs login: 
l
.l
e
.e
v
.v
e
.e
l
.l
X
.X

..
Password: 
ft_wandr...NDRel.L0L
.
..
Login incorrect
wwwbugs login:
```

We then click on `Hex Dump` which shows:

```
...
000000B9 66 f
000000BA 74 t
000000BB 5f _
000000BC 77 w
000000BD 61 a
000000BE 6e n
000000BF 64 d
000000C0 72 r
000000C1 7f .
000000C2 7f .
000000C3 7f .
000000C4 4e N
000000C5 44 D
000000C6 52 R
000000C7 65 e
000000C8 6c l
000000C9 7f .
000000CA 4c L
000000CB 30 0
000000CC 4c L
...
```

The password shows . with the hex value 7f whereas the real hex value of . on the ASCII table is 2e.  
The hex value 7f actually refers to [DEL]
which means that we have to remove as many characters as the amount of time the [DEL] button has been pressed and obviously remove the . residues too.

With that done, we get the actual password: `ft_waNDReL0L`

```
level02@SnowCrash:~$ su flag02
Password: 
Don't forget to launch getflag !

flag02@SnowCrash:~$ getflag
Check flag.Here is your token : kooda2puivaav1idi4f57q8iq
```