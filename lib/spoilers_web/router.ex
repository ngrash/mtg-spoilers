defmodule SpoilersWeb.Router do
  use SpoilersWeb, :router

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

  scope "/", SpoilersWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/learn", LearnController, :show
    post "/learn/set", LearnController, :start_set
    post "/learn/set/cancel", LearnController, :cancel_set
    post "/learn/lesson", LearnController, :start_lesson
    post "/learn/lesson/cancel", LearnController, :cancel_lesson
    post "/learn/review", LearnController, :card_review
    post "/learn/done", LearnController, :card_done
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpoilersWeb do
  #   pipe_through :api
  # end
end
