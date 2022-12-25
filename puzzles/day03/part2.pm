#!/usr/bin/perl

use strict;
use warnings;
use 5.010;
use Data::Dumper;

my $alphabet = ["a" .. "z", "A" .. "Z"];
my $costs = { map { $alphabet->[$_] => $_ + 1 } 0 .. 51 };


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
	my $priority = 0;
	my $current_gr_elf = 0;
	my $group_elf_items = [];
	while (<>) {
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


my $priority = calc_priority();
say "Priority is $priority.";
