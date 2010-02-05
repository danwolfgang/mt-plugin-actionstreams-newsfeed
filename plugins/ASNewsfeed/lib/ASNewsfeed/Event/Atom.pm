package ASNewsfeed::Event::Atom;

use strict;
use base qw( ActionStreams::Event );

use ActionStreams::Scraper;

__PACKAGE__->install_properties({
    class_type => 'newsfeedatom_posted',
});

__PACKAGE__->install_meta({
    columns => [ qw(
        source_title
        source_url
    ) ],
});

sub update_events {
    my $class = shift;
    my %profile = @_;
    my ($ident, $author) = @profile{qw( ident author )};

    my ($feed_url, $items);
    $items = $class->fetch_xpath(
        url => $ident,
        foreach => '//entry',
        get => {
            identifier   => 'id/child::text()',
            title        => 'title/child::text()',
            summary      => 'summary/child::text()',
            url          => q(link[@rel='alternate']/@href),
            source_title => 'ancestor::feed/title/child::text()',
            source_url   => q(ancestor::feed/link[@rel='alternate']/@href),
            created_on   => 'published/child::text()',
            modified_on  => 'updated/child::text()',
        },
    );

    return if !$items;

    $class->build_results( author => $author, items => $items );
}

1;

__END__
