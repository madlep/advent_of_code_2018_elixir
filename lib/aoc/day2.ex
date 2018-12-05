defmodule AOC.Day2 do
  def part1(data_stream) do
    with components <- checksum_components(data_stream) do
      components[2] * components[3]
    end
  end

  defp checksum_components(data_stream) do
    data_stream
    |> Stream.map(&letter_count_set/1)
    |> Enum.reduce(%{}, fn lcs, totals -> lcs |> count_values(totals) end)
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
