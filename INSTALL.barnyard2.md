## Installation for Barnyard2

Install Barnyard2 for Unified2 File Reading

https://github.com/firnsy/barnyard2

Unpack, change directories, configure with mysql support, make and install. 

```bash
cd .rvm/gems/ruby-1.9.2-*@snorby_suite_env/distro
tar -zxvf barnyard2*.tar.gz
cd barnyard2*
./autoconfig.sh
./configure --with-mysql
make
sudo make install
```

### Advanced Explicit FreeSDB 9.0 64bit Mysql Config Example

```bash
./configure --with-mysql --with-mysql-includes=/usr/local/include/mysql --with-mysql-libraries=/usr/local/lib/mysql --prefix=/usr/local --mandir=/usr/local/man --infodir=/usr/local/info/ --build=amd64-portbld-freebsd9.0
```


## Barnyard2 Configuration

* Snorby_Suite's parallel Barnyard2 is dynamically configured for sensor hostnames use ENV['Suite_Sensors']

* Traditionally you can modify the `config hostname` to have multiple sensors insert data into snorby. This setting is overridden on the commandline during the ProcFile Execution of snorby_suite.

File: /home/johnsmith/.rvm/gems/ruby-1.9.3-p125@snorby_suite_env/gems/snorby_suite-*/etc/barnyard2.conf

```bash

#-------------------------------------------------------------
#  Barnyard2 configuration file
#-------------------------------------------------------------

# config hostname: jagau 
# config interface: eth0

input unified2

# database: log to a variety of databases
# ---------------------------------------
# See doc/README.database for additional information.
# Examples:
#output database: log, mysql, user=root password=s3cr3ts@us3 dbname=snorby_development host=localhost

output database: alert, mysql, user=snorby password=s3cr3tsauce dbname=snorby host=localhost
```


### Future Usage

Future will be native rUnified2 gem.

