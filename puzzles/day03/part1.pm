#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

my $alphabet = ["a" .. "z", "A" .. "Z"];
my $costs = { map { $alphabet->[$_] => $_ + 1 } 0 .. 51 };


sub search_error {
	my ($rucksack) = @_;

	my $cnt_items = ((length $rucksack) - 1) / 2;
	for (my $i = 0; $i < $cnt_items; $i++) {
		my $first_item = substr($rucksack, $i, 1);
		for (my $j = 0; $j < $cnt_items; $j++) {
			my $second_item = substr($rucksack, $cnt_items + $j, 1);
			return $first_item if ($first_item eq $second_item);
		}
	}
}

sub calc_priority {
	my $priority = 0;
	while (<>) {
		my $error = search_error($_);

		$priority += $costs->{$error} if (defined $error);
	}

	return $priority;
}


my $priority = calc_priority();

say "Priority is $priority.";
