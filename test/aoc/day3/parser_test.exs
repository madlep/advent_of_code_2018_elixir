defmodule AOC.Day3.ParserTest do
  use ExUnit.Case

  alias AOC.Day3.Parser

  describe ".claim" do
    test "parses provided examples" do
      %{
        "#123 @ 3,2: 5x4" => [id: 123, x: 3, y: 2, width: 5, height: 4],
        "#1 @ 1,3: 4x4" => [id: 1, x: 1, y: 3, width: 4, height: 4],
        "#2 @ 3,1: 4x4" => [id: 2, x: 3, y: 1, width: 4, height: 4],
        "#3 @ 5,5: 2x2" => [id: 3, x: 5, y: 5, width: 2, height: 2]
      }
      |> Enum.each(fn {input, expected} ->
        assert match?(
                 {:ok, ^expected, _rest, _context, _line, _offset},
                 Parser.claim(input)
               )
      end)
    end
  end
end
