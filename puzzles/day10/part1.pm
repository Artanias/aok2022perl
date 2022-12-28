use strict;
use warnings;
use 5.010;

my $sum = 0;
my $x = 1;
my $cycle = 0;
my @checked_cycles = (20, 60, 100, 140, 180, 220);


sub add_sig_strength {
    return unless (grep { $cycle eq $_ } @checked_cycles);

    $sum += $cycle * $x;
}


while (<>) {
    if ($_ =~ /noop/) {
        $cycle++;
        add_sig_strength();
        next;
    }

    $_ =~ /addx (?<digit>-?\d+)/;
    for (1..2) {
        $cycle++;
        add_sig_strength();
    }
    $x += $+{digit};
}

say "The sum of the signal strengths is $sum.";
