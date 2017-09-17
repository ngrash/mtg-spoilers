defmodule SpoilersWeb.LearnController do
  use SpoilersWeb, :controller

  alias Spoilers.{Trainer,Cookie,LessonServer}

  def show(conn, _param) do
    cookie = Cookie.get(conn)
    if Trainer.new_user?(cookie) do
      {:ok, sets} = LessonServer.get_sets
      render conn, "welcome.html", sets: sets
    else
      if Trainer.lesson_done?(cookie) do
        {:ok, lessons} = LessonServer.get_lessons(cookie.set)
        conn
        |> put_flash(:info, "Well done! You completed lesson #{cookie.current_lesson+1}.")
        |> render("done.html", lessons: lessons)
      else
        if Trainer.lesson_started?(cookie) do
          {:ok, card} =
            LessonServer.get_card(
              cookie.set,
              cookie.current_lesson,
              cookie.current_card)

          render conn, "show.html", set: cookie.set, card: card
        else
          {:ok, lessons} = LessonServer.get_lessons(cookie.set)
          render conn, "begin.html", set: cookie.set, lessons: lessons
        end
      end
    end
  end

  def start_lesson(conn, %{"lesson" => lesson}) do
    Cookie.get(conn)
    |> Trainer.clear_current_cards
    |> Trainer.put_lesson(lesson)
    |> Trainer.put_next_card
    |> Cookie.put(conn)
    |> redirect to: learn_path(conn, :show)
  end

  def start_set(conn, %{"set" => set}) do
    Cookie.get(conn)
    |> Trainer.put_set(set)
    |> Cookie.put(conn)
    |> redirect to: learn_path(conn, :show)
  end

  def card_review(conn, _param) do
    Cookie.get(conn)
    |> Trainer.put_next_card
    |> Cookie.put(conn)
    |> redirect to: learn_path(conn, :show)
  end

  def card_done(conn, _param) do
    Cookie.get(conn)
    |> Trainer.put_current_done
    |> Trainer.put_next_card
    |> Cookie.put(conn)
    |> redirect to: learn_path(conn, :show)
  end
end
