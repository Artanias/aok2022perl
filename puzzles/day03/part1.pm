#!/usr/bin/perl

use strict;
use warnings;
use 5.010;
use Data::Dumper;

my $example_path = "example.txt";
my $data_path = "data.txt";
my $alphabet = ["a" .. "z", "A" .. "Z"];
my $costs = { map { $alphabet->[$_] => $_ + 1 } 0 .. 51 };

my ($example_handle, $data_handle);

open($example_handle, "< :encoding(UTF-8)", $example_path);
open($data_handle, "< :encoding(UTF-8)", $data_path);

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
	my ($handle) = @_;

	my $priority = 0;
	while (<$handle>) {
		my $error = search_error($_);

		$priority += $costs->{$error} if (defined $error);
	}

	return $priority;
}

my ($example_prio, $puzzle_prio) = (calc_priority($example_handle), calc_priority($data_handle));

say "Example priority is $example_prio.";
say "Puzzle priority is $puzzle_prio.";

