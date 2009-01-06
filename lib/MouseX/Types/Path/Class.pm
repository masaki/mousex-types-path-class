package MouseX::Types::Path::Class;

use strict;
use warnings;
use 5.8.1;
use Path::Class::Dir;
use Path::Class::File;
use Mouse::TypeRegistry;
use MouseX::Types::Mouse qw(Str ArrayRef);
use namespace::clean;

use MouseX::Types
    -declare => [qw(Dir File)]; # export Types
require Mouse;                  # for Mouse::TypeRegistry (Mouse::load_class)

our $VERSION = '0.01';

class_type $_ => { class => $_ }
    for qw( Path::Class::Dir Path::Class::File );

subtype Dir,  as 'Path::Class::Dir';
subtype File, as 'Path::Class::File';

for my $type ( 'Path::Class::Dir', Dir ) {
    coerce $type,
        from Str,      via { Path::Class::Dir->new($_)  },
        from ArrayRef, via { Path::Class::Dir->new(@$_) };
}

for my $type ( 'Path::Class::File', File ) {
    coerce $type,
        from Str,      via { Path::Class::File->new($_)  },
        from ArrayRef, via { Path::Class::File->new(@$_) };
}

# optionally add Getopt option type
eval { require MouseX::Getopt::OptionTypeMap };
unless ($@) {
    MouseX::Getopt::OptionTypeMap->add_option_type_to_map($_, '=s')
        for ( 'Path::Class::Dir', 'Path::Class::File', Dir, File );
}

1;

=head1 NAME

MouseX::Types::Path::Class - A Path::Class type library for Mouse

=head1 SYNOPSIS

  package MyApp;
  use Mouse;
  use MouseX::Types::Path::Class;
  with 'MouseX::Getopt'; # optional

  has 'dir' => (
      is       => 'ro',
      isa      => 'Path::Class::Dir',
      required => 1,
      coerce   => 1,
  );

  has 'file' => (
      is       => 'ro',
      isa      => 'Path::Class::File',
      required => 1,
      coerce   => 1,
  );

  # these attributes are coerced to the
  # appropriate Path::Class objects
  MyApp->new( dir => '/some/directory/', file => '/some/file' );

=head1 DESCRIPTION

MouseX::Types::Path::Class creates common L<Mouse> types,
coercions and option specifications useful for dealing
with L<Path::Class> objects as L<Mouse> attributes.

Coercions (see L<Mouse::TypeRegistry>) are made
from both 'Str' and 'ArrayRef' to both L<Path::Class::Dir> and
L<Path::Class::File> objects. If you have L<MouseX::Getopt> installed,
the Getopt option type ("=s") will be added for both
L<Path::Class::Dir> and L<Path::Class::File>.

=head1 EXPORTS

None of these are exported by default. They are provided via
L<MouseX::Types>.

=head2 Dir

=head2 File

These exports can be used instead of the full class names.

Example:

  package MyClass;
  use Mouse;
  use MouseX::Types::Path::Class qw(Dir File);

  has 'dir' => (
      is       => 'ro',
      isa      => Dir,
      required => 1,
      coerce   => 1,
  );

  has 'file' => (
      is       => 'ro',
      isa      => File,
      required => 1,
      coerce   => 1,
  );

Note that there are no quotes around Dir or File.

=head2 is_Dir($value)

=head2 is_File($value)

Returns true or false based on whether $value is a valid Dir or File.

=head2 to_Dir($value)

=head2 to_File($value)

Attempts to coerce $value to a Dir or File. Returns the coerced value
or false if the coercion failed.

=head1 AUTHOR

NAKAGAWA Masaki E<lt>masaki@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Mouse>, L<MouseX::Types>, L<Path::Class>, L<MooseX::Types::Path::Class>

=cut
