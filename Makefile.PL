use ExtUtils::MakeMaker;

use 5.006;

WriteMakefile(
	NAME			=> 'Acme::ProgressBar',
	VERSION_FROM	=> 'lib/Acme/ProgressBar.pm',
	ABSTRACT_FROM	=> 'lib/Acme/ProgressBar.pm',
  AUTHOR    => 'Ricardo SIGNES <rjbs@cpan.org>',
  PREREQ_PM => { Exporter => 0 }, # otherwise META.yml broken; ugh
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
    (eval { ExtUtils::MakeMaker->VERSION(6.46) }
      ? (META_MERGE => {
          resources => {
            Repository => 'http://github.com/rjbs/acme-progressbar'
          }
        })
      : ()
    ),
);

