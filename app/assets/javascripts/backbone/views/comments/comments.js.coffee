FileManager.Views.Comments ||= {}

class FileManager.Views.Comments.CommentsView extends Backbone.View
  template: JST["backbone/templates/comments/comments"]
  className: "comments_page row"

  initialize: ->
    @collection.on('reset', @renderComments, this)

  render: ->
    $(@el).html(@template())
    this

  renderComments: ->
    @collection.each(@addComment)

  addComment: (comment) ->
    console.log(comment.get("parent_identifier"))
    view = new FileManager.Views.Comments.CommentView(model: comment)
    $(comment.get("parent_identifier")).append(view.render().el)