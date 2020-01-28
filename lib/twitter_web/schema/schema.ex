defmodule TwitterWeb.Schema.Schema do
  use Absinthe.Schema
  alias Twitter.Accounts
  alias Twitter.Accounts.User

  import_types Absinthe.Type.Custom
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  alias TwitterWeb.Resolvers
  alias TwitterWeb.Schema.Middleware

  query do
    @desc "Get the currently signed-in user"
    field :me, :user do
      resolve &Resolvers.Accounts.me/3
    end
  end

  mutation do
    @desc "Create a new user account"
    field :signup, :session do
      arg :first_name, non_null(:string)
      arg :last_name, non_null(:string)
      arg :username, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      resolve &Resolvers.Accounts.signup/3
    end

    @desc "Sign in current user"
    field :signin, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      resolve &Resolvers.Accounts.signin/3
    end

    @desc "Create a tweet"

  end

  # Object types
  object :user do
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
    field :username, non_null(:string)
    field :email, non_null(:string)
    # field :tweets, list_of(:tweet) do
    #   arg :limit, type: :integer, default_value: 100
    #   resolve dataloader(User, :tweets, args: %{scope: :user})
    # end
  end

  object :session do
    field :user, non_null(:user)
    field :token, non_null(:string)
  end
end
