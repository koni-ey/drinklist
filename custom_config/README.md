# How to provide custom settings to the drinklist app

To adjust app settings with custom (non-default) values, copy the template file `lib/config/app_config.custom.dart` to the directory `custom_config` inside the project.
Then add the settings you want to overwrite with their custom value to the `appCustomSettings` map in the file `custom_config/app_config.custom.dart`.

Custom settings defined in `custom_config/app_config.custom.dart` are only applied during the docker build though.