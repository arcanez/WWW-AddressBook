use strict;
use warnings FATAL => 'all';
use 5.008001;
use ExtUtils::MakeMaker;
 
WriteMakefile(
  NAME => 'WWW-AddressBook',
  AUTHOR  => 'Justin Hunter <justin.d.hunter@gmail.com>',
  VERSION_FROM => 'lib/WWW/AddressBook.pm',
  LICENSE => 'perl',
  ABSTRACT_FROM => 'lib/WWW/AddressBook.pm',
  MIN_PERL_VERSION => '5.008001',
  PREREQ_PM => {
    'JSON' => 0,
    'LWP' => 0,
    'Moose' => '0.93',
    'MooseX::Types::Email' => 0,
    'MooseX::UndefTolerant' => 0,
    'namespace::autoclean' => 0,
    'Net::Google::AuthSub' => 0,
    'URI' => 0,
  },
  'BUILD_REQUIRES' => {
    'Test::More' => '0.88',
  },
  META_MERGE => {
    resources => {
      license     => 'http://dev.perl.org/licenses/',
      bugtracker  => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-AddressBook',
      repository  => 'https://github.com/arcanez/www-addressbook',
    },
  },
);
