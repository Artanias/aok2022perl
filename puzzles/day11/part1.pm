use strict;
use warnings;
use List::Util qw(max);
use 5.010;


my $monkeys = {};
my $curr_monkey;


sub calc {
    my ($first, $op, $second) = @_;

    return $first + $second if ($op eq "+");
    return $first - $second if ($op eq "-");
    return $first * $second if ($op eq "*");
}


while (<>) {
    if ($_ =~ /Monkey (?<number>\d+):/) {
        $curr_monkey = $+{number};
        $monkeys->{$curr_monkey} = {};
        $monkeys->{$curr_monkey}->{inspected} = 0;
    }
    elsif ($_ =~ /Starting items: (?<items>[\d, ]+)/) {
        my @items = split(/, /, $+{items});
        $monkeys->{$curr_monkey}->{items} = \@items;
    }
    elsif ($_ =~ /Operation: new = old (?<op>[*+-]) (?<second>old|\d+|)/) {
        $monkeys->{$curr_monkey}->{op} = $+{op};
        $monkeys->{$curr_monkey}->{second} = $+{second};
    }
    elsif ($_ =~ /Test: divisible by (?<digit>\d+)/) {
        $monkeys->{$curr_monkey}->{divisible} = $+{digit};
    }
    elsif ($_ =~ /If true: throw to monkey (?<monkey>\d+)/) {
        $monkeys->{$curr_monkey}->{if_true} = $+{monkey};
    }
    elsif ($_ =~ /If false: throw to monkey (?<monkey>\d+)/) {
        $monkeys->{$curr_monkey}->{if_false} = $+{monkey};
    }
}

my @monkeys_ids = 0 .. scalar keys %$monkeys;
pop @monkeys_ids;


for my $round (1..20) {
    for my $monkey (@monkeys_ids) {
        my $items = $monkeys->{$monkey}->{items};
        while (@$items) {
            $monkeys->{$monkey}->{inspected}++;
            my $item = shift @$items;
            my $worry_lvl;

            if ($monkeys->{$monkey}->{second} eq "old") {
                $worry_lvl = calc($item, $monkeys->{$monkey}->{op}, $item);
            }
            else {
                $worry_lvl = calc($item, $monkeys->{$monkey}->{op}, $monkeys->{$monkey}->{second});
            }
            $worry_lvl = int($worry_lvl / 3);

            if ($worry_lvl % $monkeys->{$monkey}->{divisible} == 0) {
                push @{ $monkeys->{$monkeys->{$monkey}->{if_true}}->{items} }, $worry_lvl;
            }
            else {
                push @{ $monkeys->{$monkeys->{$monkey}->{if_false}}->{items} }, $worry_lvl;
            }
        }
    }
}


my @inspected_res = sort { $a <=> $b } map { $monkeys->{$_}->{inspected} } keys %$monkeys;
my $level = (pop @inspected_res) * (pop @inspected_res);
say "The level of monkey business after 20 rounds of stuff-slinging simian shenanigans $level.";
