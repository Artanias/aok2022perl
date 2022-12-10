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

sub search_badge_item {
	my ($group_rucksacks) = @_;

	my @first_rucksack_items = split '', $group_rucksacks->[0];
	for my $letter (@first_rucksack_items) {
		next unless ($group_rucksacks->[1] =~ /${letter}/);
		next unless ($group_rucksacks->[2] =~ /${letter}/);

		return $letter;
	}
}

sub calc_priority {
	my ($handle) = @_;

	my $priority = 0;
	my $current_gr_elf = 0;
	my $group_elf_items = [];
	while (<$handle>) {
		$current_gr_elf += 1;
		push @$group_elf_items, $_;

		next if $current_gr_elf ne 3;

		my $badge_item = search_badge_item($group_elf_items);

		$priority += $costs->{$badge_item};

		$group_elf_items = [];
		$current_gr_elf = 0;
	}

	return $priority;
}

my ($example_prio, $puzzle_prio) = (calc_priority($example_handle), calc_priority($data_handle));

say "Example priority is $example_prio.";
say "Puzzle priority is $puzzle_prio.";

