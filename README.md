# Segfault Test

[SimpleSAMLphp](https://simplesamlphp.org/) introduced the use of header_register_callback at  [a48e10ff](https://github.com/simplesamlphp/simplesamlphp/commit/a48e10f6e0e1603d68d50d40c1135077b51f931b)

Using CentOS 7.1 / Apache 2.4.6 / PHP 5.4.16  this leads to segmentation faults.

Running ```vagrant up``` from this repo will 
* build a CentOS 7.1 machine based on the boxcutter/centos71 base box
* install Apache, PHP, and other packages needed for SimpleSAMLphp
* install SimpleSAMLphp and give it an incredibly basic configuration
* start apache
* run Apache Benchmark to illustrate the SEGFAULT issue
* disable the header_register_callback function in php.ini
* re-run the Apache Benchmark cleanly

The resulting output will look something like the example-run files


