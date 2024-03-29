#!/bin/bash
yum install -y epel-release git httpd 
yum install -y php php-mysql php-ldap php-pdo composer


export SSP='/var/www/ssp'
git clone https://github.com/simplesamlphp/simplesamlphp.git $SSP

mkdir -p ${SSP}/config
mkdir -p ${SSP}/metadata
cp -r ${SSP}/config-templates/* ${SSP}/config/
cp -r ${SSP}/metadata-templates/* ${SSP}/metadata/

cd $SSP
composer install

sed -i "s#enable.saml20-idp' => false#enable.saml20-idp' => true#g" /var/www/ssp/config/config.php


cd /var/www/html
ln -s ${SSP}/www simplesaml

systemctl enable httpd
systemctl start httpd


sleep 5

echo "Initial Apache Benchmark - 100 iterations of frontpage_federation"

ab -n 100 'http://127.0.0.1/simplesaml/module.php/core/frontpage_federation.php'

echo ""
echo "HTTP Error Log (last 10 lines)"
tail -10 /var/log/httpd/error_log

sleep 5

echo "Disabling header_register_callback"
sed -i 's#disable_functions =#disable_functions = header_register_callback#g' /etc/php.ini

systemctl restart httpd

echo "Follow-up Apache Benchmark - 100 iterations of frontpage_federation"

ab -n 100 'http://127.0.0.1/simplesaml/module.php/core/frontpage_federation.php'

echo ""
echo "HTTP Error Log (last 10 lines)"
tail -10 /var/log/httpd/error_log

