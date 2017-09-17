defmodule Spoilers.Trainer do
  defstruct set: nil, learned: []

  def new(set) do
    %Spoilers.Trainer{set: set}
  end

  def from_cookie(cookie) do
    with {:ok, set} <- Map.fetch(cookie, "s"),
         {:ok, learned} <- Map.fetch(cookie, "l")
    do
      trainer = %Spoilers.Trainer{
        set: set,
        learned: deserialize_numbers(learned),
      }
      {:ok, trainer}
    else
      :error -> {:error, :missing_cookie_key}
    end
  end

  def to_cookie(trainer) do
    [
      {"s", trainer.set},
      {"l", serialize_numbers(trainer.learned)},
    ]
  end

  defp serialize_numbers(numbers) do
    Enum.map(numbers, fn n ->
      Integer.to_string(n) |> String.pad_leading(3, "0")
    end)
    |> Enum.join
  end

  defp deserialize_numbers(numbers) do
    Enum.map(Regex.scan(~r/(\d{3})/, numbers), fn [n, _] ->
      String.to_integer(n)
    end)
  end
end
