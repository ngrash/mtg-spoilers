defmodule Spoilers.Downloader do
  alias Spoilers.{MythicSpoiler,CardStore}

  require Logger

  def download_set(set) do
    {:ok, cards} = MythicSpoiler.list_cards(set)

    CardStore.remove_set(set)

    cards
    |> Enum.with_index
    |> Enum.each(fn {card, index} ->
      number = index+1 |> Integer.to_string |> String.pad_leading(3, "0")
      name = "#{number}-#{card}"
      Logger.debug "Downloading #{set}/#{name}"
      image = MythicSpoiler.get_image(set, card)
      CardStore.store(set, name, image)
    end)
    :ok
  end
end
