defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand, strand), do: {:ok, 0}

  def hamming_distance(strand1, strand2) when length(strand1) == length(strand2) do
    {:ok, count_differences(strand1, strand2)}
  end

  def hamming_distance(_, _), do: {:error, "strands must be of equal length"}

  defp count_differences([], []), do: 0

  defp count_differences([nucleotide | tail1], [nucleotide | tail2]) do
    0 + count_differences(tail1, tail2)
  end

  defp count_differences([_ | tail1], [_ | tail2]), do: 1 + count_differences(tail1, tail2)
end
