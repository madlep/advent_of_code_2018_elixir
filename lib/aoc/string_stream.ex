defmodule AOC.StringStream do
  import AOC.Result

  def stream(data) do
    data
    |> StringIO.open()
    |> ok!
    |> IO.stream(:line)
    |> Stream.map(&String.trim/1)
  end
end
