Messageboard thing
==================

This is the software written to power forum.asayers.org. It isn't a traditional forum; rather, it's something of an experiment. It has a minimalistic feature set, but remains functional.

Any user with an account can post to any message board (except ones which have been locked) using the field at the bottom of the page. Posts are written in markdown.

The current board is displayed in the header. Change board by clicking it and entering the name of another board. Create a new board simply by changing to it. You can create pseudo-private boards by keeping the name a secret.

The whole thing's written in [meteor](http://www.meteor.com), and is very simple (around 100 lines functional code). Enjoy!

Dependencies
------------

Meteor packages required:

- preserve-inputs
- less
- coffeescript
- accounts-password
- accounts-ui
- jquery
- showdown
- backbone

Licence
-------

BSD 2-clause. Comes with no warranties, expressed or implied.
