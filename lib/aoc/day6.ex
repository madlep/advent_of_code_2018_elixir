defmodule AOC.Day6 do
  @type coord() :: {x :: integer, y :: integer}

  @type extents() :: {x_min :: integer, x_max :: integer, y_min :: integer, y_max :: integer}

  @spec part1(Enumerable.t()) :: integer()
  def part1(data) do
    with coords <- Enum.map(data, &parse_line/1),
         extents <- find_extents(coords) do
      extents
      |> all_points()
      |> find_all_closest(coords)
      |> reject_infinite_coords(extents)
      |> coord_areas()
      |> Map.values()
      |> Enum.sort()
    end
  end

  @spec parse_line(String.t()) :: coord()
  defp parse_line(line) do
    [x, y] =
      line
      |> String.split(", ")
      |> Enum.map(&String.to_integer/1)

    {x, y}
  end

  @spec find_extents([coord()]) :: extents()
  def find_extents(coords) do
    coords
    |> Enum.reduce(
      {nil, 0, nil, 0},
      fn {x, y}, {x_min, x_max, y_min, y_max} ->
        {min(x, x_min), max(x, x_max), min(y, y_min), max(y, y_max)}
      end
    )
  end

  @spec distance(coord(), coord()) :: integer
  def distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  @spec all_points(extents()) :: [coord()]
  def all_points({x_min, x_max, y_min, y_max}) do
    for x <- x_min..x_max, y <- y_min..y_max, do: {x, y}
  end

  @spec find_all_closest(points :: list(coord), coords:: list(coord())) :: Enum.t()
  def find_all_closest(points, coords) do
    points
      |> Stream.map(&find_closest(&1, coords))
      |> Stream.reject(fn x -> x == :tie end)
  end

  @spec find_closest(point :: coord(), coords :: [coord()]) :: coord() | :tie
  def find_closest(point, coords) do
    coords
    |> Enum.map(fn coord -> {distance(point, coord), coord} end)
    |> Enum.reduce(fn
      {d, _c}, {da, _ca} when d == da -> {d, :tie}
      {d, c}, {da, _ca} when d < da -> {d, c}
      {d, _c}, {da, ca} when d > da -> {da, ca}
    end)
    |> (fn {_distance, coord} -> coord end).()
  end

  @spec reject_infinite_coords(Enum.t(), extents()) :: Enum.t()
  def reject_infinite_coords(coords, extents) do
    coords
    |> Stream.reject(&infinite_coord?(&1, extents))
  end

  @spec infinite_coord?(coord(), extents()) :: boolean()
  def infinite_coord?({x, y}, {x_min, x_max, y_min, y_max}) do
    x == x_min || x == x_max || y == y_min || y == y_max
  end

  @spec coord_areas(list(coord())) :: %{required(coord()) => integer()}
  def coord_areas(coords) do
    coords
      |> Enum.reduce(%{}, fn coord, acc -> Map.update(acc, coord, 1, &(&1 + 1)) end)
      |> Enum.to_list()
      |> Enum.sort_by(fn {k,v} -> v end)
  end
end
