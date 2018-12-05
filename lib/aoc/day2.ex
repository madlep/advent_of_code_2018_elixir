defmodule AOC.Day2 do
  def part1(data_stream) do
    result =
      data_stream
      |> Stream.map(&letter_count_set/1)
      |> Enum.reduce(%{}, fn lcs, totals -> lcs |> count_values(totals) end)
    result[2] * result[3]
  end

  def letter_count_set(str) do
    str
    |> String.graphemes()
    |> count_values()
    |> Map.values()
    |> MapSet.new()
  end

  defp count_values(map, initial_acc \\ %{}) do
    map
    |> Enum.reduce(initial_acc, fn key, counts ->
      Map.update(counts, key, 1, &(&1 + 1))
    end)
  end
end
