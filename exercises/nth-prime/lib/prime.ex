defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise(ArgumentError)

  def nth(count) do
    Stream.iterate(1, &(&1 + 1))
    |> Stream.filter(&prime?(&1))
    |> Enum.at(count - 1)
  end

  @spec prime?(non_neg_integer) :: boolean
  def prime?(number) when number < 2, do: false
  def prime?(2), do: true

  def prime?(number) do
    2..(trunc(:math.sqrt(number)) + 1)
    |> Enum.all?(&(rem(number, &1) != 0))
  end
end
