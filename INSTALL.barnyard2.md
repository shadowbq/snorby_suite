## Installation for Barnyard2

Install Barnyard2 for Unified2 File Reading

Unpack, change directories, configure with mysql support, make and install. 

```bash
cd .rvm/gems/ruby-1.9.2-*@snorby_suite_env/distro
tar -zxvf barnyard2*.tar.gz
cd barnyard2*
./configure --with-mysql
make
sudo make install
```

## Barnyard2 Configuration

* Barnyard2 will be dynamically configured in the future for flexible user, password, and hostname 

* You can modify the `config hostname` to have multiple sensors insert data into snorby via the snorby_suite.

File: /home/johnsmith/.rvm/gems/ruby-1.9.3-p125@snorby_suite_env/gems/snorby_suite-0.0.1/etc/barnyard2.conf
```bash

#-------------------------------------------------------------
#  Barnyard2 configuration file
#-------------------------------------------------------------

config hostname: jagau 
config interface: eth0

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

