defmodule TwitterWeb.Router do
  use TwitterWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug TwitterWeb.Plugs.SetCurrentUser
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: TwitterWeb.Schema.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: TwitterWeb.Schema.Schema,
      socket: TwitterWeb.UserSocket
  end

  # pipeline :browser do
  #   plug :accepts, ["html"]
  #   plug :fetch_session
  #   plug :fetch_flash
  #   plug :protect_from_forgery
  #   plug :put_secure_browser_headers
  # end

  # pipeline :api do
  #   plug :accepts, ["json"]
  # end

  # scope "/", TwitterWeb do
  #   pipe_through :browser

  #   get "/", PageController, :index
  # end

  # # Other scopes may use custom stacks.
  # scope "/api", TwitterWeb do
  #   pipe_through :api
  # end
end
