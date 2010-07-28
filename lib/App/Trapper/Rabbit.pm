package App::Trapper::Rabbit;
use Moose;

use Try::Tiny;

has 'command' => (
    is => 'ro',
    isa => 'Str',
    default => 'rabbitmqctl -q'
);

has 'queues' => (
    is => 'ro',
    isa => 'HashRef',
    lazy_build => 1
);

has 'users' => (
    is => 'ro',
    isa => 'ArrayRef[Str]',
    lazy_build => 1
);

sub _build_queues {
    my ($self) = @_;

    my @infos = qw(name durable auto_delete arguments pid owner_pid exclusive_consumer_pid exclusive_consumer_tag messages_ready messages_unacknowledged messages consumers memory);
    my $qo = $self->_run_command('list_queues '.join(' ', @infos));

    my %queues;
    my @lines = split(/\n/, $qo);
    foreach my $line (@lines) {
        my @parts = split(/\t/, $line);
        my %queue;
        for(my $i = 0; $i < scalar(@infos); $i++) {
            $queue{$infos[$i]} = $parts[$i];
        }
        $queues{$parts[0]} = \%queue;
    }

    return \%queues;
}

sub _build_users {
    my ($self) = @_;

    my $uo = $self->_run_command('list_users');
    return [ split(/\n/, $uo) ];
}

sub _run_command {
    my ($self, $cmd) = @_;

    my $rbt = $self->command;
    return `$rbt $cmd`;
}

1;