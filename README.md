# Snorby-Suite - Snorby Development, Stress and Testing Suite
Snorby-Suite is a basic development, stress and testing application wrapper for many tools required
to load test and develop [Snorby](https://github.com/Snorby/snorby). 

Snort and its chain of alert mechanism can be complex and time consuming to setup. Snorby_suite is designed
to quickly populate the Snorby (or other snort mysql db applications, such as BASE, OSSIM) database with actual
alerts from the alert chain. Database seeds / Fixtures can be added for instant gratification, but random thumping of 
snort alerts and the sheer numbers can be hard to model using just seed data.

## Snorby
* [Snorby](https://github.com/Snorby/snorby) - Snorby is a ruby on rails web application for network security monitoring that interfaces with current popular intrusion detection systems (Snort, Suricata and Sagan). The basic fundamental concepts behind Snorby are simplicity, organization and power. The project goal is to create a free, open source and highly competitive application for network monitoring for both private and enterprise use.

## Use [rvm](http://beginrescueend.com/) For Best Use Case
* See [INSTALL.rvm.md](snorby_suite/blob/master/INSTALL.rvm.md) for detailed setup instructions with snorby_suite.

Turn on your gemset for snorby_suite via rvm 

```bash
user$ rvm 1.9.2@snorby_suite_env
```

Run Snorby Suite

```bash
user$ snorby_suite 
```

Dynamic procs to load up X snort and barnyard via ENV['SUITE_SENSORS']

```bash
user$ SUITE_SENSORS="sensor1 sensor2 sensor3" snorby_suite
```

***From the author: Although not required, I highly recommend anyone using snorby_suite to use rvm with a independent gemset***

## Bundled Components
Snorby-Suite comes bundled the following security tools and applications:

Snorby-Suite will inject alerts by default from 10 Sensors, to populate your data.

### Prebuilt Configuration Files
* Snort IDS ~> [2.8, 2.9] - [More Info](http://www.snort.org/)
* Barnyard2 - [More Info](http://www.securixlive.com/barnyard2/index.php)
* Community Snort ruleset - [More Info](http://www.snort.org/snort-rules/?#rules)
* Foreman - [More Info](https://github.com/ddollar/foreman)

## Requirements

### Notes on Privileged Access
* You should not need *root* or *sudo* access to run **snorby_suite**, because the snort binary will not bind to an interface.
* Ensuring that your rvm instance is a local and not global will allow any user to run this application. (see INSTALL.RVM.md)

### Installed onto your users path: 

1. Barnyard2 
2. Snort ~> [2.8, 2.9] - The snort daemon service is not required to be run, it will run as batch

## Barnyard2 Notes
* see [INSTALL.barnyard2.md](snorby_suite/blob/master/INSTALL.barnyard2.md)
* Barnyard2 distro is available in your gem path snorby_suite-*/disto/barnyard2.tar.gz.
* Barnyard2 will report as a NULL interface sensor.

* You need to use Barnyard2.1.10.beta or greater. Available via github 
 - https://github.com/firnsy/barnyard2

## Feedback/Support
* [Snorby-Suite Issues Page](snorby-suite/issues)

## Official Snorby Support
* [Snorby Issues Page](https://github.com/Snorby/snorby/issues)
* [Snorby Mailing List](http://groups.google.com/group/snorby)
* Twitter - Jason Meller - @jmeller / Dustin Webber - @dwebber

## Future Usage

Future usage will be to move to native rUnified2 gem to replace barnyard2.
