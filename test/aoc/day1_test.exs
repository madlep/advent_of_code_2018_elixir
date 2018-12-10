defmodule AOC.Day1Test do
  use ExUnit.Case

  import AOC.StringStream

  describe "part1" do
    test "provided data 1" do
      data = """
      +1
      +1
      +1
      """

      assert AOC.Day1.part1(data |> stream) == 3
    end

    test "provided data 2" do
      data = """
      +1
      +1
      -2
      """

      assert AOC.Day1.part1(data |> stream) == 0
    end

    test "provided data 3" do
      data = """
      -1
      -2
      -3
      """

      assert AOC.Day1.part1(data |> stream) == -6
    end
  end

  describe "part2" do
    test "provided data 1" do
      data = """
      +1
      -1
      """

      assert AOC.Day1.part2(data |> stream) == 0
    end

    test "provided data 2" do
      data = """
      +3
      +3
      +4
      -2
      -4
      """

      assert AOC.Day1.part2(data |> stream) == 10
    end

    test "provided data 3" do
      data = """
      -6
      +3
      +8
      +5
      -6
      """

      assert AOC.Day1.part2(data |> stream) == 5
    end

    test "provided data 4" do
      data = """
      +7
      +7
      -2
      -7
      -4
      """

      assert AOC.Day1.part2(data |> stream) == 14
    end
  end
end
