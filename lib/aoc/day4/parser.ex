defmodule AOC.Day4.Parser do
  import NimbleParsec

  datetime =
    ignore(ascii_char([?[]))
    |> integer(min: 1)
    |> ignore(ascii_char([?-]))
    |> integer(2)
    |> ignore(ascii_char([?-]))
    |> integer(2)
    |> ignore(ascii_char([?\s]))
    |> integer(2)
    |> ignore(ascii_char([?:]))
    |> integer(2)
    |> ignore(ascii_char([?]]))
    |> reduce({List, :to_tuple, []})

  begin =
    ignore(string("Guard #"))
    |> unwrap_and_tag(integer(min: 1), :begin)
    |> ignore(string(" begins shift"))

  event =
    choice([
      begin,
      string("wakes up"),
      string("falls asleep")
    ])
    |> reduce({:decode_event, []})

  defp decode_event(["wakes up"]), do: :wake
  defp decode_event(["falls asleep"]), do: :asleep
  defp decode_event(begin: begin), do: {:begin, begin}

  # "[1518-11-01 00:00] Guard #10 begins shift"
  # "[1518-11-01 00:05] falls asleep"
  # "[1518-11-01 00:30] falls asleep"
  defparsec(
    :log,
    datetime
    |> ignore(ascii_char([?\s]))
    |> concat(event)
  )
end
