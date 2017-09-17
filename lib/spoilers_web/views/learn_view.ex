defmodule SpoilersWeb.LearnView do
  use SpoilersWeb, :view

  def image_path(set, {number, name})
  when is_binary(set)
  when is_number(number)
  when is_binary(name) do
    num = Integer.to_string(number) |> String.pad_leading(3, "0")
    "/cards/#{set}/#{num}-#{name}.jpg"
  end

  def lesson_button(conn, {lesson, _}) when is_integer(lesson) do
    cookie = Spoilers.Cookie.get(conn)
    name =
      case Enum.member?(cookie.lessons_done, lesson) do
        true -> "Lesson #{lesson+1} (done)"
        false -> "Lesson #{lesson+1}"
      end

    button name, to: learn_path(conn, :start_lesson, lesson: lesson)
  end
end
