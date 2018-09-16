defmodule ServerWeb.Schema do
  use Absinthe.Schema

  alias ServerWeb.Resolvers
  alias ServerWeb.Schema.Middleware

  import_types(__MODULE__.PostsTypes)
  import_types(__MODULE__.AccountsTypes)

  query do
    @desc "Get list of photos"
    field :photos, list_of(:photo) do
      middleware.Middleware.Authorize
      resolve(&Resolvers.Posts.photos/3)
    end

    @desc "get single photo via id"
    field :photo, :photo do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Posts.photo/3)
    end

    @desc "Get a presigned for an upload photo"
    field :presign_url, :presign_url do
      middleware.Middleware.Authorize
      resolve(&Resolvers.Posts.presign_url/3)
    end

    @desc "Get all comments for a photo"
    field :comments, non_null(list_of(:comment)) do
      arg(:photo_id, non_null(:id))
      middleware.Middleware.Authorize
      resolve(&Resolvers.Posts.get_comments/3)
    end
  end

  mutation do
    @desc "Login as user"
    field :login, :user_session do
      arg(:token, :string)
      arg(:provider, type: :provider)
      resolve(&Resolvers.Accounts.login/3)
    end

    @desc "Create a photo"
    field :create_photo, :photo do
      arg(:image_url, :string)
      arg(:caption, :string)
      middleware.Middleware.Authorize
      resolve(&Resolvers.Posts.create_photo/3)
    end

    @desc "Like or unlike a photo"
    field :like_photo, :boolean do
      arg(:photo_id, non_null(:id))
      middleware(Middleware.Authorize)
      resolve(&Resolvers.Reactions.like_photo/3)
    end

    @desc "Create a comment for photo"
    field :create_comment, :comment do
      arg(:photo_id, non_null(:id))
      arg(:text, non_null(:string))
      middleware(Middleware.Authorize)
      resolve(&Resolvers.Posts.create_comment/3)
    end
  end
end
