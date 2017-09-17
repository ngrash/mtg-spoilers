defmodule Spoilers.Cookie do
  alias Spoilers.Cookie

  import Plug.Conn, only: [put_resp_cookie: 3]

  defstruct [
    set: nil,
    lessons_done: [],
    current_lesson: 1,
    current_card: 0,
    cards_done: [],
  ]

  def get(%Plug.Conn{} = conn) do
    %Cookie{}
    |> put_if_present(:set, conn.cookies["s"])
    |> put_if_present(:lessons_done, deserialize_lessons(conn.cookies["l"]))
    |> put_if_present(:current_lesson, deserialize_integer(conn.cookies["c"]))
    |> put_if_present(:current_card, deserialize_integer(conn.cookies["cc"]))
    |> put_if_present(:cards_done, deserialize_cards(conn.cookies["cd"]))
  end

  defp put_if_present(map, _, nil), do: map
  defp put_if_present(map, key, any), do: Map.put(map, key, any)

  def put(%Cookie{} = cookie, %Plug.Conn{} = conn) do
    conn
    |> put_resp_cookie("s", cookie.set)
    |> put_resp_cookie("l", serialize_lessons(cookie.lessons_done))
    |> put_resp_cookie("c", Integer.to_string(cookie.current_lesson))
    |> put_resp_cookie("cc", Integer.to_string(cookie.current_card))
    |> put_resp_cookie("cd", serialize_cards(cookie.cards_done))
  end

  defp deserialize_integer(nil), do: nil
  defp deserialize_integer(string) when is_binary(string) do
    String.to_integer(string)
  end

  defp serialize_lessons(lessons) when is_list(lessons) do
    lessons
    |> Enum.map(&to_padded_string(&1, 2))
    |> Enum.join
  end

  defp deserialize_lessons(nil), do: nil
  defp deserialize_lessons(""), do: []
  defp deserialize_lessons(lessons) when is_binary(lessons) do
    matches = Regex.scan(~r/(\d{2})/, lessons)
    Enum.map(matches, fn [string, _] ->
      String.to_integer(string)
    end)
  end

  defp serialize_cards(cards) when is_list(cards) do
    cards
    |> Enum.map(&to_padded_string(&1, 3))
    |> Enum.join
  end

  defp deserialize_cards(nil), do: nil
  defp deserialize_cards(""), do: []
  defp deserialize_cards(cards) when is_binary(cards) do
    matches = Regex.scan(~r/(\d{3})/, cards)
    Enum.map(matches, fn [string, _] ->
      String.to_integer(string)
    end)
  end

  defp to_padded_string(number, size) when is_integer(number) do
    number
    |> Integer.to_string
    |> String.pad_leading(size, "0")
  end
end
