#!/usr/bin/perl

use strict;
use warnings;
use 5.010;


my $marker_len = 14;

sub init_marker {
    my ($marker, $str) = @_;

    for (my $i = 0; $i < $marker_len; $i++) {
        push @$marker, substr($str, $i, 1);
    }
}


sub is_all_unique {
    my (@array) = @_;

    my @uniq;
    for my $element (@array) {
        return 0 if grep { $element eq $_ } @uniq;

        push @uniq, $element;
    }

    return 1;
}


while (<>) {
    my @marker = ();
    my $processed = $marker_len;
    init_marker(\@marker, $_);

    for (my $i = $marker_len; $i < length $_; $i++) {
        last if is_all_unique(@marker);

        shift @marker;
        push @marker, substr($_, $i, 1);
        $processed += 1;
    }

    say "Unique marker is - '", @marker,
        "'. Processed characters - $processed.";
}
