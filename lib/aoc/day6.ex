defmodule AOC.Day6 do
  alias AOC.Day6.Manhattan

  @spec part1(Enumerable.t()) :: integer()
  def part1(data) do
    with given_coords <- Enum.map(data, &parse_line/1),
         bounds <- Manhattan.bounds(given_coords),
         infinite_given_coords <- Manhattan.infinite_coords(given_coords, bounds) do
      bounds
      |> Manhattan.all_coords()
      |> Stream.map(&Manhattan.closest(&1, given_coords))
      |> Stream.reject(fn x -> x == :tie end)
      |> Stream.reject(&Enum.member?(infinite_given_coords, &1))
      |> coord_areas()
      |> Map.values()
      |> Enum.max()
    end
  end

  @spec parse_line(String.t()) :: Manhattan.coord()
  defp parse_line(line) do
    [x, y] =
      line
      |> String.split(", ")
      |> Enum.map(&String.to_integer/1)

    {x, y}
  end

  @spec coord_areas(Enum.t()) :: %{required(Manhattan.coord()) => integer()}
  def coord_areas(coords) do
    coords
    |> Enum.reduce(%{}, fn coord, acc -> Map.update(acc, coord, 1, &(&1 + 1)) end)
  end

  defmodule Manhattan do
    @type coord() :: {x :: integer(), y :: integer()}
    @type bounds() ::
            {x_min :: integer(), x_max :: integer(), y_min :: integer(), y_max :: integer()}

    @spec bounds([coord()]) :: bounds()
    def bounds(coords) do
      coords
      |> Enum.reduce(
        {nil, 0, nil, 0},
        fn {x, y}, {x_min, x_max, y_min, y_max} ->
          {min(x, x_min), max(x, x_max), min(y, y_min), max(y, y_max)}
        end
      )
    end

    @spec all_coords(bounds()) :: Enum.t()
    def all_coords({x_min, x_max, y_min, y_max}) do
      for x <- x_min..x_max, y <- y_min..y_max, do: {x, y}
    end

    @spec closest(coord :: coord(), given_coords :: Enum.t()) :: coord() | :tie
    def closest(coord, given_coords) do
      given_coords
      |> Enum.map(fn given_coord -> {distance(coord, given_coord), given_coord} end)
      |> Enum.reduce(fn
        {d, _c}, {da, _ca} when d == da -> {d, :tie}
        {d, c}, {da, _ca} when d < da -> {d, c}
        {d, _c}, {da, ca} when d > da -> {da, ca}
      end)
      |> (fn {_distance, coord} -> coord end).()
    end

    @spec distance(coord(), coord()) :: integer()
    defp distance({x1, y1}, {x2, y2}) do
      abs(x1 - x2) + abs(y1 - y2)
    end

    @spec infinite_coords(given_coords :: Enum.t(), bounds()) :: Enum.t()
    def infinite_coords(given_coords, bounds) do
      bounds
      |> bounds_coords()
      |> Enum.map(&closest(&1, given_coords))
      |> Enum.uniq()
      |> Enum.reject(&(&1 == :tie))
    end

    @spec bounds_coords(bounds()) :: Enum.t()
    defp bounds_coords({x_min, x_max, y_min, y_max}) do
      top_coords = for x <- x_min..(x_max - 1), y <- [y_min], do: {x, y}
      right_coords = for x <- [x_max], y <- y_min..(y_max - 1), do: {x, y}
      bottom_coords = for x <- (x_min + 1)..x_max, y <- [y_max], do: {x, y}
      left_coords = for x <- [x_min], y <- (y_min + 1)..y_max, do: {x, y}
      List.flatten([top_coords, right_coords, bottom_coords, left_coords])
    end
  end
end
