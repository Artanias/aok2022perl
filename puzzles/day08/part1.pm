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


sub el_is_in_col {
    my ($greed, $element, $row, $col) = @_;

    for (my $k = 0; $k < $row; $k++) {
        return 0 if ($greed->[$k]->[$col] >= $element);
    }

    return 1;
}


sub el_is_in_row {
    my ($greed, $element, $row, $col) = @_;

    for (my $k = 0; $k < $col; $k++) {
        return 0 if ($greed->[$row]->[$k] >= $element);
    }

    return 1;
}


sub calc_visable_trees {
    my ($greed) = @_;

    my $cnt_visable = 0;
    my ($rows, $columns) = (scalar @$greed, scalar @{ $greed->[0] });
    for (my $i = 0; $i < $rows; $i++) {
        for (my $j = 0; $j < $columns; $j++) {
            if ($i == 0 or $j == 0 or $i == ($rows - 1) or $j == ($columns - 1)) {
                $cnt_visable++;
                next;
            }

            my $element = $greed->[$i]->[$j];

            if (el_is_in_col($greed, $element, $i, $j)) {
                $cnt_visable++;
                next;
            }

            if (el_is_in_row($greed, $element, $i, $j)) {
                $cnt_visable++;
                next;
            }

            my $flag = 1;
            for (my $k = $rows - 1; $k > $i; $k--) {
                if ($greed->[$k]->[$j] >= $element) {
                    $flag = 0;
                    last;
                }
            }
            if ($flag) {
                $cnt_visable++;
                next;
            }

            $flag = 1;
            for (my $k = $columns - 1; $k > $j; $k--) {
                if ($greed->[$i]->[$k] >= $element) {
                    $flag = 0;
                    last;
                }
            }
            if ($flag) {
                $cnt_visable++;
                next;
            }
        }
    }

    return $cnt_visable;
}


my $greed = create_greed();
my $cnt_visable = calc_visable_trees($greed);

say "Trees are visible from outside the grid - $cnt_visable.";
