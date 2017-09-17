defmodule Spoilers.LessonServer do
  use GenServer

  @cards_per_lesson 20

  alias Spoilers.CardStore
  require Logger

  #
  # Client
  #

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def get_lesson(set, number)
  when is_binary(set)
  when is_integer(number) do
    GenServer.call(__MODULE__, {:get_lesson, set, number})
  end

  def reload_sets do
    GenServer.cast(__MODULE__, :reload_sets)
  end

  #
  # Server
  #

  def init(:ok) do
    {:ok, load_sets()}
  end

  def handle_call({:get_lesson, set, lesson}, _from, state) do
    case fetch_lesson(state, set, lesson) do
      {:ok, cards} ->
        {:reply, {:ok, cards}, state}
      {:error, _} ->
        Logger.info("Could not find lesson #{lesson} of set #{set}. Reloading sets.")
        state = load_sets()
        {:reply, fetch_lesson(state, set, lesson), state}
    end
  end

  def handle_cast(:reload_sets, _state) do
    {:noreply, load_sets()}
  end

  defp fetch_lesson(state, set, lesson) do
    case Map.fetch(state, set) do
      {:ok, lessons} ->
        case Map.fetch(lessons, lesson) do
          {:ok, cards} ->
            {:ok, cards}
          :error ->
            {:error, {:no_such_lesson, set: set, lesson: lesson}}
        end
      :error ->
        {:error, {:no_such_set, set: set}}
    end
  end

  defp load_sets do
    CardStore.list_all
    |> Enum.reduce(%{}, fn {set, cards}, sets ->
      chunks = Enum.chunk_every(1..Enum.count(cards), @cards_per_lesson)
      {_count, lessons} =
        Enum.reduce(chunks, {0, %{}}, fn chunk, {index, lessons} ->
          {
            index+1,
            Map.put(lessons, index, Enum.map(chunk, fn n -> {n, cards[n]} end))
          }
        end)
      Map.put(sets, set, lessons)
    end)
  end
end
