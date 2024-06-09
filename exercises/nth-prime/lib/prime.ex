defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(1), do: 2

  def nth(count) do
    Stream.iterate(3, &(&1 + 2))
    |> Stream.filter(&prime?/1)
    |> Enum.at(count - 1)
  end

  @spec prime?(non_neg_integer) :: boolean
  defp prime?(number) when number <= 1, do: false

  defp prime?(number) do
    2..floor(:math.sqrt(number))
    |> Enum.all?(&(rem(number, &1) != 0))
  end
end
