Posts = new Meteor.Collection("posts")
App   = new Object()

App.locked_topics = ["welcome"]


######### Server ##########

if Meteor.isServer
  Meteor.publish("latest_posts", (topic) ->
    Posts.find({topic: topic}))

  Meteor.methods {
    post: (message, topic) ->
      user = Meteor.user()
      time = new Date().getTime()
      if user and topic not in App.locked_topics
        Posts.insert({author: user.username, topic: topic, message: message, timestamp: time})
  }

  Meteor.startup ->
    if Posts.find().count() == 0
      Seeds.populate()


######### Client #########

if Meteor.isClient
  App.sanitize = (string) ->
    string.replace(" ", "_").replace(/[^A-Za-z0-9_-]/g, "")

  ForumRouter = Backbone.Router.extend({
    routes: { ":topic_name": "topic" },
    topic: (name) ->
      Session.set("topic", App.sanitize(name))
    setTopic: (name) ->
      this.navigate(App.sanitize(name), true)
  })

  Router = new ForumRouter

  App.topic = ->
    Session.get("topic")

  Meteor.startup ->
    Session.set("topic", "welcome")
    Backbone.history.start({ pushState: true })

  Meteor.autosubscribe ->
    Meteor.subscribe("latest_posts", App.topic())

  Template.listing.rendered = ->
      $("body").scrollTop($("#add_post").offset().top)

  Template.heading.topic = App.topic

  Template.heading.events = {
    "click #topic_name": ->
      $("#topic").html('<input type="text" id="new_topic" placeholder="Change topic" />')
      $("#new_topic").val(App.topic()).focus().select()
    "focusout #new_topic": ->
      $("#topic").html('<h1 id="topic_name">' + Template.heading.topic() + '</h1>')
    "keyup #new_topic": (event) ->
      if event.keyCode == 13
        topic = $("#new_topic").val()
        if topic == "" or topic == App.topic()
          $("#topic").html('<h1 id="topic_name">' + Template.heading.topic() + '</h1>')
        else
          Router.setTopic(topic)
  }

  Template.listing.posts = -> Posts.find()

  Template.post.ownership = ->
    if Meteor.user() and Meteor.user().username == this.author
      "self"
    else
      "other"

  Template.post.time = ->
    date = new Date(this.timestamp)
    "#{date.getUTCDate()}/#{date.getUTCMonth()+1}/#{date.getUTCFullYear()} #{date.getUTCHours()}:#{if date.getUTCMinutes() < 10 then "0" else ""}#{date.getUTCMinutes()}"

  Accounts.ui.config {
    passwordSignupFields: "USERNAME_AND_EMAIL"
  }

  Template.add_post.forbidden = ->
    if App.topic() in App.locked_topics
      return "This topic is locked"
    unless Meteor.user()
      return "You must be logged in to post"
    return null

  Template.add_post.events {
    'keyup': (event) ->
      if event.keyCode == 13
        text_area = $("#new_post")
        unless text_area.val() == ""
          Meteor.call("post", text_area.val(), App.topic())
          text_area.val("")
  }
