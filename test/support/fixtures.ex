defmodule Spoilers.Fixtures do
  @fixtures_path Path.expand("../fixtures", __DIR__)

  @sets_html_file "mythicspoiler.com_sets-2017-09-16.html"
  @set_html_file "mythicspoiler.com_ixa_index-2017-09-16.html"

  def sets_html, do: read_fixture(@sets_html_file)
  def set_html, do: read_fixture(@set_html_file)

  defp read_fixture(file_name) do
    File.read!(Path.join(@fixtures_path, file_name))
  end
end
