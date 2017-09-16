defmodule Spoiler.SetsParserTest do
  use ExUnit.Case
  alias Spoilers.Fixtures

  test "parses sets html" do
    html = Fixtures.sets_html
    {:ok, sets} = Spoilers.SetsParser.parse(html)

    # check some random samples
    assert sets[:akh] == %{href: "akh/index.html"}
    assert sets[:c17] == %{href: "c17/index.html"}
  end
end
