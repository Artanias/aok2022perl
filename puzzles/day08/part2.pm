use strict;
use warnings;
use 5.010;


sub create_greed {
    my $greed = ();

    while (<>) {
        chomp $_;
        my $line_to_array = ();
        for (my $i = 0; $i < length $_; $i++) {
            push @$line_to_array, substr($_, $i, 1);
        }
        push @$greed, $line_to_array;
    }

    return $greed;
}


sub calc_scenic_score {
    my ($greed) = @_;

    my $best_scenic_score = 1;
    my ($rows, $columns) = (scalar @$greed, scalar @{ $greed->[0] });
    for (my $i = 0; $i < $rows; $i++) {
        for (my $j = 0; $j < $columns; $j++) {
            my $element = $greed->[$i]->[$j];
            my $tmp_score = 1;

            my $line_score = 0;
            for (my $k = $i - 1; $k >= 0; $k--) {
                $line_score++;
                last if ($greed->[$k]->[$j] >= $element);
            }
            $tmp_score *= $line_score;

            $line_score = 0;
            for (my $k = $i + 1; $k < $rows; $k++) {
                $line_score++;
                last if ($greed->[$k]->[$j] >= $element);
            }
            $tmp_score *= $line_score;

            $line_score = 0;
            for (my $k = $j - 1; $k >= 0; $k--) {
                $line_score++;
                last if ($greed->[$i]->[$k] >= $element);
            }
            $tmp_score *= $line_score;

            $line_score = 0;
            for (my $k = $j + 1; $k < $columns; $k++) {
                $line_score++;
                last if ($greed->[$i]->[$k] >= $element);
            }
            $tmp_score *= $line_score;

            $best_scenic_score = $tmp_score if ($tmp_score > $best_scenic_score);
        }
    }

    return $best_scenic_score;
}


my $greed = create_greed();
my $scenic_score = calc_scenic_score($greed);

say "The highest scenic score possible for any tree - $scenic_score.";
