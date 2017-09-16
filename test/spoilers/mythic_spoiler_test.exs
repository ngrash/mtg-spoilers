defmodule Spoilers.MythicSpoilerTest do
  use ExUnit.Case

  test "process_url" do
    url = Spoilers.MythicSpoiler.process_url("example.html")
    assert url == "http://mythicspoiler.com/example.html"
  end
end
