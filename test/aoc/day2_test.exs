defmodule AOC.Day2Test do
  use ExUnit.Case

  import AOC.Result

  def stream(data) do
    data
    |> StringIO.open()
    |> ok!
    |> IO.stream(:line)
    |> Stream.map(&String.trim/1)
  end

  describe "part1" do
    @data """
    abcdef
    bababc
    abbcde
    abcccd
    aabcdd
    abcdee
    ababab
    """

    test "calculates checksum" do
      assert AOC.Day2.part1(@data |> stream) == 12
    end
  end

  describe "letter_count_set" do
    @counts %{
      "abcdef" => MapSet.new([1]),
      "bababc" => MapSet.new([1, 2, 3]),
      "abbcde" => MapSet.new([1, 2]),
      "abcccd" => MapSet.new([1, 3]),
      "aabcdd" => MapSet.new([1, 2]),
      "abcdee" => MapSet.new([1, 2]),
      "ababab" => MapSet.new([3])
    }

    test "provided data 1" do
      @counts
      |> Enum.each(fn {str, expected} ->
        assert AOC.Day2.letter_count_set(str) == expected
      end)
    end
  end

  describe "word diff counts" do
    def g(word), do: word |> String.graphemes()

    test "handles same word" do
      assert AOC.Day2.diff_count(g("abcdef"), g("abcdef")) == 0
    end

    test "handles differences up to max" do
      assert AOC.Day2.diff_count(g("abcdef"), g("abcxef")) == 1
    end

    test "returns :exceeded if more than max differences" do
      assert AOC.Day2.diff_count(g("abcdef"), g("abxdxf")) == :exceeded
    end
  end

  describe "part 2" do
    @data """
    abcde
    fghij
    klmno
    pqrst
    fguij
    axcye
    wvxyz
    """

    test "finds word with only one difference" do
      assert AOC.Day2.part2(@data |> stream) == "fgij"
    end
  end
end
