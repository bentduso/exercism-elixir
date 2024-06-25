defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dices :: [integer]) :: integer
  def score(category, dices), do: Enum.sort(dices) |> do_score(category)

  @spec do_score(dices :: [integer], category :: category()) :: integer
  defp do_score(dices, :ones), do: trivial_score(dices, 1)
  defp do_score(dices, :twos), do: trivial_score(dices, 2)
  defp do_score(dices, :threes), do: trivial_score(dices, 3)
  defp do_score(dices, :fours), do: trivial_score(dices, 4)
  defp do_score(dices, :fives), do: trivial_score(dices, 5)
  defp do_score(dices, :sixes), do: trivial_score(dices, 6)
  defp do_score([dice, dice, dice, dice, dice], :full_house), do: 0
  defp do_score([dice1, dice1, dice2, dice2, dice2] = dices, :full_house), do: Enum.sum(dices)
  defp do_score([dice1, dice1, dice1, dice2, dice2] = dices, :full_house), do: Enum.sum(dices)
  defp do_score([dice, dice, dice, dice, _], :four_of_a_kind), do: dice * 4
  defp do_score([_, dice, dice, dice, dice], :four_of_a_kind), do: dice * 4
  defp do_score([1, 2, 3, 4, 5], :little_straight), do: 30
  defp do_score([2, 3, 4, 5, 6], :big_straight), do: 30
  defp do_score(dices, :choice), do: Enum.sum(dices)
  defp do_score([dice, dice, dice, dice, dice], :yacht), do: 50
  defp do_score(_, _), do: 0

  @spec trivial_score(dices :: [integer], number :: integer) :: integer
  defp trivial_score(dices, number), do: Enum.count(dices, &(&1 == number)) |> Kernel.*(number)
end
