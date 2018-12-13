defmodule AOC.Day3Test do
  use ExUnit.Case

  import AOC.StringStream

  describe "part 1" do
    test "handles provided example" do
      data = """
      #1 @ 1,3: 4x4
      #2 @ 3,1: 4x4
      #3 @ 5,5: 2x2
      """

      assert AOC.Day3.part1(data |> stream) == 4
    end
  end

  describe "part 2" do
    test "handles provided example" do
      data = """
      #1 @ 1,3: 4x4
      #2 @ 3,1: 4x4
      #3 @ 5,5: 2x2
      """

      assert AOC.Day3.part2(data |> stream) == 3
    end
  end
end
