#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use Scalar::Util qw(looks_like_number);

my $filename = "data.txt";
my $handle = undef;

open($handle, "< :encoding(UTF-8)", $filename)
	|| die "$0: can't open $filename for reading: $!";

my $max_calories = 0;
my $current_calories = 0;

while (<$handle>) {
	unless (looks_like_number($_)) {
		$max_calories = $current_calories if $max_calories < $current_calories;
		$current_calories = 0;
	}
	else {
		$current_calories += $_;
	}
}


print "The most calories is " . $max_calories . ".\n";
