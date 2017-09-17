defmodule Spoilers.SetsParser do
  def parse(html) do
    {:ok, do_parse(html)}
  end

  defp do_parse(html) do
    tree = Floki.find(html, "a[href]")
    Enum.reduce(tree, [], fn element, sets ->
      case element do
        {"a", [{"href", href}], _} ->
          case href do
            <<code :: binary-size(3)>> <> "/index.html" ->
              [code | sets]
            _other ->
              sets
          end
        _other ->
          sets
      end
    end)
    |> Enum.reverse
    |> Enum.uniq
  end
end
