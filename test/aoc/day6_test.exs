defmodule AOC.Day6Test do
  use ExUnit.Case

  import AOC.StringStream

  alias AOC.Day6

  describe "part 1" do
    test "handles provided example" do
      input = """
      1, 1
      1, 6
      8, 3
      3, 4
      5, 5
      8, 9
      """

      assert Day6.part1(input |> stream) == 17
    end
  end

  describe "find_extents" do
    test "finds the min/max x/y values" do
      data = [{1, 2}, {1, 6}, {8, 3}, {3, 4}, {5, 5}, {8, 9}]

      assert Day6.find_extents(data) == {1, 8, 2, 9}
    end
  end
end
