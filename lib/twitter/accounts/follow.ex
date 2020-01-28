defmodule Twitter.Accounts.Follow do
@moduledoc """
Schema for following
"""
  use Ecto.Schema
  import Ecto.Changeset
  alias Twitter.Repo
  alias Twitter.Accounts.User

  @required_fields ~w(
    username
    followed_user_id
  )a

  schema "follow" do
    field(:username, :string)
    field(:followed_user_id, :id)

    belongs_to(:user, User)

    timestamps()
  end

  def changeset(following, attrs) do
    following
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
