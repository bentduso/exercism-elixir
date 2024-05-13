defmodule Darts do
  @outside_of_target 0
  @outer_target 1
  @middle_target 5
  @inner_target 10

  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    center_distance = :math.sqrt(:math.pow(x, 2) + :math.pow(y, 2))

    cond do
      center_distance <= 1 -> @inner_target
      center_distance <= 5 -> @middle_target
      center_distance <= 10 -> @outer_target
      true -> @outside_of_target
    end
  end
end
