defmodule Spoilers.Trainer do
  alias Spoilers.{Cookie,LessonServer}

  def lesson_done?(%Cookie{} = cookie) do
    cookie.current_card == 0 && !Enum.empty?(cookie.cards_done)
  end

  def lesson_started?(%Cookie{} = cookie) do
    cookie.current_card != 0
  end

  def new_user?(%Cookie{} = cookie) do
    cookie.set == nil || cookie.set == ""
  end

  def put_set(%Cookie{} = cookie, set) do
    Map.put(cookie, :set, set)
  end

  def put_lesson(%Cookie{} = cookie, lesson) when is_binary(lesson) do
    put_lesson(cookie, String.to_integer(lesson))
  end
  def put_lesson(%Cookie{} = cookie, lesson) when is_integer(lesson) do
    Map.put(cookie, :current_lesson, lesson)
  end

  def clear_current_cards(%Cookie{} = cookie) do
    cookie
    |> Map.put(:cards_done, [])
    |> Map.put(:cards_review, [])
    |> Map.put(:current_card, 0)
  end

  def clear_lessons(%Cookie{} = cookie) do
    Map.put(cookie, :lessons_done, [])
  end

  def put_current_done(%Cookie{} = cookie) do
    Map.put(cookie, :cards_done, cookie.cards_done ++ [cookie.current_card])
  end

  def put_current_review(%Cookie{} = cookie) do
    Map.put(cookie, :cards_review, cookie.cards_review ++ [cookie.current_card])
  end

  def put_next_card(%Cookie{} = cookie) do
    {:ok, lesson} = LessonServer.get_lesson(cookie.set, cookie.current_lesson)
    candidates = Enum.reject(lesson, fn {num, name} ->
      Enum.member?(cookie.cards_done, num)
    end)

    if Enum.empty?(candidates) do
      cookie
      |> Map.put(:current_card, 0)
      |> Map.put(:lessons_done, cookie.lessons_done ++ [cookie.current_lesson])
    else
      {next_card, _} = Enum.random(candidates)
      Map.put(cookie, :current_card, next_card)
    end
  end

  def get_lesson(%Cookie{} = cookie), do: :not_implemented
  def put_lesson_done(%Cookie{} = cookie), do: :not_implemented
  def put_next_lesson(%Cookie{} = cookie), do: :not_implemented
end
