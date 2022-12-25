#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

my $win_rules = {
	rock => "scissors",
	paper => "rock",
	scissors => "paper",
};
my $draw_rules = {
	rock => "rock",
	paper => "paper",
	scissors => "scissors",
};
my $lose_rules = {
	rock => "paper",
	paper => "scissors",
	scissors => "rock",
};
my $cipher = {
	A => "rock",
	X => $win_rules,
	B => "paper",
	Y => $draw_rules,
	C => "scissors",
	Z => $lose_rules
};
my $choice_score = {
	rock => 1,
	paper => 2,
	scissors => 3
};
my $score = 0;


while (<>) {
	my @choices = split " ", $_;
	
	my $enemy_choice = $cipher->{$choices[0]};
	my $your_choice = $cipher->{$choices[1]}{$enemy_choice};

	my $you_win = $win_rules->{$your_choice};

	$score += $choice_score->{$your_choice};
	if ($you_win eq $enemy_choice) {
		$score += 6;
	}
	elsif ($enemy_choice eq $your_choice) {
		$score += 3;
	}
}

say "Your total score is $score.";
