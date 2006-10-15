#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Exception;

use ok "Crypt::Util";

my ( $c, $fallback_cipher );
BEGIN {

	$c = Crypt::Util->new;

	$fallback_cipher = eval { $c->fallback_cipher };

	plan skip_all => "Couldn't load any cipher" if $@ =~ /^Couldn't load any cipher/;

	plan 'no_plan';
}


my $key = $c->process_key("foo");

ok( length($key), "key has some length" );

cmp_ok( $key, "ne", "foo", "it's a digest of some sort" );

is( $c->process_key("foo", literal_key => 1), "foo", "literal key");

$c->default_use_literal_key(1);

is( $c->process_key("foo"), "foo", "literal key from defaults" );
