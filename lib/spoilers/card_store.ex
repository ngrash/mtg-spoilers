defmodule Spoilers.CardStore do
  require Logger

  @path Path.expand("./cards")
  # filter a path for card information
  @expr ~r/(?<set>[\w\s]+)\/(?<number>\d{3})-(?<name>\w+)\.jpg$/

  def remove_set(set) do
    File.rm_rf!(Path.join(@path, set))
  end

  def list_all do
    Path.wildcard(Path.join(@path, "**/*.jpg"))
    |> Enum.reduce(%{}, fn path, sets ->
      case Regex.named_captures(@expr, path) do
        nil ->
          Logger.warn("Could not parse card info: #{path}")
          sets
        %{"set" => set, "number" => number, "name" => name} ->
          num = String.to_integer(number)
          case Map.has_key?(sets, set) do
            false ->
              Map.put(sets, set, %{num => name})
            true  ->
              put_in(sets, [set, num], name)
          end
      end
    end)
  end

  def store(set, name, image) do
    path = file_path(set, name)
    File.mkdir_p!(Path.dirname(path))
    File.write!(path, image, [:binary])
  end

  def exists?(set, name) do
    File.exists?(file_path(set, name))
  end

  defp file_path(set, name) do
    Path.join([@path, set, name <> ".jpg"])
  end
end
