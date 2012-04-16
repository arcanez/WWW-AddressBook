package WWW::AddressBook::EmailAddress;
use Moose;
use MooseX::Types::Email qw(EmailAddress);
use namespace::autoclean;

has email => (
  is => 'rw',
  isa => EmailAddress,
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
