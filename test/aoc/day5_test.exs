defmodule AOC.Day5Test do
  use ExUnit.Case

  import AOC.StringStream

  describe "part 1" do
    @data %{
      "aA" => 0,
      "abBA" => 0,
      "abAB" => 4,
      "aabAAB" => 6,
      "dabAcCaCBAcCcaDA" => 10
    }

    test "handles provided example" do
      for {example, expected} <- @data do
        assert AOC.Day5.part1(example |> stream) == expected
      end
    end
  end

  describe "part 2" do
    test "handles provided example" do
      assert AOC.Day5.part2("dabAcCaCBAcCcaDA" |> stream) == 4
    end
  end
end
