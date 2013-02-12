# iosdeveloper
iosdeveloper is a ruby gem that provides a set of commands for accessing Apple Provisionin Portal.   
It lets you manage devices and provisioning profiles directly from the command line.   
It's perfectly suited for continuous integration servers.

## Getting started

### Install the gem
```gem install iosdeveloper``` will install ```iosdeveloper``` command. You'll be using that command for accessing Provisioning Portal.

### Create a config file
```iosdeveloper [-c CONFIG_FILE] init -u APPLE_ID -p PASSWORD```  
  
  
If you belong to multiple developer teams you should also provide ```-t TEAM_NAME``` flag. 

## Examples  

### List registered devices
```iodeveloper [-c CONFIG_FILE] list-devices```

### Add a new device
```iosdeveloper [-c CONFIG_FILE] add-device DEVICE_NAME DEVICE_ID```

### List provisioning profiles
```iosdeveloper [-c CONFIG_FILE] list-profiles```

### Install a provisioning profile
```iosdeveloper [-c CONFIG_FILE] install-profile PROFILE_NAME```
