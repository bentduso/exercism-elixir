defmodule SecretHandshake do
  @actions [
    {0b00001, "wink"},
    {0b00010, "double blink"},
    {0b00100, "close your eyes"},
    {0b01000, "jump"},
    {0b10000, :reverse}
  ]

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when code not in 1..31, do: []

  def commands(code) do
    @actions
    |> Enum.reduce([], fn {binary, action}, acc ->
      if Bitwise.band(code, binary) > 0 do
        case action do
          :reverse ->
            Enum.reverse(acc)

          _ ->
            [action | acc]
        end
      else
        acc
      end
    end)
    |> Enum.reverse()
  end
end
