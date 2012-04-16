package WWW::AddressBook::PhysicalAddress;
use Moose;
use MooseX::UndefTolerant;
use namespace::autoclean;

has street1 => (
  is => 'rw',
  isa => 'Str',
  predicate => 'has_street1',
);

has street2 => (
  is => 'rw',
  isa => 'Str',
  predicate => 'has_street2',
);

has city => (
  is => 'rw',
  isa => 'Str',
  predicate => 'has_city',
);

has state => (
  is => 'rw',
  isa => 'Str',
  predicate => 'has_state',
);

has country => (
  is => 'rw',
  isa => 'Str',
  predicate => 'has_country',
);

has postal_code => (
  is => 'rw',
  isa => 'Str',
  predicate => 'has_postal_code',
);

has type => (
  is => 'rw',
  isa => 'Str',
  lazy => 1,
  default => sub { 'home' },
);

__PACKAGE__->meta->make_immutable;
1;
