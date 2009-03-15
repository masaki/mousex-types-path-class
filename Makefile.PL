use inc::Module::Install;
name 'MouseX-Types-Path-Class';
all_from 'lib/MouseX/Types/Path/Class.pm';

requires 'Mouse' => '0.19';
requires 'Mouse::Util::TypeConstraints';
requires 'MouseX::Types' => '0.01';
requires 'Path::Class';

recommends 'MouseX::Getopt' => '0.05';

tests 't/*.t';
test_requires 'Any::Moose' => '0.05';
test_requires 'Test::More';
test_requires 'Test::UseAllModules';
author_tests 'xt';
use_test_base;

auto_include_deps;
WriteAll;
