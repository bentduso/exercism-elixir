defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, &Map.get(&1, :price))

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(Map.get(&1, :price) == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      Map.update!(item, :name, &String.replace(&1, old_word, new_word))
    end)
  end

  def increase_quantity(item, count) do
    updated_quantities =
      item[:quantity_by_size]
      |> Map.new(fn {key, value} -> {key, value + count} end)

    Map.put(item, :quantity_by_size, updated_quantities)
  end

  def total_quantity(item) do
    item[:quantity_by_size]
    |> Map.values()
    |> Enum.reduce(0, &+/2)
  end
end
