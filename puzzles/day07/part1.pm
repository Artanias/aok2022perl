#!/usr/bin/perl

use strict;
use warnings;
use 5.010;


my $file_system = {
    prev => undef,
    dirs => {},
    size => 0
};
my $current_dir = $file_system;
my $total_less_than_100k = 0;


while(<>) {
    next if ($_ =~ /\$ ls/);
    if ($_ =~ /\$ cd (?<path>([.][.])|\/|\S+)/) {
        next if ($+{path} eq "\/");
        if ($+{path} eq "..") {
            my $current_size = $current_dir->{size};
            $current_dir = $current_dir->{prev};
            $current_dir->{size} += $current_size;
            if ($current_size <= 10 ** 5) {
                $total_less_than_100k += $current_size;
            }
        }
        else {
            $current_dir = $current_dir->{dirs}{$+{path}};
        }
    }
    elsif ($_ =~ /dir (?<dirname>\S+)/) {
        $current_dir->{dirs}{$+{dirname}} = {
            prev => $current_dir,
            dirs => {},
            size => 0
        };
    }
    elsif ($_ =~ /(?<size>\d+) [\S.]+/) {
        $current_dir->{size} += $+{size};
    }
}


while ($current_dir ne $file_system) {
    my $current_size = $current_dir->{size};
    $current_dir = $current_dir->{prev};
    $current_dir->{size} += $current_size;
}


say "The sum of the total sizes all "
    . "of the directories with a total size "
    . "of at most 100000 - $total_less_than_100k.";
