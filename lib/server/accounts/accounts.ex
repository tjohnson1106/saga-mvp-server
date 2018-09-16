defmodule Server.Accounts do
  import Ecto.Query, warn: false
  alias Server.Repo

  alias Server.Accounts.User

  def get_user_or_create(attrs, search_params) do
    case Repo.get_by(User, Map.to_list(search_params)) do
      nil ->
        create_user(attrs)

      user ->
        {:ok, user}
    end
  end

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
