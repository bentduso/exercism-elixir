defmodule Chessboard do
  def rank_range, do: 1..8

  def file_range, do: ?A..?H

  def ranks, do: rank_range() |> Range.to_list()

  def files do
    file_range()
    |> Range.to_list()
    |> Enum.map(&<<&1>>)
  end
end
