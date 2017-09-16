defmodule Spoilers.SetParser do
  def parse(html, set) do
    {:ok, do_parse(html, set)}
  end

  defp do_parse(html, set) when is_atom(set) do
    do_parse(html, Atom.to_string(set))
  end
  defp do_parse(html, set) when is_binary(set) do
    Regex.scan(~r/"cards\/(.+)\.html"/, html)
    |> Enum.map(fn [_, name] ->
      %{
        name: name,
        href: set <> "/cards/" <> name <> ".html",
        img:  set <> "/cards/" <> name <> ".jpg"
      }
    end)
  end
end
