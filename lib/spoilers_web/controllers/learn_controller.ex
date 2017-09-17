defmodule SpoilersWeb.LearnController do
  use SpoilersWeb, :controller

  def show(conn, _param) do
    render conn, "show.html"
  end
end
