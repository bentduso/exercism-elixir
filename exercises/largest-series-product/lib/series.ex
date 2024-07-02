defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product("", _), do: raise ArgumentError
  def largest_product(_, size) when size < 0, do: raise ArgumentError
  def largest_product(string, size) when size > byte_size(string), do: raise ArgumentError

  def largest_product(string, size),
    do:
      string
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(size, 1, :discard)
      |> Enum.map(&Enum.product/1)
      |> Enum.max()
end
