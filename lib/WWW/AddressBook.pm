package WWW::AddressBook;
use Moose;
use namespace::autoclean;
use LWP;
use JSON;
with 'MooseX::Traits';

my %PROVIDERS = ( 'gmail.com' => 'Google',
                  'yahoo.com' => 'Yahoo',
                  'hotmail.com' => 'Hotmail', );

has ua => (
  is => 'ro',
  isa => 'LWP::UserAgent',
  default => sub { LWP::UserAgent->new },
  lazy => 1,
);

has json => (
  is => 'ro',
  isa => 'JSON',
  default => sub { JSON->new->utf8 },
  lazy => 1,
);

has username => (
  is => 'rw',
  isa => 'Str',
  required => 1,
);

has password => (
  is => 'ro',
  isa => 'Str',
  required => 1,
);

has contacts => (
  is => 'rw',
  isa => 'ArrayRef[WWW::AddressBook::Contact]',
  lazy_build => 1,
);

sub new_for_user {
  my $self = shift;
  my $username = shift;
  my $password = shift;

  my (undef, $domain) = split('@', $username);
  die 'Invalid provider' unless defined $domain && exists $PROVIDERS{$domain};
  my $provider = 'WWW::AddressBook::Provider::' . $PROVIDERS{$domain};
  $self->new_with_traits(username => $username, password => $password, traits => [ $provider ]);
}

__PACKAGE__->meta->make_immutable;
1;
