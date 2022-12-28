use strict;
use warnings;
use 5.010;
use Data::Dumper;


my $x = 1;
my $crt = -1;
my $rows = 6;
my $columns = 40;
my @greed = map { [ ('.') x $columns ] } 1..$rows;


sub draw_spite {
    my $column = $crt % $columns;
    my $row = int($crt / $columns);
    if ($column == $x or $column == $x - 1 or $column == $x + 1) {
        $greed[$row]->[$column] = "#"; 
    }
}


sub draw_greed {
    say "=" x 17, "Greed:", "=" x 17;
    for my $row (@greed) {
        say join '', @$row;
    }
}


while (<>) {
    if ($_ =~ /noop/) {
        $crt++;
        draw_spite();
        next;
    }

    $_ =~ /addx (?<digit>-?\d+)/;
    for (1..2) {
        $crt++;
        draw_spite();
    }
    $x += $+{digit};
}


draw_greed();
