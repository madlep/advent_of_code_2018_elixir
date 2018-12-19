defmodule AOC.Day5 do
  import Destructure

  @case_move 32

  def part1(data) do
    data
    |> Enum.at(0)
    |> String.to_charlist()
    |> react()
  end

  def part2(data) do
    data = data |> Enum.at(0)

    ?a..?z
    |> Task.async_stream(fn letter ->
      lower = List.to_string([letter])
      upper = List.to_string([letter - @case_move])
      regex = ~r([#{lower}#{upper}])

      data
      |> String.replace(regex, "")
      |> String.to_charlist()
      |> react()
    end)
    |> Enum.map(fn {:ok, len} -> len end)
    |> Enum.min()
  end

  defguardp is_opposite_case(c1, c2) when c1 == c2 + @case_move or c2 == c1 + @case_move

  defp react(polymer, state \\ [reacted: false, result: []])

  defp react([], reacted: false, result: result), do: length(result)
  defp react([], reacted: true, result: result), do: react(result)

  defp react([h1, h2 | rest], reacted: _, result: result) when is_opposite_case(h1, h2) do
    reacted = true
    react(rest, d([reacted, result]))
  end

  defp react([h | rest], d([reacted, result])) do
    result = [h | result]
    react(rest, d([reacted, result]))
  end
end
