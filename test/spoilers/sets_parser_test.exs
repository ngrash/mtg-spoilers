defmodule Spoiler.SetsParserTest do
  use ExUnit.Case
  alias Spoilers.Fixtures

  test "parses sets html" do
    html = Fixtures.sets_html
    {:ok, sets} = Spoilers.SetsParser.parse(html)

    assert Enum.count(sets) == 103
  end
end
