defmodule AOC.Day3.Area do
  use Bitwise

  alias AOC.Day3.Area

  import Destructure

  @enforce_keys [:data, :row_size]
  defstruct data: 0, row_size: 0, id: nil

  @default_row_size 1000

  def empty(row_size \\ @default_row_size), do: %Area{data: 0, row_size: row_size}

  def new(row_size \\ @default_row_size, d([id, x, y, width, height])) do
    data =
      1..height
      |> Enum.reduce(0, fn row, acc ->
        cell_y = (row + y - 1) * row_size
        from = x + cell_y
        to = from + width
        acc + (1 <<< to) - (1 <<< from)
      end)

    d(%Area{data, row_size, id})
  end

  def count(d(%Area{data})), do: do_count(data, 0)

  @m1 0x5555555555555555
  @m2 0x3333333333333333
  @m4 0x0F0F0F0F0F0F0F0F
  @m8 0x00FF00FF00FF00FF
  @m16 0x0000FFFF0000FFFF
  @m32 0x00000000FFFFFFFF

  defp do_count(0, count), do: count

  defp do_count(data, count) do
    x = data
    x = (x &&& @m1) + (x >>> 1 &&& @m1)
    x = (x &&& @m2) + (x >>> 2 &&& @m2)
    x = (x &&& @m4) + (x >>> 4 &&& @m4)
    x = (x &&& @m8) + (x >>> 8 &&& @m8)
    x = (x &&& @m16) + (x >>> 16 &&& @m16)
    x = (x &&& @m32) + (x >>> 32 &&& @m32)
    data = data >>> 64
    do_count(data, count + x)
  end

  def intersection(
        d(%Area{row_size, data: data1}),
        d(%Area{row_size, data: data2})
      ),
      do: d(%Area{row_size, data: data1 &&& data2})

  def intersection(%Area{row_size: _r1}, %Area{row_size: _r2}), do: {:error, :row_size_mismatch}

  def union(
        d(%Area{row_size, data: data1}),
        d(%Area{row_size, data: data2})
      ),
      do: %Area{row_size: row_size, data: data1 ||| data2}

  def union(%Area{row_size: _r1}, %Area{row_size: _r2}), do: {:error, :row_size_mismatch}

  def empty?(%Area{data: 0}), do: true
  def empty?(%Area{data: _any}), do: false
end
