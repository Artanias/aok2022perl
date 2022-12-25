#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use Scalar::Util qw(looks_like_number);


my $max_calories = 0;
my $current_calories = 0;

while (<>) {
	unless (looks_like_number($_)) {
		$max_calories = $current_calories if $max_calories < $current_calories;
		$current_calories = 0;
	}
	else {
		$current_calories += $_;
	}
}


print "The most calories is " . $max_calories . ".\n";
