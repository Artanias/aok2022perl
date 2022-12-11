#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

my $example_path = "example.txt";
my $data_path = "data.txt";


sub get_sequences_from_range {
    my ($str_range) = @_;

    my ($begin, $end) = split "-", $str_range;
    return ( $begin .. $end );
}


sub is_partly_overlaped {
    my ($first_seq, $second_seq) = @_;

    my ($first_ovelaped, $second_ovelaped) = (1, 1);
    for my $element (@$second_seq) {
        return 1 if grep { $element eq $_ } @$first_seq;
    }

    return 0;
}


sub calc_n_show_oveplap_sections {
    my ($path) = @_;

    my $handle;
    open($handle, "< :encoding(UTF-8)", $path);

    my $counter = 0;
    while (<$handle>) {
        my @elves_sections = split ",", $_; 

        my @first_elf_sequences = get_sequences_from_range($elves_sections[0]);
        my @second_elf_sequences = get_sequences_from_range($elves_sections[1]);

        $counter += 1 if is_partly_overlaped(\@first_elf_sequences, \@second_elf_sequences)
            || is_partly_overlaped(\@second_elf_sequences, \@first_elf_sequences);
    }

    say "One range partly contain the other in the '$path' $counter times.";
}


calc_n_show_oveplap_sections($example_path);
calc_n_show_oveplap_sections($data_path);
