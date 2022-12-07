#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

my $filename = "data.txt";
my $rules = {
	rock => "scissors",
	paper => "rock",
	scissors => "paper",
};
my $cipher = {
	A => "rock",
	X => "rock",
	B => "paper",
	Y => "paper",
	C => "scissors",
	Z => "scissors"
};
my $choice_score = {
	rock => 1,
	paper => 2,
	scissors => 3
};
my $handle;

open($handle, "< :encoding(UTF-8)", $filename)
	|| die "$0: can't open $filename for reading: $!";

my $score = 0;
while (<$handle>) {
	my @choices = split " ", $_;
	
	my $enemy_choice = $cipher->{$choices[0]};
        my $your_choice = $cipher->{$choices[1]};

	my $you_win = $rules->{$your_choice};

	$score += $choice_score->{$your_choice};
	if ($you_win eq $enemy_choice) {
		$score += 6;
	}
	elsif ($enemy_choice eq $your_choice) {
		$score += 3;
	}
}

say "Your total score is $score.";
