package Burger::Context;

use strict;
use warnings;
use parent 'Pickles::Context';

__PACKAGE__->load_plugins(qw(Encode Session));

1;

__END__
