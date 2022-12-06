#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use Scalar::Util qw(looks_like_number);
use List::Util qw(sum);

my $filename = "data.txt";
my $handle = undef;

open($handle, "< :encoding(UTF-8)", $filename)
	|| die "$0: can't open $filename for reading: $!";

my $current_elf_calories = 0;
my @elfs_calories = ();

while (<$handle>) {
	unless (looks_like_number($_)) {
		push @elfs_calories, $current_elf_calories;
		$current_elf_calories = 0;
	}
	else {
		$current_elf_calories += $_;
	}
}

my @top_three_elfs = (sort { int $b > int $a } @elfs_calories)[0..2];
print "Total elves carried - " . (sum @top_three_elfs) . ".\n";
