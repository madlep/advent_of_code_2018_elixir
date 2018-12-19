defmodule AOC.Day5 do
  import Destructure

  def part1(data) do
    data
    |> Enum.at(0)
    |> String.to_charlist()
    |> react(reacted: false, result: [])
  end

  @case_move 32
  defguardp is_opposite_case(c1, c2) when c1 == c2 + @case_move or c2 == c1 + @case_move

  defp react([], reacted: false, result: result), do: length(result)
  defp react([], reacted: true, result: result), do: react(result, reacted: false, result: [])

  defp react([h1, h2 | rest], reacted: _, result: result) when is_opposite_case(h1, h2) do
    reacted = true
    react(rest, d([reacted, result]))
  end

  defp react([h | rest], d([reacted, result])) do
    result = [h | result]
    react(rest, d([reacted, result]))
  end
end
