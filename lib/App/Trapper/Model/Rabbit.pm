package App::Trapper::Model::Rabbit;
use Moose;

extends 'Catalyst::Model';

with 'Catalyst::Component::InstancePerContext';

use App::Trapper::Rabbit;

sub build_per_context_instance{
    my ($self, $c) = @_;

    return App::Trapper::Rabbit->new(
    );
}

1;