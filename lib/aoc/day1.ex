defmodule AOC.Day1 do
  def part1(data_stream) do
    data_stream
    |> Stream.map(&String.to_integer/1)
    |> Enum.sum
  end

  def part2(data_stream) do
    data_stream
    |> Enum.map(&String.to_integer/1)
    |> Stream.cycle
    |> Stream.transform({0, MapSet.new([0])}, fn
      i, {current, seen} ->
        new_current = current + i
        if MapSet.member?(seen, new_current) do
          {[new_current], :done}
        else
          {[new_current], {new_current, MapSet.put(seen, new_current)}}
        end
      _i, :done -> {:halt, :done}
    end)
    |> Enum.at(-1)
  end
end
