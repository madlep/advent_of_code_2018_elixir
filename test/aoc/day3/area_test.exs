defmodule AOC.Day3.AreaTest do
  use ExUnit.Case
  use Bitwise

  alias AOC.Day3.Area

  @row_size 10

  def c(x, y, row_size \\ @row_size), do: x + y * row_size

  test "can set region" do
    #  0123456789
    # 0..........
    # 1..........
    # 2.xxx......
    # 3.xxx......
    # 4.xxx......
    # 5.xxx......
    # 6..........
    area = Area.new(@row_size, id: 123, x: 1, y: 2, width: 3, height: 4)

    expected_set = [
      c(1, 2),
      c(2, 2),
      c(3, 2),
      c(1, 3),
      c(2, 3),
      c(3, 3),
      c(1, 4),
      c(2, 4),
      c(3, 4),
      c(1, 5),
      c(2, 5),
      c(3, 5)
    ]

    expected_data =
      expected_set
      |> Enum.reduce(0, fn n, acc -> acc + (1 <<< n) end)

    assert area.data == expected_data
  end

  describe "intersection" do
    test "can find intersection" do
      #  0123456789
      # 0..........
      # 1.aaa......
      # 2.aaXb.....
      # 3.aaXb.....
      # 4...bb.....
      # 5..........

      area1 = Area.new(@row_size, id: 123, x: 1, y: 1, width: 3, height: 3)
      area2 = Area.new(@row_size, id: 124, x: 3, y: 2, width: 2, height: 3)

      intersection = Area.intersection(area1, area2)

      expected_set = [c(3, 2), c(3, 3)]

      expected_data =
        expected_set
        |> Enum.reduce(0, fn n, acc -> acc + (1 <<< n) end)

      assert intersection.data == expected_data
    end

    test "finds nothing when no intersection" do
      #  0123456789
      # 0..........
      # 1.aaa......
      # 2.aaa..bb..
      # 3.aaa..bb..
      # 4......bb..
      # 5..........

      area1 = Area.new(@row_size, id: 123, x: 1, y: 1, width: 3, height: 3)
      area2 = Area.new(@row_size, id: 124, x: 6, y: 2, width: 2, height: 3)

      intersection = Area.intersection(area1, area2)

      expected_set = []

      expected_data =
        expected_set
        |> Enum.reduce(0, fn n, acc -> acc + (1 <<< n) end)

      assert intersection.data == expected_data
    end
  end

  describe "union" do
    test "can find union" do
      #  0123456789
      # 0..........
      # 1.aaa......
      # 2.aaXb.....
      # 3.aaXb.....
      # 4...bb.....
      # 5..........

      area1 = Area.new(@row_size, id: 123, x: 1, y: 1, width: 3, height: 3)
      area2 = Area.new(@row_size, id: 123, x: 3, y: 2, width: 2, height: 3)

      union = Area.union(area1, area2)

      expected_set = [
        c(1, 1),
        c(2, 1),
        c(3, 1),
        c(1, 2),
        c(2, 2),
        c(3, 2),
        c(4, 2),
        c(1, 3),
        c(2, 3),
        c(3, 3),
        c(4, 3),
        c(3, 4),
        c(4, 4)
      ]

      expected_data =
        expected_set
        |> Enum.reduce(0, fn n, acc -> acc + (1 <<< n) end)

      assert union.data == expected_data
    end

    test "finds both when no intersection" do
      #  0123456789
      # 0..........
      # 1.aaa......
      # 2.aaa..bb..
      # 3.aaa..bb..
      # 4......bb..
      # 5..........

      area1 = Area.new(@row_size, id: 123, x: 1, y: 1, width: 3, height: 3)
      area2 = Area.new(@row_size, id: 123, x: 6, y: 2, width: 2, height: 3)

      union = Area.union(area1, area2)

      expected_set = [
        c(1, 1),
        c(2, 1),
        c(3, 1),
        c(1, 2),
        c(2, 2),
        c(3, 2),
        c(1, 3),
        c(2, 3),
        c(3, 3),
        c(6, 2),
        c(7, 2),
        c(6, 3),
        c(7, 3),
        c(6, 4),
        c(7, 4)
      ]

      expected_data =
        expected_set
        |> Enum.reduce(0, fn n, acc -> acc + (1 <<< n) end)

      assert union.data == expected_data
    end
  end

  test "can count set cells" do
    #  0123456789
    # 0..........
    # 1.aaa......
    # 2.aaXb.....
    # 3.aaXb.....
    # 4...bb.....
    # 5..........
    area1 = Area.new(id: 123, x: 1, y: 1, width: 3, height: 3)
    area2 = Area.new(id: 123, x: 3, y: 2, width: 2, height: 3)

    union = Area.union(area1, area2)

    assert Area.count(union) == 13
  end
end
