defmodule SpoilersWeb.PageController do
  use SpoilersWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
