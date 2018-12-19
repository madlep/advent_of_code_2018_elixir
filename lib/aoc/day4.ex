defmodule AOC.Day4 do
  alias AOC.Day4.{
    Parser,
    Guard
  }

  import Destructure

  def part1(data) do
    guards = project_guards(data)

    most_asleep_guard = guards |> Enum.max_by(fn guard -> guard.sleep_total end)

    {min, _slept} = most_asleep_guard |> Guard.most_asleep_minute()

    most_asleep_guard.id * min
  end

  def part2(data) do
    data
    |> project_guards()
    |> Enum.map(fn guard ->
      {min, slept} = Guard.most_asleep_minute(guard)
      {guard.id, min, slept}
    end)
    |> Enum.max_by(fn {_id, _min, slept} -> slept end)
    |> (fn {id, min, _slept} -> id * min end).()
  end

  defp project_guards(data) do
    data
    |> parse_events()
    |> apply_events()
  end

  defp parse_events(data) do
    data
    |> Enum.sort()
    |> Stream.map(fn log_line ->
      {:ok, payload, _, _, _, _} = Parser.log(log_line)
      payload
    end)
  end

  defp apply_events(events) do
    events
    |> Enum.reduce([id: nil, guards: %{}], &dispatch/2)
    |> (fn [id: _id, guards: guards] -> Map.values(guards) end).()
  end

  defp dispatch([_datetime, {:begin, id}], id: _old_id, guards: guards) do
    guard = Map.get(guards, id, Guard.new(id))
    guards = Map.put(guards, id, guard)
    d([id, guards])
  end

  defp dispatch([{_y, _m_, _d, _h, min}, :asleep], d([id, guards])) do
    guards = Map.update!(guards, id, &Guard.fall_asleep(&1, min))
    d([id, guards])
  end

  defp dispatch([{_y, _m_, _d, _h, min}, :wake], d([id, guards])) do
    guards = Map.update!(guards, id, &Guard.wake_up(&1, min))
    d([id, guards])
  end

  defmodule Guard do
    defstruct id: nil,
              state: :awake,
              sleep_mins: %{},
              sleep_total: 0

    def new(id), do: %Guard{id: id}

    def start_shift(guard = %Guard{state: :awake}) do
      guard
    end

    def fall_asleep(g = %Guard{state: :awake}, minute) do
      %Guard{g | state: {:asleep, minute}}
    end

    def wake_up(g = d(%Guard{sleep_mins, sleep_total, state: {:asleep, from}}), minute) do
      %Guard{
        g
        | state: :awake,
          sleep_mins:
            from..(minute - 1)
            |> Enum.reduce(sleep_mins, fn min, acc -> Map.update(acc, min, 1, &(&1 + 1)) end),
          sleep_total: sleep_total + (minute - 1 - from)
      }
    end

    def most_asleep_minute(d(%Guard{sleep_mins})) do
      sleep_mins
      |> Enum.max_by(fn {_min, slept} -> slept end, fn -> {0, 0} end)
    end
  end
end
