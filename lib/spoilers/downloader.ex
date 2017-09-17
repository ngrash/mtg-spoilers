defmodule Spoilers.Downloader do
  alias Spoilers.{MythicSpoiler,CardStore}

  require Logger

  def download_set(set) do
    {:ok, cards} = MythicSpoiler.list_cards(set)
    for card <- cards do
      Logger.debug "Downloading #{set}/#{card}"
      image = MythicSpoiler.get_image(set, card)
      CardStore.store(set, card, image)
    end
    :ok
  end
end
