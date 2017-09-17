defmodule Spoilers.CardStore do
  @path Path.expand("./cards")

  def remove_set(set) do
    File.rm_rf!(Path.join(@path, set))
  end

  def store(set, name, image) do
    path = file_path(set, name)
    File.mkdir_p!(Path.dirname(path))
    File.write!(path, image, [:binary])
  end

  def exists?(set, name) do
    File.exists?(file_path(set, name))
  end

  defp file_path(set, name) when is_atom(set) do
    file_path(Atom.to_string(set), name)
  end
  defp file_path(set, name) do
    Path.join([@path, set, name <> ".jpg"])
  end
end
