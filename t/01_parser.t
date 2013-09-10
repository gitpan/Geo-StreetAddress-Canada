use blib;
use Test::More;
use strict;
use warnings;
use Data::Dumper;

use_ok( "Geo::StreetAddress::Canada" );

my %address = (
    "151 Front Street M5J 2N1" => {
          'number' => '151',
          'street' => 'Front',
          'postalcode' => 'M5J 2N1',
          'type' => 'St',
        },
    "151 Front Street, M5J 2N1" => {
          'number' => '151',
          'street' => 'Front',
          'postalcode' => 'M5J 2N1',
          'type' => 'St',
        },
    "151 Front Street W, M5J 2N1" => {
          'number' => '151',
          'street' => 'Front',
          'postalcode' => 'M5J 2N1',
          'suffix' => 'W',
          'type' => 'St',
        },
    "151 Front Street West, M5J 2N1" => {
          'number' => '151',
          'street' => 'Front',
          'postalcode' => 'M5J 2N1',
          'suffix' => 'W',
          'type' => 'St',
        },
    "151 W Front Street, Toronto, ON" => {
          'number' => '151',
          'street' => 'Front',
          'province' => 'ON',
          'city' => 'Toronto',
          'type' => 'St',
          'prefix' => 'W'
        },
    "151 W Front Street, Suite 500, Toronto, ON" => {
          'number' => '151',
          'street' => 'Front',
          'province' => 'ON',
          'city' => 'Toronto',
          'type' => 'St',
          'prefix' => 'W',
          'sec_unit_type' => 'Suite',
          'sec_unit_num' => '500',
        },
    "151 W Front Street Suite 500 Toronto, ON" => {
          'number' => '151',
          'street' => 'Front',
          'province' => 'ON',
          'city' => 'Toronto',
          'type' => 'St',
          'prefix' => 'W',
          'sec_unit_type' => 'Suite',
          'sec_unit_num' => '500',
        },
    "151 W Front Street, Toronto, ON, M5J 2N1" => {
          'number' => '151',
          'street' => 'Front',
          'province' => 'ON',
          'city' => 'Toronto',
          'postalcode' => 'M5J 2N1',
          'type' => 'St',
          'prefix' => 'W'
        },
    "151 W Front Street, Toronto ON M5J 2N1" => {
          'number' => '151',
          'street' => 'Front',
          'province' => 'ON',
          'city' => 'Toronto',
          'postalcode' => 'M5J 2N1',
          'type' => 'St',
          'prefix' => 'W'
        },
    "151 Front Street W Toronto ON" => {
          'number' => '151',
          'street' => 'Front',
          'province' => 'ON',
          'city' => 'Toronto',
          'suffix' => 'W',
          'type' => 'St',
        },
    "151 Front Street W, Toronto ON" => {
          'number' => '151',
          'street' => 'Front',
          'province' => 'ON',
          'city' => 'Toronto',
          'suffix' => 'W',
          'type' => 'St',
        },
    "151 Front Street, W Toronto ON" => {
          'number' => '151',
          'street' => 'Front',
          'province' => 'ON',
          'city' => 'West Toronto',
          'type' => 'St',
        },
    "151 Front Street, West Toronto ON" => {
          'number' => '151',
          'street' => 'Front',
          'province' => 'ON',
          'city' => 'West Toronto',
          'type' => 'St',
        },
    "151 Front Street Toronto ON" => {
          'number' => '151',
          'street' => 'Front',
          'province' => 'ON',
          'city' => 'Toronto',
          'type' => 'St',
        },
    "920 Yonge Toronto ON" => {
          'type' => '',
          'number' => '920',
          'street' => 'Yonge',
          'province' => 'ON',
          'city' => 'Toronto',
        },
    "770 Don Mills Rd, Toronto, ON M3C 1T3" => {
          'number' => '770',
          'street' => 'Don Mills',
          'province' => 'ON',
          'city' => 'Toronto',
          'postalcode' => 'M3C 1T3',
          'type' => 'Rd',
        },
    "770 Don Mills Rd Toronto ON M3C 1T3" => {
          'number' => '770',
          'street' => 'Don Mills',
          'province' => 'ON',
          'city' => 'Toronto',
          'postalcode' => 'M3C 1T3',
          'type' => 'Rd',
        },
    "1122 International Blvd Burlington ON L7L 6Z8" => {
          'number' => '1122',
          'street' => 'International',
          'province' => 'ON',
          'city' => 'Burlington',
          'postalcode' => 'L7L 6Z8',
          'type' => 'Blvd',
        },
    "1122 International Blvd. Burlington ON" => {
          'number' => '1122',
          'street' => 'International',
          'province' => 'ON',
          'city' => 'Burlington',
          'type' => 'Blvd',
        },
    "1122 International Boulevard Burlington ON" => {
          'number' => '1122',
          'street' => 'International',
          'province' => 'ON',
          'city' => 'Burlington',
          'type' => 'Blvd',
        },
    "100 East Street, Hamilton, ON" => {
          'number' => '100',
          'street' => 'East',
          'province' => 'ON',
          'city' => 'Hamilton',
          'type' => 'St',
        },
    "100 S.E. Toronto St, Toronto, ON" => {
          'number' => '100',
          'street' => 'Toronto',
          'province' => 'ON',
          'city' => 'Toronto',
          'type' => 'St',
          'prefix' => 'SE'
        },
    "3813 1/2 Some Road, North York, ON" => {
          'number' => '3813',
          'street' => 'Some',
          'province' => 'ON',
          'city' => 'North York',
          'type' => 'Rd',
        },
    "Yonge & Dundas Toronto ON" => {
          'type1' => '',
          'type2' => '',
          'street1' => 'Yonge',
          'province' => 'ON',
          'city' => 'Toronto',
          'street2' => 'Dundas'
        },
    "Yonge & Dundas, Toronto ON" => {
          'type1' => '',
          'type2' => '',
          'street1' => 'Yonge',
          'province' => 'ON',
          'city' => 'Toronto',
          'street2' => 'Dundas'
        },
    "Yonge St and Dundas St Toronto ON" => {
          'type1' => 'St',
          'type2' => 'St',
          'street1' => 'Yonge',
          'province' => 'ON',
          'city' => 'Toronto',
          'street2' => 'Dundas'
        },
    "Yonge St & Dundas St Toronto ON" => {
          'type1' => 'St',
          'type2' => 'St',
          'street1' => 'Yonge',
          'province' => 'ON',
          'city' => 'Toronto',
          'street2' => 'Dundas'
        },
    "Yonge & Dundas St. Toronto ON" => {
          'type1' => 'St',
          'type2' => 'St',
          'street1' => 'Yonge',
          'province' => 'ON',
          'city' => 'Toronto',
          'street2' => 'Dundas'
        },
    "Yonge & Dundas Street Toronto ON" => {
          'type1' => 'St',
          'type2' => 'St',
          'street1' => 'Yonge',
          'province' => 'ON',
          'city' => 'Toronto',
          'street2' => 'Dundas'
        },
    "Yonge Street and Dundas Street Toronto ON" => {
          'type1' => 'St',
          'type2' => 'St',
          'street1' => 'Yonge',
          'province' => 'ON',
          'city' => 'Toronto',
          'street2' => 'Dundas'
        },
    "1 First St, e York ON" => { # lower case city direction
          'number' => '1',
          'street' => 'First',
          'province' => 'ON',
          'city' => 'East York',
          'type' => 'St',
        },
    "123 Maple Markham, Ontario" => { # space in state name
          'type' => '',
          'number' => '123',
          'street' => 'Maple',
          'province' => 'ON',
          'city' => 'Markham',
        },
    "23310 S Service Rd lobby L4L 2W1" => { # unnumbered secondary unit type
          'number' => '23310',
          'street' => 'Service',
          'postalcode' => 'L4L 2W1',
          'type' => 'Rd',
          'prefix' => 'S',
          'sec_unit_type' => 'lobby',
        },
    "(23310 S Service Rd lobby L4L 2W1)" => { # surrounding punctuation
          'number' => '23310',
          'street' => 'Service',
          'postalcode' => 'L4L 2W1',
          'type' => 'Rd',
          'prefix' => 'S',
          'sec_unit_type' => 'lobby',
        },
    "#42 23310 S Service Rd L4L 2W1" => { # leading numbered secondary unit type
          'sec_unit_num' => '42',
          'postalcode' => 'L4L 2W1',
          'number' => '23310',
          'street' => 'Service',
          'sec_unit_type' => '#',
          'type' => 'Rd',
          'prefix' => 'S'
        },
    "lt42 99 Some Road, Some City Ontario" => { # no space before sec_unit_num
          'sec_unit_num' => '42',
          'city' => 'Some City',
          'number' => '99',
          'street' => 'Some',
          'sec_unit_type' => 'lt',
          'type' => 'Rd',
          'province' => 'ON'
        },
    "36401 County Road 43, Arthur, Ontario L0J 3W1" => { # numbered County Road
          'city' => 'Arthur',
          'postalcode' => 'L0J 3W1',
          'number' => '36401',
          'street' => 'County Road 43',
          'type' => 'Rd',
          'province' => 'ON'
        },
    "1234 COUNTY HWY 109E, Palmerston, ON L0S 9L1" => {
        'city' => 'Palmerston',
        'postalcode' => 'L0S 9L1',
        'number' => '1234',
        'street' => 'COUNTY HWY 109',
        'suffix' => 'E',
        'type' => '',  # ?
        'province' => 'ON'
        },

);


