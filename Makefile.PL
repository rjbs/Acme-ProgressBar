use ExtUtils::MakeMaker;

use 5.006;

WriteMakefile(
	NAME			=> 'Acme::ProgressBar',
	VERSION_FROM	=> 'lib/Acme/ProgressBar.pm',
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
);

