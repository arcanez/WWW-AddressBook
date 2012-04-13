package WWW::AddressBook::Provider::Google;
use Moose::Role;
use namespace::autoclean;
use Net::Google::AuthSub;
use WWW::AddressBook::Contact;
use WWW::AddressBook::PhysicalAddress;

has authsub => (
  isa => 'Net::Google::AuthSub',
  is => 'ro',
  lazy => 1,
  default => sub { Net::Google::AuthSub->new(service => 'cp') },
);

has url => (
  isa => 'URI',
  is => 'rw',
  lazy => 1,
  default => sub { URI->new('http://www.google.com/m8/feeds/contacts/default/full?alt=json&max-results=9999&v=3.0') },
);

sub _build_contacts {
  my $self = shift;
  my $resp = $self->authsub->login($self->username, $self->password);
  $resp = $self->ua->get($self->url, $self->authsub->auth_params);
  my $content = $self->json->decode($resp->decoded_content)->{feed}{entry};
  my @contacts;
  for my $c (@$content) {
    my %data;
    my $name = $c->{'gd$name'};
    $data{first_name} = $name->{'gd$givenName'}{'$t'} || $name->{'gd$fullName'}{'$t'} || $c->{title}{'$t'};
    $data{last_name} = $name->{'gd$familyName'}{'$t'};
    $data{full_name} = $name->{'gd$fullName'}{'$t'} || $c->{title}{'$t'};

    my @physical_addresses;
    for my $a (@{$c->{'gd$structuredPostalAddress'} || []}) {
      my $physical_address = WWW::AddressBook::PhysicalAddress->new(
        street1 => $a->{'gd$street'}{'$t'},
        street2 => undef,
        city => $a->{'gd$city'}{'$t'},
        state => $a->{'gd$region'}{'$t'},
        postal_code => $a->{'gd$postcode'}{'$t'},
        type => (split('#', $a->{rel}))[-1],
      );
      push @physical_addresses, $physical_address;
    }
    $data{physical_addresses} = \@physical_addresses;

    my $contact = WWW::AddressBook::Contact->new(\%data);
    push @contacts, $contact;
  }
  return \@contacts;
}

1;
