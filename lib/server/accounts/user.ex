defmodule Server.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Server.Accounts.User

  schema "users" do
    field(:avatar, :string)
    field(:email, :string)
    field(:facebook_id, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:username, :string)

    has_many(:photos, Server.Posts.Photo)
    has_many(:like_photos, Server.Reactions.LikePhoto)
    has_many(:comments, Server.Posts.Comment)

    timestamps()
  end

  @doc false

  #   :first_name, :last_name removed from validate

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :avatar, :facebook_id, :email, :first_name, :last_name])
    |> validate_required([:avatar, :email, :facebook_id])
    |> unique_constraint(:email)
    |> unique_constraint(:facebook_id)
  end
end

# removing username from required
