defmodule Server.Posts.Photo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Server.Posts.Photo

  schema "photos" do
    field(:caption, :string)
    field(:image_url, :string)

    belongs_to(:user, Server.Accounts.User)

    has_many(:likes, Server.Reactions.LikePhoto)
    has_many(:comments, Server.Posts.Comment)

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:image_url, :caption, :user_id])
    |> validate_required([:image_url, :user_id])
  end
end
