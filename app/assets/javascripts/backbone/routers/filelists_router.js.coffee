class FileManager.Routers.FilelistsRouter extends Backbone.Router

  routes:
    'folders': 'index'
    'folders/:id': 'folderId'
    'folders/:id/comments': 'folderComments'
    'items/:id/comments': 'itemComments'

  initialize: ->
    @navigation = new FileManager.Views.Navigation.NavigationView()

  folderComments: (folder_id)->
    @comments = new FileManager.Collections.CommentsCollection(commentable_type: "folders", commentable_id: folder_id)
    @comments.fetch()
    view = new FileManager.Views.Comments.CommentsView(collection: @comments)
    $(".main_content.col-xs-10").html(view.render().el)

  itemComments: (item_id) ->
    @comments = new FileManager.Collections.CommentsCollection(commentable_type: "items", commentable_id: item_id)
    @comments.fetch()
    view = new FileManager.Views.Comments.CommentsView(collection: @comments)
    $(".main_content.col-xs-10").html(view.render().el)
    
  index: ->
    view = new FileManager.Views.Filelists.IndexView(folder_id: null)
    $(".main_content.col-xs-10").html(view.render().el)
    @navigation.set_current_folder_id(null)

  folderId: (folder_id) ->
    view = new FileManager.Views.Filelists.IndexView(folder_id: folder_id)
    $(".main_content.col-xs-10").html(view.render().el)
    @navigation.set_current_folder_id(folder_id)