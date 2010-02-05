package ASNewsfeed::Event::RSS;

use strict;
use base qw( ActionStreams::Event );

use ActionStreams::Scraper;

__PACKAGE__->install_properties({
    class_type => 'newsfeedrss_posted',
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
        foreach => '//item',
        get => {
            identifier   => 'guid/child::text()',
            title        => 'title/child::text()',
            url          => 'link/child::text()',
            source_title => 'ancestor::channel/title/child::text()',
            source_url   => 'ancestor::channel/link/child::text()',
            created_on   => 'pubDate/child::text()',
            modified_on  => 'pubDate/child::text()',
        },
    );
    for my $item (@$items) {
        $item->{identifier} ||= $item->{url} || $item->{title};
    }
    @$items = grep { $_->{identifier} } @$items;

    return if !$items;

    $class->build_results( author => $author, items => $items );
}

1;

__END__
