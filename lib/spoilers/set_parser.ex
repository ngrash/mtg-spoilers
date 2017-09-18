defmodule Spoilers.SetParser do
  def parse(html) do
    {:ok, do_parse(html)}
  end

  defp do_parse(html) do
    Regex.scan(~r/"cards\/(\w+)\.jpg"/, html)
    |> Enum.map(fn [_, name] -> name end)
  end
end
