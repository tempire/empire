#!/usr/bin/env perl

use lib 'lib';
use Nempire::Schema;

my @dsn = qw/ dbi:SQLite:dbname=nempire.db /;

Nempire::Schema->connect(@dsn)->deploy;
