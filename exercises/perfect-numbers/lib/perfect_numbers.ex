defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number <= 0 do
    {:error, "Classification is only possible for natural numbers."}
  end

  def classify(number) do
    sum = aliquot_sum(number)

    cond do
      sum == number -> {:ok, :perfect}
      sum > number -> {:ok, :abundant}
      sum < number -> {:ok, :deficient}
    end
  end

  @spec aliquot_sum(number :: integer()) :: integer()
  defp aliquot_sum(number) do
    if number > 1 do
      1..(number - 1)
      |> Enum.filter(&(rem(number, &1) == 0))
      |> Enum.sum()
    else
      0
    end
  end
end
