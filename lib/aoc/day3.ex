defmodule AOC.Day3 do
  end

  defmodule Area do
    use Bitwise

    @enforce_keys [:data, :row_size]
    defstruct data: 0, row_size: 0

    @default_row_size 1000

    def new(row_size \\ @default_row_size, x: x, y: y, width: width, height: height) do
      data =
        1..height
        |> Enum.reduce(0, fn row, acc ->
          1..width
          |> Enum.reduce(acc, fn col, acc2 ->
            cell = col + x - 1 + (row + y - 1) * row_size
            acc2 + (1 <<< cell)
          end)
        end)

      %Area{data: data, row_size: row_size}
    end

    def count(%Area{data: data}), do: do_count(data, 0)

    defp do_count(0, count), do: count

    defp do_count(data, count), do: do_count(data >>> 1, count + (data &&& 1))

    def intersection(
          %Area{data: data1, row_size: row_size},
          %Area{data: data2, row_size: row_size}
        ),
        do: %Area{row_size: row_size, data: data1 &&& data2}

    def intersection(%Area{row_size: _r1}, %Area{row_size: _r2}), do: {:error, :row_size_mismatch}

    def union(
          %Area{data: data1, row_size: row_size},
          %Area{data: data2, row_size: row_size}
        ),
        do: %Area{row_size: row_size, data: data1 ||| data2}

    def union(%Area{row_size: _r1}, %Area{row_size: _r2}), do: {:error, :row_size_mismatch}
  end
end
