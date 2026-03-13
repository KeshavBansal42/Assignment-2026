# ashura bandit wargame solutions

## level 0
Connect to the servers using ssh and read the contents of readme for the password
```
ssh bandit0@bandit.labs.overthewire.org -p 2220
cat readme
```
Password: `ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If`

## level 1
Since the file has a dashed filename we use
```
cat ./-
```
to get the password: `263JGJPfgU6LtdEvgfWU1XP5yac29mFx`

## level 2
Since the file has both spaces and a dahsed filename we use
```
cat ./--spaces\ in\ this\ filename--
```
treating ' ' as a special character '\ ' in the filename.

Password: `MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx`

## level 3
List all the hidden files and access their content to get the password.
```
cd inhere
ls -a
cat ...Hiding-From-You
```

Password: `2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ`

## level 4
Individually check the contents of each file in the inhere directory
```
cd inhere
cat ./-file00
...
```

Password: `4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw`

## level 5
List all the files in every subdirectory recursively and find the file that matches the size requirement. Read its contents to reach the password.
```
cd inhere
ls -alR
cd maybehere07
ls -a
cat .file2
```

Password: `HWasnPhtq9AVKe0dmk45nxy20cvUa6EG`

## level 6
Find the file which meets the requirements read the contents and get the password.
```
find / -user bandit7 -group bandit6 -size 33c
cat <file-path>
```

Password: `morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj`

## level 7
Find the word milionth using grep, which returns the entire line ehich contains the word, giving you the password.
```
cat data.txt | grep "millionth"
```

Password: `dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc`

## level 8
Sort the data in the data.txt and use the uniq command to find the unique line. It is necessary to soort beforehand because uniq only compares adjacent lines.
```
sort data.txt | uniq -u
```

Password: `4CKMh1JI91bUIZZPXDqGanal4xvAg0JM`

## level 9
Use the strings command to see the human readable characters and filter then lines using grep.
```
strings data.txt | grep =
```

Password: `FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey`

## level 10
Decode the contents of the data.txt using the base64 -d command and you have the password.
```
cat data.txt | base64 -d
```

Password: `dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr`

## level 11
To reverse this standard ROT13 algo we use the tr or the translate command to translate the first 13 alphabets to the next thirteen and getting the password.
```
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

Password: `7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4`

# level 12
copy the data.txt to a new dir in the temp dir. reverse hexdump the files into a new file. Check the file type. as it is a gzip compressed file, we rename it to match the extension and then uncompress it. Keep doing this with different methods of decompression dependong upon the file tpp finally get the password.
```
cd /tmp
mkdir cholebhature
cd ~
cp data.txt /tmp/cholebhature
cd /tmp/cholebhature
cat data.txt | xxd -r > hexdump
file hexdump
mv hexdump hexdump.gz
gzip -d hexdump.gz
file hexdump
mv hexdump hexdump.bz2
bzip2 -d hexdump.bz2
file hexdump
mv hexdump hexdump.gz
gzip -d hexdump.gz
file hexdump
tar -xvf hexdump
file data5.bin
tar -xvf data5.bin
file data6.bin
mv data6.bin data6.bin.bz2
bzip2 -d data6.bin.bz2
file data6.bin
tar -xvf data6.bin
file data8.bin
mv data8.bin data8.bin.gz
gzip -d data8.bin.gz
file data8.bin
cat data8.bin
```

Password: `FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn`

## level 13
Open and copy the contents of the private key, exit the server. Create a copy of the key on your device. Alter the permissions so that it doesnt throw the key not secure error. Log in to the bandit14 using this key and get the password.
```
cat sshkey.private
exit
vim sshkey.private
chmod 600 sshkey.private
ssh bandit14@bandit.labs.overthewire.org -p 2220 -i sshkey.private
cat /etc/bandit_pass/bandit14
```

Password: `MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS`

## level 14
Connect to the localhost 30000 using netcat and enter the password to get the next password.
```
nc localhost 30000
```

Password: `8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo`

## level 15
Since this time there is an ssl/tls encryption we cannot use netcat instead we use openssl, enter the password to get the next one.
```
openssl s_client -connect localhost:30001
```

Password: `kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx`

## level 16
Use nmap -p 31000-32000 which return 5 active ports, check the service version of the 5 ports to find out which ones use ssl. We find that two of the 5 use ssl.Then we feed the password to both to find which one gives the password.
```
nmap -p 31000-32000
nmap -p <5-ports> -sV 
echo "kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx" | openssl s_client -ign_eof -connect localhost:<port>

vim sshkey.private
ssh -i sshkey.private bandit17@bandit.labs.overthewire.org -p 2220
cat /etc/bandit_pass/bandit17
```

Password: `EReVavePLFHtFlFsjn3hyzMlvSuSAcRD`

## level 17
use diff command to find the difference between the two lines.
```
diff passwords.old passwords.new
```

Password: `x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO`

## level 18
As we try to login normally, we are immediately kicked out. To get the password we just add the cat readme in the connection command so that it runs and we get the password.
```
ssh bandit18@bandit.labs.overthewire.org -p 2220 'cat readme'
```

Password: `cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8`

## level 19
Execute the file for the hint which tells us that running the file with a command will execute that command as bandit20 instead of bandit19 so we read the stored pass as bandit20 and store it.
```
./bandit20-do cat /etc/bandit_pass/bandit20
```

Password: `0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO`