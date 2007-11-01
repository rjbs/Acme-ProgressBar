package Acme::ProgressBar;

use strict;
use warnings;

=head1 NAME 

Acme::ProgressBar - a simple progress bar for the patient

=head1 VERSION

version 1.123

=cut

our $VERSION = '1.123';

=head1 SYNOPSIS

 use Acme::ProgressBar;
 progress { do_something_slow };

=cut

use base qw(Exporter);
our @EXPORT = qw(progress); ## no critic Export

sub progress(&) { ## no critic Prototype
	my ($code) = @_;
	local $| = 1; ## no critic
	_overprint(_message(0,10,0));
	my $begun = time;
  $code->();
	my $total = time - $begun;
	for (1 .. 9) {
		_overprint(_message($_,10,$total));
		sleep $total;
	}
	_overprint(_message(10,10,$total));
	print "\n";
}

sub _message {
	my ($iteration, $total, $time) = @_;
	my $message
    = 'Progress: ['
    .  q{=} x $iteration
    .  q{ } x ($total - $iteration)
    .  '] ';
	$message .= $time
		? ((($total - $iteration) * $time) . 's remaining' . q{ } x 25)
		: '(calculating time remaining)';
}

sub _overprint {
	my ($message) = @_;
	print $message, "\r";
}

"48102931829 minutes remaining";

__END__


=head1 DESCRIPTION

Acme::ProgressBar provides a simple solution designed to provide accurate
countdowns.  No progress bar object needs to be created, and all the
calculation of progress through total time required is handled by the module
itself.

=head1 FUNCTIONS

=head2 C<< progress >>

 progress { unlink $_ for <*> };
 progress { while (<>) { $ua->get($_) } };
 progress { sleep 5; }

There is only one function exported by default, C<progress>.  This function
takes a coderef as its lone argument.  It will execute this code and display a
simple progress bar indicating the time required for ten iterations through the
code.

=head1 TODO

=over

=item *

allow other divisions of time (other than ten)

=back

=head1 AUTHOR

Ricardo SIGNES E<lt>rjbs@cpan.orgE<gt>

Thanks to Steve Lidie for pointing out a stupid error in 1.001: I couldn't
count to ten, and he could.

=head1 COPYRIGHT

Copyright (C) 2004, Ricardo SIGNES.  Available under the same terms as Perl
itself.
