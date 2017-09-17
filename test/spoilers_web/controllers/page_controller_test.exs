defmodule SpoilersWeb.PageControllerTest do
  use SpoilersWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert redirected_to(conn, 302) =~ "/learn"
  end
end
