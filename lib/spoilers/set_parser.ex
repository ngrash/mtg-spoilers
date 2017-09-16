defmodule Spoilers.SetParser do
  def parse(html) do
    {:ok, do_parse(html)}
  end

  defp do_parse(html) do
    tree = Floki.find(html, ".card")
    Enum.map(tree, fn {"a", [_, {"href", href}], [{"img", img, _}]} ->
      {_, src} = Enum.find(img, fn x -> elem(x, 0) == "src" end)
      %{name: Path.basename(src, ".jpg"), href: href, img: src}
    end)
  end
end
