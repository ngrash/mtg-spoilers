defmodule Spoilers.TrainerTest do
  use ExUnit.Case

  alias Spoilers.Trainer

  test "deserialization error" do
    status = Trainer.from_cookie(%{"s" => "ixa"})
    assert {:error, :missing_cookie_key} = status
  end

  test "deserializes cookie" do
    {:ok, trainer} = Trainer.from_cookie(%{"s" => "ixa", "l" => "001042"})

    assert trainer.set == "ixa"
    assert trainer.learned == [1, 42]
  end

  test "serializes cookie" do
    cookie = Trainer.to_cookie(%Trainer{set: "ixa", learned: [23, 911]})

    assert cookie == [
      {"s", "ixa"},
      {"l", "023911"},
    ]
  end
end
