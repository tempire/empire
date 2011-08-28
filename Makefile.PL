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
        'Lingua::EN::Summarize' => '0.2',
        'Modern::Perl' => '1.03',
        'Test::Most' => '0.23',
        'File::Slurp' => '9999.18',
        'SQL::Translator' => '0.11008',
        'Flickr::API' => '1.04',
        'Parallel::ForkManager' => '0.7.9',
        'Net::Posterous' => '0.8',
    },
    test => {TESTS => 't/*.t t/*/*.t t/*/*/*.t'}
);
