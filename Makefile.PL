use inc::Module::Install;
name 'MouseX-Types-Path-Class';
all_from 'lib/MouseX/Types/Path/Class.pm';

# requires '';

# install_script '';

tests 't/*.t';
test_requires 'Test::More';
test_requires 'Test::use::ok';
author_tests 'xt';
use_test_base;

auto_include_deps;
WriteAll;
