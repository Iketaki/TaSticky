use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'TaSticky',
    VERSION_FROM  => 'lib/TaSticky.pm',
    PREREQ_PM     => {
        'Kossy' =>  '0.19',
    },
    MIN_PERL_VERSION => '5.008001'
);

