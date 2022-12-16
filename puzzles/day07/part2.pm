#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use File::Spec::Functions;


my $file_system = {
    prev => undef,
    path => '/',
    dirs => {},
    size => 0
};
my $dirs_size = {};
my $disk_space = 70000000;
my $update_require = 30000000;
my $current_dir;


sub cd {
    my ($path) = @_;

    if ($path eq "..") {
        my $current_size = $current_dir->{size};
        $dirs_size->{$current_dir->{path}} = $current_dir->{size};
        $current_dir = $current_dir->{prev};
        $current_dir->{size} += $current_size;
    }
    elsif ($path eq "\/") {
        $current_dir = $file_system;
    }
    else {
        $current_dir = $current_dir->{dirs}{$path};
    }
}


while(<>) {
    next if ($_ =~ /\$ ls/);
    if ($_ =~ /\$ cd (?<path>([.][.])|\/|\S+)/) {
        cd $+{path};
    }
    elsif ($_ =~ /dir (?<dirname>\S+)/) {
        $current_dir->{dirs}{$+{dirname}} = {
            prev => $current_dir,
            dirs => {},
            size => 0,
            path => catfile($current_dir->{path}, $+{dirname})
        };
    }
    elsif ($_ =~ /(?<size>\d+) [\S.]+/) {
        $current_dir->{size} += $+{size};
    }
}


while ($current_dir ne $file_system) {
    my $current_size = $current_dir->{size};
    $dirs_size->{$current_dir->{path}} = $current_dir->{size};
    $current_dir = $current_dir->{prev};
    $current_dir->{size} += $current_size;
}


my $free_space = $disk_space - $file_system->{size};
my $required_to_free = $update_require - $free_space;
my $minimal = $disk_space;
my $minimal_dir;
for my $key (keys %$dirs_size) {
    next if $dirs_size->{$key} < $required_to_free;
    if ($dirs_size->{$key} <= $minimal) {
        $minimal = $dirs_size->{$key};
        $minimal_dir = $key;
    }
}


say "The smallest directory that, if deleted, "
    . "would free up enough space on the filesystem "
    . "to run the update - '$minimal_dir'. Will be released - $minimal.";
