defmodule AOC.Component.Nav do
  use Scenic.Component

  alias Scenic.ViewPort
  alias Scenic.Graph

  import Scenic.Primitives, only: [{:text, 3}, {:rect, 3}]
  import Scenic.Components, only: [{:dropdown, 3}]

  @height 60

  def init(current_scene, opts) do
    {:ok, %ViewPort.Status{size: {width, _}}} = opts[:viewport] |> ViewPort.info()

    graph =
      Graph.build(font_size: 20)
      |> rect({width, @height}, fill: {48, 48, 48})
      |> text("Day:", translate: {14, 35}, align: :right)
      |> dropdown(
        {[
          {"Main", AOC.Scene.Main},
          {"Day 1, part 1", AOC.Scene.Day1Part1},
          {"Day 1, part 2", AOC.Scene.Day1Part2}
        ], current_scene},
        id: :nav,
        translate: {70, 15}
      )
      |> push_graph()

    {:ok, %{graph: graph, viewport: opts[:viewport]}}
  end

  def verify(scene) when is_atom(scene), do: {:ok, scene}
  def verify({scene, _} = data) when is_atom(scene), do: {:ok, data}
  def verify(_), do: :invalid_data

  def filter_event({:value_changed, :nav, scene}, _, %{viewport: vp} = state)
      when is_atom(scene) do
    ViewPort.set_root(vp, {scene, nil})
    {:stop, state}
  end

  # ----------------------------------------------------------------------------
  def filter_event({:value_changed, :nav, scene}, _, %{viewport: vp} = state) do
    ViewPort.set_root(vp, scene)
    {:stop, state}
  end
end
