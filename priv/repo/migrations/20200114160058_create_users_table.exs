defmodule Twitter.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :username, :string, null: false
      add :password_hash, :string, null: false
      add :email, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:username, :email])
  end
end
