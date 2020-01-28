defmodule Twitter.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Twitter.Repo
  alias Twitter.Tweets.Tweet

  @required_fields ~w(
    first_name
    last_name
    username
    password_hash
    email
  )a

  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:username, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:email, :string)

    has_many(:tweets, Tweet)
    # has_many(:following, Following)
    # has_many(:followers, Followers)

    timestamps()
  end

  def changeset(user, attrs) do
    required_fields = [:first_name, :last_name, :username, :email, :password]

    user
    |> cast(attrs, required_fields)
    |> validate_required(required_fields)
    |> validate_length(:username, min: 2)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> hash_password()
  end

  def search(search_term, current_user) do
    Repo.all(
      from u in __MODULE__,
      where: ilike(u.username, ^("%" <> search_term <> "%")) and u.id != ^current_user.id,
      limit: 25
    )
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end
end
