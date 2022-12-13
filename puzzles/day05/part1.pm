#!/usr/bin/perl

use strict;
use warnings;
use 5.010;


my $crates_pattern = '\[(?<crates>\w)\]';
my $cnt_stacks;
my @stacks = ();


sub get_letters_from_line {
	my ($line) = @_;

	my $cur_column = 0;
	while ($line) {
		if ($line =~ /^${crates_pattern}/) {
			unshift @{ $stacks[$cur_column] }, $+{crates};
			$line =~ s/^${crates_pattern}//g;
			$line =~ s/\s//;
		}
		else {
			$line =~ s/\s\s\s\s//;
		}
		$cur_column += 1;
	}
}


sub move {
	my ($how, $from, $to) = @_;

	for (my $i = 0; $i < int($how); $i++) {
		my $poped = pop @{ $stacks[int($from) - 1] };
		push @{ $stacks[int($to) - 1] }, $poped;
	}
}


sub get_tops {
	my @tops = ();

	for my $stack (@stacks) {
		push @tops, $stack->[-1] if @$stack;
	}

	return @tops;
}


while (<>) {
	if ($_ =~ /move (?<how>\d+) from (?<from>\d+) to (?<to>\d+)/) {
		move($+{how}, $+{from}, $+{to});
	}
	elsif ($_ =~ /${crates_pattern}/) {
		get_letters_from_line($_);
	}
}


say "The message is '", get_tops(), "'.";
