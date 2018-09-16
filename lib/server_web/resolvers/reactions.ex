defmodule ServerWeb.Resolvers.Reactions do
  alias Server.Reactions

  def like_photo(_, %{photo_id: photo_id}, %{context: %{current_user: current_user}}) do
    with {:ok, message} <- Reactions.like_photo(photo_id, current_user.id) do
      {:ok, message}
    end
  end

  #   viewer_like should be non null boolean in posts types

  def viewer_like_photo(%{id: id}, _, %{context: %{current_user: current_user}}) do
    with {:ok, message} <- Reactions.viewer_like_photo(id, current_user.id) do
      {:ok, message}
    end
  end
end
