#!/bin/bash

mysql -u "$userid" -p"$temporary_password" -e "set global validate_password.policy=0;"
mysql -u "$userid" -p"$temporary_password" -e "set global validate_password.length=4;"
mysql -u "$userid" -p"$temporary_password" -e "set password=\"$password\";"
