defmodule AOC.Day1 do
  def part1(data) do
    data
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum
  end
end
