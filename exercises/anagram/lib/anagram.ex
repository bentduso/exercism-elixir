defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &anagram?(String.downcase(base), String.downcase(&1)))
  end

  @spec anagram?(String.t(), String.t()) :: boolean()
  defp anagram?(base, base), do: false

  defp anagram?(base, candidate) do
    normalize_and_sort(base) == normalize_and_sort(candidate)
  end

  @spec normalize_and_sort(String.t()) :: [String.t()]
  defp normalize_and_sort(string) do
    string
    |> String.graphemes()
    |> Enum.sort()
  end
end
