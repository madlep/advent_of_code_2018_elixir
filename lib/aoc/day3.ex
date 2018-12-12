defmodule AOC.Day3 do
  alias AOC.Day3.{
    Parser,
    State,
    Area
  }

  import Destructure

  def part1(data) do
    result = run(data)
    Area.count(result.overlaps)
  end

  def part2(data) do
    result = run(data)
    good_claim = result.good_claims |> hd()
    good_claim.id
  end

  defmodule State do
    defstruct claimed: Area.empty(), overlaps: Area.empty(), good_claims: []
  end

  defp run(data) do
    :erlang.process_flag(:min_heap_size, 200_000)

    data
    |> Task.async_stream(fn line ->
      {:ok, d([id, x, y, width, height]), _, _, _, _} = Parser.claim(line)

      Area.new(d([id, x, y, width, height]))
    end)
    |> Enum.reduce(%State{}, fn {:ok, new_claim}, d(%State{claimed, overlaps, good_claims}) ->
      new_claim_overlap = Area.intersection(claimed, new_claim)

      good_claims =
        if Area.empty?(new_claim_overlap) do
          [new_claim | good_claims]
        else
          good_claims
          |> Enum.reject(fn claim -> !Area.empty?(Area.intersection(claim, new_claim)) end)
        end

      d(%State{
        good_claims,
        claimed: Area.union(claimed, new_claim),
        overlaps: Area.union(overlaps, new_claim_overlap)
      })
    end)
  end
end
