defmodule AOC.Day2 do
  def part1(data_stream) do
    result =
      data_stream
      |> Stream.map(&letter_count_set/1)
      |> Enum.reduce(%{}, fn lcs, totals ->
        lcs
        |> Enum.reduce(totals, fn n, lcs_totals ->
          Map.update(lcs_totals, n, 1, &(&1 + 1))
        end)
      end)

    result[2] * result[3]
  end

  def letter_count_set(str) do
    str
    |> String.graphemes()
    |> Enum.reduce(%{}, fn c, acc -> Map.update(acc, c, 1, &(&1 + 1)) end)
    |> Map.values()
    |> MapSet.new()
  end
end
