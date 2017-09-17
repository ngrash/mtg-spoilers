defmodule Spoilers.MythicSpoiler do
  use HTTPotion.Base

  def process_url(url) do
    "http://mythicspoiler.com/" <> url
  end

  def list_sets do
    get("sets.html").body
    |> Spoilers.SetsParser.parse
  end

  def list_cards(set) when is_binary(set) do
    get("#{set}/index.html").body
    |> Spoilers.SetParser.parse
  end

  def get_image(set, card) do
    get("#{set}/cards/#{card}.jpg").body
  end
end
