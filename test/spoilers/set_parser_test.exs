defmodule Spoilers.SetParserTest do
  use ExUnit.Case
  alias Spoilers.Fixtures

  test "parses set html" do
    html = Fixtures.set_html
    {:ok, set} = Spoilers.SetParser.parse(html)

    # check some random samples
    sample = Enum.at(set, 0)
    name = sample[:name]
    assert sample == %{
      href: "cards/" <> name <> ".html",
      img: "cards/" <> name <> ".jpg",
      name: name
    }
  end
end
