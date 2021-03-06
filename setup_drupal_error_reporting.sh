#!/bin/bash
# turn on full error_reporting in drupal settings.php

cp ./sites/default/settings.php ./sites/default/settings_0.php

# ------------------------------------ add lines if they are missing
if ! grep -q "error_reporting" ./sites/default/settings_0.php; then
  echo "\nerror_reporting(E_ALL);" >> ./sites/default/settings_0.php
fi
if ! grep -q "\$conf_error_level" ./sites/default/settings_0.php; then
  echo "\n\$conf_error_level = 2;" >> ./sites/default/settings_0.php
fi
if ! grep -q "ini_set('display_errors'" ./sites/default/settings_0.php; then
  echo "\nini_set('display_errors', TRUE);" >> ./sites/default/settings_0.php
fi
if ! grep -q "ini_set('display_startup_errors'" ./sites/default/settings_0.php; then
  echo "\nini_set('display_startup_errors', TRUE);" >> ./sites/default/settings_0.php
fi

# ------------------------------------ replace with on values
sed "s/error_reporting\(.*\).*/error_reporting(E_ALL);/g" ./sites/default/settings_0.php > ./sites/default/settings_1.php
sed "s/\$conf\['error_level'\].*/\$conf['error_level'] = 2;/g" ./sites/default/settings_1.php > ./sites/default/settings_2.php
sed "s/ini_set\('display_errors'.*\).*/ini_set('display_errors', TRUE);/g" ./sites/default/settings_2.php > ./sites/default/settings_3.php
sed "s/ini_set\('display_startup_errors'.*\).*/ini_set('display_startup_errors', TRUE);/g" ./sites/default/settings_3.php > ./sites/default/settings_4.php

# ------------------------------------ swap in results
rm ./sites/default/settings.php
mv ./sites/default/settings_4.php ./sites/default/settings.php
rm ./sites/default/settings_*.php
chmod 777 ./sites/default/settings.php

echo "set full error reporting to E_ALL in settings.php"
