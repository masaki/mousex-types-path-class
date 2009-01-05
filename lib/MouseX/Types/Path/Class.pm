package MouseX::Types::Path::Class;

use strict;
use warnings;
use 5.8.1;
use Path::Class::Dir;
use Path::Class::File;
use Mouse::TypeRegistry;
use MouseX::Types::Mouse qw(Str ArrayRef);
use namespace::clean;
use MouseX::Types -declare => [qw(Dir File)];

our $VERSION = '0.01';

# FIXME: Mouse's bug?
require Mouse;
for my $class ('Path::Class::Dir', 'Path::Class::File') {
    class_type $class => { class => $class };
}

subtype Dir,  as 'Path::Class::Dir';
subtype File, as 'Path::Class::File';

for my $type ('Path::Class::Dir', Dir) {
    coerce $type, from Str,      via { Path::Class::Dir->new($_) };
    coerce $type, from ArrayRef, via { Path::Class::Dir->new(@$_) };
}

for my $type ('Path::Class::File', File) {
    coerce $type, from Str,      via { Path::Class::File->new($_) };
    coerce $type, from ArrayRef, via { Path::Class::File->new(@$_) };
}

# TODO: optionally add Getopt option type
eval { require MouseX::Getopt::OptionTypeMap };
if (!$@) {
    MouseX::Getopt::OptionTypeMap->add_option_type_to_map($_ => '=s')
        for ('Path::Class::Dir', 'Path::Class::File', Dir, File);
}

1;

=head1 NAME

MouseX::Types::Path::Class - A Path::Class type library for Mouse

=head1 SYNOPSIS

    use MouseX::Types::Path::Class;

=head1 DESCRIPTION

MouseX::Types::Path::Class is

=head1 AUTHOR

NAKAGAWA Masaki E<lt>masaki@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
