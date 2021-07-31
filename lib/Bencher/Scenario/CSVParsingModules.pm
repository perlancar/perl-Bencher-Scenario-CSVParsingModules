package Bencher::Scenario::CSVParsingModules;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

use File::ShareDir::Tarball qw(dist_dir);

our $scenario = {
    summary => 'Benchmark CSV parsing modules',
    modules => {
        # minimum versions
        #'Foo' => {version=>'0.31'},
    },
    participants => [
        {
            module => 'Text::CSV_PP',
            code_template => 'my $csv = Text::CSV_PP->new({binary=>1}); open my $fh, "<", <filename>; my $rows = []; while (my $row = $csv->getline($fh)) { push @$rows, $row }',
        },
        {
            module => 'Text::CSV_XS',
            code_template => 'my $csv = Text::CSV_XS->new({binary=>1}); open my $fh, "<", <filename>; my $rows = []; while (my $row = $csv->getline($fh)) { push @$rows, $row }',
        },
        {
            name => 'naive-split',
            code_template => 'open my $fh, "<", <filename>; my $rows = []; while (defined(my $row = <$fh>)) { chomp $row; push @$rows, [split /,/, $row] }',
        },
    ],

    datasets => [
    ],
};

my $dir = dist_dir('CSV-Examples')
    or die "Can't find share dir for CSV-Examples";
for my $filename (glob "$dir/examples/*bench*.csv") {
    my $basename = $filename; $basename =~ s!.+/!!;
    push @{ $scenario->{datasets} }, {
        name => $basename,
        args => {filename => $filename},
    };
}

1;
# ABSTRACT:
