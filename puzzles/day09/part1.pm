use strict;
use warnings;
use 5.010;

use Storable qw(dclone);


my @visited = ([0, 0]);
my @head = (0, 0);
my @tail = (0, 0);


sub move_tail {
    my $dx = $head[0] - $tail[0];
    my $dy = $head[1] - $tail[1];

    return if abs($dx) == 1 and abs($dy) == 1;

    my $distance = ( $dx ** 2 + $dy ** 2 ) ** (1/2);

    return if grep { $distance == $_ } (0, 1);

    if ($dx == 2) {
        $tail[0]++;
        $tail[1]++ if $dy == 1;
        $tail[1]-- if $dy == -1;
    }
    elsif ($dx == -2) {
        $tail[0]--;
        $tail[1]++ if $dy == 1;
        $tail[1]-- if $dy == -1;
    }

    if ($dy == 2) {
        $tail[1]++;
        $tail[0]++ if $dx == 1;
        $tail[0]-- if $dx == -1;
    }
    elsif ($dy == -2) {
        $tail[1]--;
        $tail[0]++ if $dx == 1;
        $tail[0]-- if $dx == -1;
    }

    my $is_unique = 1;
    for my $i (0..$#visited) {
        next if ($visited[$i]->[0] != $tail[0] or $visited[$i]->[1] != $tail[1]);
        $is_unique = 0;
    }

    push @visited, dclone(\@tail) if $is_unique;
}


while (<>) {
    $_ =~ /(?<directory>\w) (?<cnt>\d+)/;

    my $directory = $+{directory};
    my $cnt = $+{cnt};

    if ($directory eq "R") {
        for (1..$cnt) {
            $head[0]++;
            move_tail();
        }
    }
    elsif ($directory eq "L") {
        for (1..$cnt) {
            $head[0]--;
            move_tail();
        }
    }
    elsif ($directory eq "U") {
        for (1..$cnt) {
            $head[1]++;
            move_tail();
        }
    }
    else {
        for (1..$cnt) {
            $head[1]--;
            move_tail();
        }
    }
}


my $cnt_visited = @visited;
say "There are $cnt_visited positions the tail visited at least once.";
