defmodule AOC.Day1Test do
  use ExUnit.Case

  describe "part1" do
    test "provided data 1" do
      data = """
+1
+1
+1
"""
      assert AOC.Day1.part1(data) == 3
    end

    test "provided data 2" do
      data = """
+1
+1
-2
"""
      assert AOC.Day1.part1(data) == 0
    end

    test "provided data 3" do
      data = """
-1
-2
-3
"""
      assert AOC.Day1.part1(data) == -6
    end
  end
end
