defmodule AOC do
  def run() do
    1..25 |> Enum.each(&day/1)
  end

  @parts 1..2

  defp day(n) do
    data_file = "priv/data/day#{n}.txt"
    mod = Module.concat(AOC, "Day#{n}" |> String.to_atom())
    Code.ensure_loaded?(mod)

    @parts
    |> Enum.each(fn part ->
      part_fun = "part#{part}" |> String.to_atom()

      if function_exported?(mod, part_fun, 1) do
        stream(data_file, fn data_stream ->
          apply(mod, part_fun, [data_stream])
          |> IO.inspect(label: "Day #{n}, part #{part}")
        end)
      end
    end)
  end

  defp stream(file_path, f) do
    file_path
    |> File.open([:read], fn io ->
      io
      |> IO.stream(:line)
      |> Stream.map(&String.trim/1)
      |> f.()
    end)
  end
end
