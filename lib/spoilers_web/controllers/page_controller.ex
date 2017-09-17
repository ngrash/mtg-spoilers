defmodule SpoilersWeb.PageController do
  use SpoilersWeb, :controller

  def index(conn, _params) do
    redirect conn, to: learn_path(conn, :show)
  end
end