while (my ($addr, $expected) = each %address) {
    my $parse = Geo::StreetAddress::Canada->parse_location( $addr );
    is_deeply( $parse, $expected, "can parse $addr" )
        or warn "Got: ".Dumper($parse);
}


my @failures = (
    "1005 N Front St Toronto",
    "1005 N Front St Toronto CZ",
    "Front Hwy M5J 2N1",
    "E151 Front Street M5J 2N1",
    "151E Front St M5J 2N1",
);

for my $fail (@failures) {
    my $parse = Geo::StreetAddress::Canada->parse_location( $fail );
    ok( !$parse || !defined($parse->{state}), "can't parse $fail" );
}

ok not Geo::StreetAddress::Canada->avoid_redundant_street_type;
Geo::StreetAddress::Canada->avoid_redundant_street_type(1);
ok Geo::StreetAddress::Canada->avoid_redundant_street_type;

is_deeply Geo::StreetAddress::Canada->parse_location("136401 County Road 109, Arthur, ON L0L 1L0"), {
    'city' => 'Arthur',
    'postalcode' => 'L0L 1L0',
    'number' => '136401',
    'street' => 'County Road 109',
    'type' => undef,  #
    'province' => 'ON'
}, 'type should be undef for Country Road 43 with avoid_redundant_street_type';

# XXX TODO: a suffix like "COUNTY HWY 60E" breaks this logic
# but not very badly, suffix='E', street='COUNTY HWY 60' and type='' (not undef)
is_deeply Geo::StreetAddress::Canada->parse_location("1234 COUNTY HWY 60, Town, ON L1L 1L1"), {
    'city' => 'Town',
    'postalcode' => 'L1L 1L1',
    'number' => '1234',
    'street' => 'COUNTY HWY 60',
    'type' => undef,
    'province' => 'ON'
}, 'type should be undef for COUNTY HWY 60 with avoid_redundant_street_type';

done_testing();


