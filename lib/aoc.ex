defmodule AOC do
  def run() do
    day1()
  end

  def day1() do
    stream "priv/data/day1.txt", fn data_stream ->
      IO.inspect(AOC.Day1.part1(data_stream), label: :day1_part1)
    end

    stream "priv/data/day1.txt", fn data_stream ->
      IO.inspect(AOC.Day1.part2(data_stream), label: :day1_part2)
    end
  end

  defp stream(file_path, f) do
    file_path
    |> File.open([:read], fn(io) ->
      io
      |> IO.stream(:line)
      |> Stream.map(&String.trim/1)
      |> f.()
    end)
  end
end
