defmodule Spoilers.CardStoreTest do
  use ExUnit.Case
  alias Spoilers.{Fixtures,CardStore}

  @sample_card_taget Path.expand("./cards/mm2/lightningbolt.jpg")

  setup do
    on_exit(fn ->
      File.rm(@sample_card_taget)
    end)
  end

  test "stores card" do
    card = Fixtures.sample_card
    CardStore.store(:mm2, "lightningbolt", card)

    assert File.exists?(@sample_card_taget)
  end
end
