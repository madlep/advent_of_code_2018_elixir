defmodule AOC do
  @days 1..25
  @parts 1..2

  def run() do
    for day <- @days, part <- @parts do
      runner_fun = "day#{day}_part#{part}" |> String.to_atom()

      Task.async(fn ->
        if function_exported?(__MODULE__, runner_fun, 0) do
          apply(__MODULE__, runner_fun, [])
        else
          nil
        end
      end)
    end
    |> Enum.each(fn task ->
      case Task.await(task, :infinity) do
        {:ok, result} ->
          IO.puts(
            "day=#{result[:day]} part=#{result[:part]} result=#{result[:result]} time=#{
              result[:time]
            }"
          )

        nil ->
          nil
      end
    end)

    :ok
  end

  for day <- @days do
    mod = Module.concat(AOC, "Day#{day}" |> String.to_atom())
    Code.ensure_compiled?(mod)

    for part <- @parts do
      part_fun = "part#{part}" |> String.to_atom()

      if function_exported?(mod, part_fun, 1) do
        runner_fun = "day#{day}_part#{part}" |> String.to_atom()

        def unquote(runner_fun)() do
          data_file = "priv/data/day#{unquote(day)}.txt"

          stream(data_file, fn data_stream ->
            {time, result} = :timer.tc(unquote(mod), unquote(part_fun), [data_stream])
            {:ok, [day: unquote(day), part: unquote(part), result: result, time: time]}
          end)
        end
      end
    end
  end

  defp stream(file_path, f) do
    {:ok, result} =
      file_path
      |> File.open([:read], fn io ->
        io
        |> IO.stream(:line)
        |> Stream.map(&String.trim/1)
        |> f.()
      end)

    result
  end
end
