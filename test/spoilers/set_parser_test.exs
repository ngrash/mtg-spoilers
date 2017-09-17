defmodule Spoilers.SetParserTest do
  use ExUnit.Case
  alias Spoilers.Fixtures

  test "parses set html" do
    html = Fixtures.set_html
    {:ok, set} = Spoilers.SetParser.parse(html)

    assert Enum.at(set, 0) == "axisofmortality"
  end
end
