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
    |> Stream.scan({0, :not_found, MapSet.new([0])}, fn
      i, {current, :not_found, seen} ->
        new_current = current + i
        if MapSet.member?(seen, new_current) do
          {new_current, :found, seen}
        else
          {new_current, :not_found, MapSet.put(seen, new_current)}
        end
      _i, acc -> acc
      end)
    |> Stream.filter(fn {_current, :not_found, _seen} -> false
                        {_current, :found, _seen}      -> true
    end)
    |> Stream.take(1)
    |> Enum.at(0)
    |> elem(0)
  end
end
