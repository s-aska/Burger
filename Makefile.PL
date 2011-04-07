use inc::Module::Install;
name 'Burger';
all_from 'lib/Burger.pm';

requires 'Facebook::Graph';
requires 'HTTP::Session';
requires 'Net::Dropbox::API';
requires 'Net::OpenID::Consumer::Lite';
requires 'Net::Twitter::Lite';
requires 'Pickles' => 0.06;


tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_include;
WriteAll;
