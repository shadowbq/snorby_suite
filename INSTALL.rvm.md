# Snorby Suite

## Installation for rvm with ruby 1.9.2 and a nonconflicting custom gemset for user 'johnsmith'

Download and run the RVM installation script
Installing the latest release version in git:

```bash
user$ bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )
```

Install a Single-User Install Location: ~/.rvm/

Single-User:

If the install script is run as a standard, non-root user, RVM will install into the current users's home directory. 

Load RVM by appending the rvm function sourcing to your .bash_profile:

```bash
user$ echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.bash_profile
```

Reload shell configuration & test

Close out your current shell or terminal session and open a new one. You may attempt reloading your .bash_profile with the following command:

```bash
user$ source .bash_profile
```

Install Ruby 1.9.2 version for your rvm:

```bash
user$ rvm install 1.9.2
```

Use the newly installed Ruby:

```bash
user$ rvm use 1.9.2
Using /home/johnsmith/.rvm/gems/ruby-1.9.2-p378
```

Check this worked correctly:

```bash
user$ ruby -v
ruby ruby-1.9.2-p378 (2011-11-11 revision 66666) [i386-blah-x]
user$ which ruby
Using /home/johnsmith/.rvm/gems/ruby-1.9.2-p378/bin/ruby
```

You can see the gem directory of the currently selected ruby using the gemdir action:

```bash
user$ rvm gemdir
/home/johnsmith/.rvm/gems/ruby-1.9.2-p378
```

Create a custom Gemset for the snorby_suite test environment

```bash
user$ rvm gemset create snorby_suite_env
Gemset 'snorby_suite_env' created.
```

## Using RVM to install Snorby_Suite

Turn on your new rvm 

```bash
user$ rvm 1.9.2@snorby_suite_env
```

Install snorby_suite into the rvm

```bash
user$ gem install snorby_suite
```

## Using Snorby_Suite in the RVM

Turn on your new rvm 

```bash
user$ rvm 1.9.2@snorby_suite_env
```

Run Snorby Suite

```bash
user$ snorby_suite 
```

### Notes
* RVM for '1.9.2@snorby_suite_env' does not have to be loaded for Snorby web application. These two applications can run in entirely different rvm environments (As well they should).
* RVM gives you a separate gem directory for and every Ruby version and gemset. * This means that gems must be explicitly installed for each revision and gemset. RVM helps you manage this process;

###Reference:
*http://beginrescueend.com/
