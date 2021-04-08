# Bash script for hardware and software check
The script was created for ease of checking the basic parameters like IP adresses, currently
installed RAM modules, CPU information and informing the user through mail if something changes.

## Requirements
When running a script make sure you have ssmtp and mailutils installed. You can install them using apt-get.
```bash
sudo apt-get install ssmtp mailutils
```

## Mail configuration
To get an email notification you need to have mail configured. You can do that by typing
```bash
sudo nano /etc/ssmtp/ssmtp.conf
```
in your console (use other text editor if you would like to). Config file should be in format put in
[template_mail_config.conf].

## Usage
In order to run this script you need to be in the directory containing [syscheck.sh] and run it using
```bash
chmod +x syscheck.sh
./syscheck.sh
```
If there is is a problem with permissions run it using sudo.

### Project status
Project can be later modified in order to add new features and ease the accessibility.
