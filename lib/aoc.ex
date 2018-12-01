defmodule AOC do
  def run() do
    day1()
  end

  def day1() do
    {:ok, data} = File.read("priv/data/day1.txt")
    IO.inspect(AOC.Day1.part1(data), label: :day1_part1)
    IO.inspect(AOC.Day1.part2(data), label: :day1_part2)
  end
end
