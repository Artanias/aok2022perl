use strict;
use warnings;
use feature qw(switch);
use 5.010;


my $values = {};
my $undefined = {};


while (<>) {
    $values->{$+{name}} = int($+{digit}) if ($_ =~ /(?<name>\w+): (?<digit>\d+)/);
    if ($_ =~ /(?<name>\w+): (?<name2>\w+) (?<op>[-+*\/]) (?<name3>\w+)/) {
        if ( defined($values->{$+{name2}}) and defined($values->{$+{name3}}) ) {
            my $res;
            my $val1 = int($values->{$+{name2}});
            my $val2 = int($values->{$+{name3}});
            $res = $val1 - $val2 if $+{op} eq "-";
            $res = $val1 + $val2 if $+{op} eq "+";
            $res = $val1 * $val2 if $+{op} eq "*";
            $res = $val1 / $val2 if $+{op} eq "/";
            $values->{$+{name}} = $res;
        }
        else {
            $undefined->{$+{name}} = [$+{name2}, $+{op}, $+{name3}];
        }
    }
}


while (keys %$undefined) {
    for my $key (keys %$undefined) {
        my $res;
        my ($val1, $op, $val2) = @{ $undefined->{$key} };
        if ( defined($values->{$val1}) and defined($values->{$val2}) ) {
            $val1 = $values->{$val1};
            $val2 = $values->{$val2};
            $values->{$key} = $val1 - $val2 if $op eq "-";
            $values->{$key} = $val1 + $val2 if $op eq "+";
            $values->{$key} = $val1 * $val2 if $op eq "*";
            $values->{$key} = $val1 / $val2 if $op eq "/";
            delete $undefined->{$key};
        }
    }
}


say "The number that the monkey named 'root' yell - " . $values->{root} . ".";
