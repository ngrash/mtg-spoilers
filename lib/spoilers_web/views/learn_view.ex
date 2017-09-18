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
    {name, class} =
      case Enum.member?(cookie.lessons_done, lesson) do
        true -> {"Lesson #{lesson+1} (done)", "btn btn-outline-success btn-lg btn-block"}
        false -> {"Lesson #{lesson+1}", "btn btn-outline-warning btn-lg btn-block"}
      end

    button name, to: learn_path(conn, :start_lesson, lesson: lesson), class: class
  end
end
