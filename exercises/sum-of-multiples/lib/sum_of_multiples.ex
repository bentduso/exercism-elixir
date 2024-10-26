defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.reject(&(&1 == 0))
    |> Enum.flat_map(&multiples(&1, limit))
    |> Enum.uniq()
    |> Enum.sum()
  end

  @spec multiples(non_neg_integer, non_neg_integer) :: Enumerable.t()
  defp multiples(factor, limit) do
    Stream.iterate(factor, &(&1 + factor)) |> Stream.take_while(&(&1 < limit))
  end
end
