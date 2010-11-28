use strict;
use warnings;
package Acme::ProgressBar;
# ABSTRACT: a simple progress bar for the patient

use Time::HiRes ();

=head1 SYNOPSIS

 use Acme::ProgressBar;
 progress { do_something_slow };

=cut

use base qw(Exporter);
our @EXPORT = qw(progress); ## no critic Export

=head1 DESCRIPTION

Acme::ProgressBar provides a simple solution designed to provide accurate
countdowns.  No progress bar object needs to be created, and all the
calculation of progress through total time required is handled by the module
itself.

=func progress

 progress { unlink $_ for <*> };
 progress { while (<>) { $ua->get($_) } };
 progress { sleep 5; }

There is only one function exported by default, C<progress>.  This function
takes a coderef as its lone argument.  It will execute this code and display a
simple progress bar indicating the time required for ten iterations through the
code.

=cut

sub progress(&) { ## no critic Prototype
	my ($code) = @_;
	local $| = 1; ## no critic
	_overprint(_message(0,10,undef));
	my $begun = Time::HiRes::time;
  $code->();
	my $total = Time::HiRes::time - $begun;
	for (1 .. 9) {
		_overprint(_message($_,10,$total));
		Time::HiRes::sleep($total);
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

	if (defined $time) {
	  $message .= sprintf '%0.0fs remaining%25s',
	    (($total - $iteration) * $time), q{ };
	} else {
	  $message .= '(calculating time remaining)';
	}
}

sub _overprint {
	my ($message) = @_;
	print $message, "\r";
}

=head1 TODO

=for :list
* allow other divisions of time (other than ten)

=cut

"48102931829 minutes remaining";
