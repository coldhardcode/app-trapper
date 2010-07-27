package App::Trapper::Rabbit;
use Moose;

use Try::Tiny;

has 'command' => (
    is => 'ro',
    isa => 'Str',
    default => 'rabbitmqctl -q'
);

has 'users' => (
    is => 'ro',
    isa => 'ArrayRef[Str]',
    lazy_build => 1
);

sub _build_users {
    my ($self) = @_;

    my $uo = $self->_run_command('list_users');
    print STDERR "$uo\n";
    return [ 'guest' ];
}

sub _run_command {
    my ($self, $cmd) = @_;

    my $rbt = $self->command;
    return `$rbt $cmd`;
}

1;