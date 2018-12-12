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

  defmodule State do
    defstruct claimed: Area.empty(), overlaps: Area.empty()
  end

  defp run(data) do
    :erlang.process_flag(:min_heap_size, 200_000)

    data
    |> Task.async_stream(fn line ->
      {:ok, d([id, x, y, width, height]), _, _, _, _} = Parser.claim(line)

      Area.new(d([id, x, y, width, height]))
    end)
    |> Enum.reduce(%State{}, fn {:ok, new_claim}, %State{claimed: claimed, overlaps: overlaps} ->
      new_claim_overlap = Area.intersection(claimed, new_claim)

      %State{
        claimed: Area.union(claimed, new_claim),
        overlaps: Area.union(overlaps, new_claim_overlap)
      }
    end)
  end
end
