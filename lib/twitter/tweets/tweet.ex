defmodule Twitter.Tweets.Tweet do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Twitter.Repo

  alias Twitter.Accounts.User

  @required_fields ~w(
    body
    user_id
  )a

  schema "tweets" do
    field(:body, :string)

    belongs_to(:user, User)

    timestamps()
  end

  def get_all_by_user_id(id) do
    __MODULE__
    |> where([u], u.id == ^id)
    |> Repo.all()
  end

  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:user_id)
  end
end
