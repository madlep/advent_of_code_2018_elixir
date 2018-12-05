defmodule AOC.Day2 do
  def part1(data_stream) do
    with components <- checksum_components(data_stream) do
      components[2] * components[3]
    end
  end

  def part2(data_stream) do
    data_stream
    |> Stream.map(&String.graphemes/1)
    |> Enum.to_list()
    |> compare_words()
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

  def diff_count(w1, w2, max_diffs \\ 1) when is_list(w1) and is_list(w2) do
    Enum.zip(w1, w2)
    |> Enum.reduce_while(0, fn
      {c, c}, count -> {:cont, count}
      {_c1, _c2}, count when count < max_diffs -> {:cont, count + 1}
      {_c1, _c2}, count when count >= max_diffs -> {:halt, :exceeded}
    end)
  end

  defp compare_words([]), do: {:error, :not_found}

  defp compare_words([w1 | words]) do
    case compare_words(w1, words) do
      {w1, w2} -> strip_differences(w1, w2) |> Enum.join()
      false -> compare_words(words)
    end
  end

  defp compare_words(_w, []), do: false

  defp compare_words(w1, [w2 | words]) do
    case diff_count(w1, w2) do
      :exceeded -> compare_words(w1, words)
      _n -> {w1, w2}
    end
  end

  defp strip_differences(w1, w2) do
    Enum.zip(w1, w2)
    |> Enum.flat_map(fn
      {c, c} -> [c]
      {_c1, _c2} -> []
    end)
  end
end
