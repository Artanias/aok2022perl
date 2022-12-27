use strict;
use warnings;
use 5.010;

use Storable qw(dclone);


my @visited = ([0, 0]);
my @head = (0, 0);
my @tails = map { [0, 0] } 1..9; 
my @tail = (0, 0);


sub move_tail {
    my ($prev, $curr) = @_;

    my $dx = $prev->[0] - $curr->[0];
    my $dy = $prev->[1] - $curr->[1];

    return if abs($dx) == 1 and abs($dy) == 1;

    my $distance = ( $dx ** 2 + $dy ** 2 ) ** (1/2);

    return if grep { $distance == $_ } (0, 1);

    if ($dx == 2) {
        $curr->[0]++;
        $curr->[1]++ if $dy == 1;
        $curr->[1]-- if $dy == -1;
    }
    elsif ($dx == -2) {
        $curr->[0]--;
        $curr->[1]++ if $dy == 1;
        $curr->[1]-- if $dy == -1;
    }

    if ($dy == 2) {
        $curr->[1]++;
        $curr->[0]++ if $dx == 1;
        $curr->[0]-- if $dx == -1;
    }
    elsif ($dy == -2) {
        $curr->[1]--;
        $curr->[0]++ if $dx == 1;
        $curr->[0]-- if $dx == -1;
    }
}


sub add_unique {
    for my $i (0..$#visited) {
        return unless ($visited[$i]->[0] != $tails[$#tails]->[0] or $visited[$i]->[1] != $tails[$#tails]->[1]);
    }

    push @visited, dclone($tails[$#tails]);
}

sub move_tails_n_add_unique {
    move_tail(\@head, $tails[0]);
    move_tail($tails[$_], $tails[$_ + 1]) for 0 .. $#tails - 1;
    add_unique();
}

while (<>) {
    $_ =~ /(?<directory>\w) (?<cnt>\d+)/;

    my $directory = $+{directory};
    my $cnt = $+{cnt};

    if ($directory eq "R") {
        for (1..$cnt) {
            $head[0]++;
            move_tails_n_add_unique();
        }
    }
    elsif ($directory eq "L") {
        for (1..$cnt) {
            $head[0]--;
            move_tails_n_add_unique();
        }
    }
    elsif ($directory eq "U") {
        for (1..$cnt) {
            $head[1]++;
            move_tails_n_add_unique();
        }
    }
    else {
        for (1..$cnt) {
            $head[1]--;
            move_tails_n_add_unique();
        }
    }
}


my $cnt_visited = @visited;
say "There are $cnt_visited positions the tail visited at least once.";
