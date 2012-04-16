package WWW::AddressBook::PhoneNumber;
use Moose;
use namespace::autoclean;

has number => (
  is => 'rw',
  isa => 'Str',
  required => 1,
);

has type => (
  is => 'rw',
  isa => 'Str',
  lazy => 1,
  default => sub { 'home' },
);

__PACKAGE__->meta->make_immutable;
1;
