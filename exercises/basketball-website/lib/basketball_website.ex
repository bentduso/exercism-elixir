defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    traverse(data, keys)
  end

  defp traverse(data, []), do: data

  defp traverse(%{} = data, [key | tail]) when is_map_key(data, key),
    do: traverse(data[key], tail)

  defp traverse(_, _), do: nil

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
