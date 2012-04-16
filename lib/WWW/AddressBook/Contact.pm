package WWW::AddressBook::Contact;
use Moose;
use namespace::autoclean;

has first_name => (
  is => 'rw',
  isa => 'Str',
);

has last_name => (
  is => 'rw',
  isa => 'Maybe[Str]',
);

has full_name => (
  is => 'rw',
  isa => 'Str',
);

has physical_addresses => (
  is => 'rw',
  isa => 'ArrayRef[WWW::AddressBook::PhysicalAddress]',
  default => sub { [] },
);

has email_addresses => (
  is => 'rw',
  isa => 'ArrayRef[WWW::AddressBook::EmailAddress]',
  default => sub { [] },
);

has phone_numbers => (
  is => 'rw',
  isa => 'ArrayRef[WWW::AddressBook::PhoneNumber]',
  default => sub { [] },
);

__PACKAGE__->meta->make_immutable;
1;
