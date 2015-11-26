# Segfault Test

SimpleSAMLphp introduced the use of header_register_callback at some point after 1.13.2.

Using CentOS 7.1 / Apache 2.4.6 / PHP 5.4.16  this leads to segmentation faults.

Running ```vagrant up``` from this repo will 
* build a CentOS 7.1 machine based on the boxcutter/centos71 base box
* install Apache, PHP, and other packages needed for SimpleSAMLphp
* install SimpleSAMLphp and give it an incredibly basic configuration
* start apache
* run Apache Benchmark to illustrate the SEGFAULT issue
* disable the header_register_callback function in php.ini
* re-run the Apache Benchmark cleanly


