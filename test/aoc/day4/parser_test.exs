defmodule AOC.Day4.ParserTest do
  use ExUnit.Case

  alias AOC.Day4.Parser

  describe ".log" do
    test "parses provided examples" do
      %{
        "[1518-11-01 00:00] Guard #10 begins shift" => [{1518, 11, 1, 0, 0}, {:begin, 10}],
        "[1518-11-01 00:05] falls asleep" => [{1518, 11, 1, 0, 5}, :asleep],
        "[1518-11-01 00:25] wakes up" => [{1518, 11, 1, 0, 25}, :wake],
        "[1518-11-01 00:30] falls asleep" => [{1518, 11, 1, 0, 30}, :asleep],
        "[1518-11-01 00:55] wakes up" => [{1518, 11, 1, 0, 55}, :wake],
        "[1518-11-01 23:58] Guard #99 begins shift" => [{1518, 11, 1, 23, 58}, {:begin, 99}],
        "[1518-11-02 00:40] falls asleep" => [{1518, 11, 2, 0, 40}, :asleep],
        "[1518-11-02 00:50] wakes up" => [{1518, 11, 02, 0, 50}, :wake],
        "[1518-11-03 00:05] Guard #10 begins shift" => [{1518, 11, 3, 0, 5}, {:begin, 10}],
        "[1518-11-03 00:24] falls asleep" => [{1518, 11, 3, 0, 24}, :asleep],
        "[1518-11-03 00:29] wakes up" => [{1518, 11, 3, 0, 29}, :wake],
        "[1518-11-04 00:02] Guard #99 begins shift" => [{1518, 11, 4, 0, 2}, {:begin, 99}],
        "[1518-11-04 00:36] falls asleep" => [{1518, 11, 4, 0, 36}, :asleep],
        "[1518-11-04 00:46] wakes up" => [{1518, 11, 4, 0, 46}, :wake],
        "[1518-11-05 00:03] Guard #99 begins shift" => [{1518, 11, 5, 0, 3}, {:begin, 99}],
        "[1518-11-05 00:45] falls asleep" => [{1518, 11, 5, 0, 45}, :asleep],
        "[1518-11-05 00:55] wakes up" => [{1518, 11, 5, 0, 55}, :wake]
      }
      |> Enum.each(fn {input, expected} ->
        assert match?(
                 {:ok, ^expected, _rest, _context, _line, _offset},
                 Parser.log(input)
               )
      end)
    end
  end
end
