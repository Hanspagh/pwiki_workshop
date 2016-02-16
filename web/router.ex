defmodule Pwiki.Router do
  use Pwiki.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Pwiki do
    pipe_through :browser # Use the default browser stack

    get "/random", PageController, :random
    get "/", PageController, :index
    get "/:name", ArticleController, :show
    get "/new/:name", ArticleController, :new
    post "/article", ArticleController, :create

  end

  # Other scopes may use custom stacks.
  # scope "/api", Pwiki do
  #   pipe_through :api
  # end
end
