defmodule AOC.Scene.Main do
  use Scenic.Scene
  alias Scenic.Graph
  import Scenic.Primitives, only: [text: 3]

  alias AOC.Component.Nav

  @graph Graph.build(font: :roboto, font_size: 24, theme: :dark)
  |> text("Advent Of Code", translate: {100, 100})
  |> Nav.add_to_graph(__MODULE__)

  def init(_args, _opts) do
    push_graph(@graph)
    {:ok, @graph}
  end
end
