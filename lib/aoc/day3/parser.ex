defmodule AOC.Day3.Parser do
  import NimbleParsec

  whitespace = ignore(string(" "))

  id =
    ignore(string("#"))
    |> integer(min: 1)

  co_ords =
    unwrap_and_tag(integer(min: 1), :x)
    |> ignore(string(","))
    |> unwrap_and_tag(integer(min: 1), :y)

  dimensions =
    unwrap_and_tag(integer(min: 1), :width)
    |> ignore(string("x"))
    |> unwrap_and_tag(integer(min: 1), :height)

    # #123 @ 3,2: 5x4
  defparsec(
    :claim,
    unwrap_and_tag(id, :id)
    |> concat(whitespace)
    |> ignore(string("@"))
    |> concat(whitespace)
    |> concat(co_ords)
    |> ignore(string(": "))
    |> concat(dimensions)
  )
end
