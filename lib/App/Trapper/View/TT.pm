package App::Trapper::View::TT;

use strict;

use parent 'Catalyst::View::TT';

use Scalar::Util qw(blessed);

__PACKAGE__->config({
    PRE_PROCESS         => 'site/shared/base.tt',
    WRAPPER             => 'site/wrapper.tt',
    TEMPLATE_EXTENSION  => '.tt',
    TIMER               => 0,
    static_root         => '/static',
    static_build        => 0,
});

=head1 NAME

App::Trapper::View::TT - Catalyst TT::Bootstrap::YUI View

=head1 SYNOPSIS

See L<App::Trapper>

=head1 DESCRIPTION

Catalyst TT::Bootstrap::YUI View.

=head1 AUTHOR

Cory Watson

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
