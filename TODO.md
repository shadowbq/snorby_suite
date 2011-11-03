# TODO

## Provide a YAML configuration file that allows for configuration of:

* Make barnyard2 configuration file temporary and dynamic
** This will allow for a YAML configuration of database connector
** No longer hardcode database connector to "snorby_development" / "root" / "password"

* Create Multiple Instances of barnyard to simulate multiple sensors points
** Instead of SENSOR:NULL 
** SENSOR:ONE
** SENSOR:TWO
** SENSOR:THREE

* Make the snort alert dataflow less **batchy**
** Fix the sleep(15) to another workflow.