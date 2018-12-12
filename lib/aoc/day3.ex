defmodule AOC.Day3 do
  alias AOC.Day3.{
    Parser,
    State,
    Area
  }

  defmodule State do
    defstruct claimed: Area.empty(), overlaps: Area.empty()
  end

  def part1(data) do
    data
    |> Stream.map(fn line ->
      {:ok, tokens, _rest, _context, _line, _byte_offset} = Parser.claim(line)
      tokens
    end)
    |> Enum.reduce(%State{}, fn [id: _id, x: x, y: y, width: w, height: h],
                                %State{claimed: claimed, overlaps: overlaps} ->
      new_claim = Area.new(x: x, y: y, width: w, height: h)
      new_claim_overlap = Area.intersection(claimed, new_claim)

      %State{
        claimed: Area.union(claimed, new_claim),
        overlaps: Area.union(overlaps, new_claim_overlap)
      }
    end)
    |> Map.get(:overlaps)
    |> Area.count()
  end

end
