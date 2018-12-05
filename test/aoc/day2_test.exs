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
end
