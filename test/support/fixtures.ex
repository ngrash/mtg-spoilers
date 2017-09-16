defmodule Spoilers.Fixtures do
  @fixtures_path Path.expand("../fixtures", __DIR__)

  @sets_html_file "mythicspoiler.com_sets-2017-09-16.html"

  def sets_html do
    File.read!(Path.join(@fixtures_path, @sets_html_file))
  end
end
