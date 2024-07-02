defmodule ResistorColorTrio do
  @color_codes %{
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
  }

  @units [
    gigaohms: 1_000_000_000,
    megaohms: 1_000_000,
    kiloohms: 1_000,
    ohms: 1
  ]

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) when is_list(colors) do
    [first_color, second_color, multiplier_color] = Enum.take(colors, 3)

    value =
      [first_color, second_color]
      |> Enum.map(&Map.get(@color_codes, &1))
      |> Enum.join()
      |> String.to_integer()

    multiplier = Integer.pow(10, Map.get(@color_codes, multiplier_color))

    convert_to_units(value * multiplier)
  end

  @spec convert_to_units(resistance :: integer()) ::
          {number :: integer(), :ohms | :kiloohms | :megaohms | :gigaohms}
  defp convert_to_units(0), do: {0, :ohms}

  defp convert_to_units(resistance) do
    {unit_name, unit_value} =
      Enum.find(@units, {:ohms, 1}, fn {_, value} -> resistance >= value end)

    {resistance / unit_value, unit_name}
  end
end
