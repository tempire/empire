#!/usr/bin/env perl

use 5.008007;

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Nempire',
    VERSION_FROM => 'lib/Nempire.pm',
    AUTHOR       => 'Glen Hinkle <tempire@cpan.org>',
    EXE_FILES    => ['script/nempire'],
    PREREQ_PM    => {
        'Mojolicious'    => '1.32',
        'DBIx::Class'    => '0.08127',
        'Time::Duration' => '1.06',
        'Net::Posterous' => '0.8',
    },
    test => {TESTS => 't/*.t t/*/*.t t/*/*/*.t'}
);
