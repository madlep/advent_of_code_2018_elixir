defmodule AOC.Scene.Day1Part1 do
  use Scenic.Scene

  alias Scenic.Graph
  import Scenic.Primitives
  import Scenic.Components

  alias AOC.Component.Nav

  @graph Graph.build(font: :roboto, font_size: 24, theme: :dark)
  |> text("Day 1, part 1", translate: {100, 100})
  |> button("run", translate: {100, 140}, id: :run)
  |> text("result:", translate: {100, 200}, id: :result)
  |> text("exectuion time:", translate: {100, 240}, id: :time)
  |> path([], stroke: {4, :blue}, cap: :round, id: :freqs)
  |> Nav.add_to_graph(__MODULE__)

  def init(_args, _opts) do
    push_graph(@graph)
    {:ok, %{graph: @graph, freqs: []}}
  end

  def filter_event({:click, :run}, _from, state) do
    visualiser = build_visualiser()
    Task.async(fn -> AOC.day1_part1(visualiser) end)
    {:stop, state}
  end

  def filter_event({:frequency, sum: sum, n: n}, _from, state = %{freqs: freqs}) do
    new_state = %{state | freqs: [{sum, n}|freqs]}
    {:stop, new_state}
  end

  def filter_event({:result, result: result, time: time}, _from, state = %{graph: graph, freqs: freqs}) do
    graph =
      graph
      |> Graph.modify(:result, &text(&1, "result: #{result}"))
      |> Graph.modify(:time, &text(&1, "execution time: #{time}µs"))
      |> Graph.modify(:freqs, &path(&1, path_steps(freqs)))
      |> push_graph()

    {:stop, %{state | graph: graph} }
  end

  defp build_visualiser() do
    this = self()
    fn event -> Scenic.Scene.send_event(this, event) end
  end

  @path_x_origin 100
  @path_y_origin 300
  @path_height 400
  @path_width 800

  defp path_steps(freqs) do
    {{min, _n1}, {max, _n2}} = Enum.min_max_by(freqs, fn {sum, _n} -> sum end)
    sum_range = max - min

    y_offset = min(0, abs(min))

    y_scale = @path_height / sum_range

    count = length(freqs)
    x_scale = @path_width / count

    steps = freqs
            |> Enum.with_index(1)
            |> Enum.map(fn {{sum, _n}, i} -> {:line_to, @path_x_origin + (i * x_scale), @path_y_origin + y_offset + (sum * y_scale)} end)

    Enum.each(steps, &IO.inspect/1)

    List.flatten([
      :begin,
      {:move_to, @path_x_origin, @path_y_origin + y_offset},
      steps,
    ])
  end
end
