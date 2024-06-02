defmodule ResistorColorDuo do
  @color_codes [
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  ]

  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    for color <- colors |> Enum.take(2), Keyword.has_key?(@color_codes, color) do
      @color_codes[color]
    end
    |> Enum.join()
    |> String.to_integer()
  end
end
