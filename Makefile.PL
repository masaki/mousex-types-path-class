use inc::Module::Install;
name 'MouseX-Types-Path-Class';
all_from 'lib/MouseX/Types/Path/Class.pm';

requires 'Mouse' => '0.15';
requires 'MouseX::Types' => '0.01';
requires 'namespace::clean';
requires 'Path::Class';

recommends 'MouseX::Getopt';

tests 't/*.t';
test_requires 'Test::More';
test_requires 'ok';
author_tests 'xt';
use_test_base;

auto_include_deps;
WriteAll;
