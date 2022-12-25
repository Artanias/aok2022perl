#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use Scalar::Util qw(looks_like_number);
use List::Util qw(sum);


my $current_elf_calories = 0;
my @elfs_calories = ();

while (<>) {
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
