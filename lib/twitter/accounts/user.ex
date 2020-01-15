defmodule Twitter.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

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
    field(:email, :string)

    timestamps()
  end

  def changeset(user, attrs) do
    required_fields = [:username, :email, :password]

    user
    |> cast(attrs, required_fields)
    |> validate_required(required_fields)
    |> validate_length(:username, min: 2)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> hash_password()
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
