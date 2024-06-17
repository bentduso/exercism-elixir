defmodule RotationalCipher do
  @lowercase_latin ?a..?z
  @uppercase_latin ?A..?Z

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&shift_character(&1, shift))
    |> to_string
  end

  @spec shift_character(char :: integer, shift :: integer) :: integer
  defp shift_character(char, shift) when char in @lowercase_latin do
    rem(char - ?a + shift, 26) + ?a
  end

  defp shift_character(char, shift) when char in @uppercase_latin do
    rem(char - ?A + shift, 26) + ?A
  end

  defp shift_character(char, _), do: char
end
