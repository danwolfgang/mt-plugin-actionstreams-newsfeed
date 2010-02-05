# Action Stream: Newsfeed, a Movable Type plugin to the Action Streams plugin that adds Atom and RSS feed services

The Action Streams plugin is great, but one area it causes trouble for some users is that there is no Atom or RSS feed service. The closest option is to use the Website service and hope that auto-discovery will find the feed you want, but there are many circumstances where that simply isn't a feasible option. This plugin remedies that with Atom and RSS services.

## Determining the type of feed

Yes, this plugin would be a little more user-friendly if it auto-discovered what kind of feed you supplied, but it doesn't do that. It's easy enough for you to determine what type of feed you are looking at, and from there you can choose the Atom or RSS service.

### Atom

View source, and after the "<?xml..." line, you will see a "<feed..." line -- it's Atom! Or, quickly scan the feed and you'll see many "<entry>" and "</entry>" elements--it's Atom!

### RSS

RSS = Just about anything else. View source and quickly scan and you should see many "<item>" and "</item>" elements.
