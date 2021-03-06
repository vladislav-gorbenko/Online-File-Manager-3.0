require 'grape'

module FileManager
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json
    version "v3"

    helpers ApiHelpers
    before do
      error! "token is invalid" if current_user.nil?
    end

    resource :folders do
      get do
        if params[:include_subfolders]
          present Folder.all, with: FolderEntity
        else
          present Folder.roots, with: FolderEntity
        end
      end

      resource ":folder_id" do
        include CommentAPI
        get do
          present Folder.find(params[:folder_id]).children, with: FolderEntity
        end

        resource :items do
          get  do  
            present Folder.find(params[:folder_id]).items, with: ItemEntity
          end
        end
      end
    end

    resource :items do
      get do  
        present Item.root, with: ItemEntity
      end
      
      resource ":item_id" do
        include CommentAPI
        get do 
          present Item.find(params[:item_id]), with: ItemEntity
        end
      end
    end
  end
end