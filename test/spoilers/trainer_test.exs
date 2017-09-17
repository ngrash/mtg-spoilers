defmodule Spoilers.TrainerTest do
  use ExUnit.Case

  alias Spoilers.{Trainer,Cookie}

  test "initializing fresh cookie" do
    cookie = Trainer.initialize(%Cookie{})
    assert cookie.set == "ixa"
  end

  test "initializing stale cookie" do
    cookie = Trainer.initialize(%Cookie{set: "akh"})
    assert cookie.set == "akh"
  end
end
