Seeds = new Object()

Seeds.populate = ->
  timestamp = new Date().getTime()
  author = "asayers"
  topic = "welcome"
  Posts.insert({message: "Welcome to forum.asayers.org", author: author, topic: topic, timestamp: timestamp})
  Posts.insert({message: "This isn't a traditional forum. Rather, it's something of an experiment", author: author, topic: topic, timestamp: timestamp})
  Posts.insert({message: "If you have created an account, you can post to any message board (except ones which have been locked, like this one)", author: author, topic: topic, timestamp: timestamp})
  Posts.insert({message: "To post to the current board, use the field below", author: author, topic: topic, timestamp: timestamp})
  Posts.insert({message: "Posts are written in markdown, so you can easily include formatting information", author: author, topic: topic, timestamp: timestamp})
  Posts.insert({message: "To change board, click the name of the current board at the top of the page and enter the name of the destination board", author: author, topic: topic, timestamp: timestamp})
  Posts.insert({message: "To create a new board, just change to it and start posting", author: author, topic: topic, timestamp: timestamp})
  Posts.insert({message: "You can create pseudo-private boards simply by keeping the name a secret", author: author, topic: topic, timestamp: timestamp})
  Posts.insert({message: "The board you're on will update in real time - there's no need to reload the page", author: author, topic: topic, timestamp: timestamp})
  Posts.insert({message: "Please try to make your posts respectful and enriching. Have fun!", author: author, topic: topic, timestamp: timestamp})
