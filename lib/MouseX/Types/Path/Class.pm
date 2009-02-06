package MouseX::Types::Path::Class;

use strict;
use warnings;
use 5.8.1;
use Path::Class::Dir;
use Path::Class::File;
use Mouse::Util::TypeConstraints;
use MouseX::Types::Mouse qw(Str ArrayRef);
use namespace::clean;

use MouseX::Types -declare => [qw(Dir File)]; # export Types

our $VERSION = '0.02';

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

=head2 CLASS TYPES

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

=head2 CUSTOM TYPES

  package MyApp;
  use Mouse;
  use MouseX::Types::Path::Class qw(Dir File);
  with 'MouseX::Getopt'; # optional

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

=head1 DESCRIPTION

MouseX::Types::Path::Class creates common L<Mouse> types,
coercions and option specifications useful for dealing
with L<Path::Class> objects as L<Mouse> attributes.

Coercions (see L<Mouse::TypeRegistry>) are made
from both C<Str> and C<ArrayRef> to both L<Path::Class::Dir> and
L<Path::Class::File> objects. If you have L<MouseX::Getopt> installed,
the Getopt option type ("=s") will be added for both
L<Path::Class::Dir> and L<Path::Class::File>.

=head1 TYPES

=head2 Dir

=over 4

A L<Path::Class::Dir> class type.

Coerces from C<Str> and C<ArrayRef> via L<Path::Class::Dir/new>.

=back

=head2 File

=over 4

A L<Path::Class::File> class type.

Coerces from C<Str> and C<ArrayRef> via L<Path::Class::File/new>.

=back

=head1 AUTHOR

NAKAGAWA Masaki E<lt>masaki@cpan.orgE<gt>

=head1 THANKS TO

Todd Hepler, L<MooseX::Types::Path::Class/AUTHOR>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Mouse>, L<MouseX::Types>,

L<Path::Class>,

L<MooseX::Types::Path::Class>

=cut
