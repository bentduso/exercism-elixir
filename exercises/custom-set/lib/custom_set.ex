defmodule CustomSet do
  @opaque t :: %__MODULE__{map: list}

  defstruct map: []

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    map =
      enumerable
      |> Enum.uniq()
      |> Enum.sort()

    %__MODULE__{map: map}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set), do: Enum.empty?(custom_set.map)

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element), do: Enum.member?(custom_set.map, element)

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    Enum.all?(custom_set_1.map, &contains?(custom_set_2, &1))
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    Enum.all?(custom_set_1.map, &(!contains?(custom_set_2, &1)))
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    subset?(custom_set_1, custom_set_2) and subset?(custom_set_2, custom_set_1)
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    custom_set.map
    |> Enum.concat([element])
    |> new()
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Enum.filter(&contains?(custom_set_2, &1))
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Enum.filter(&(!contains?(custom_set_2, &1)))
    |> new()
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Enum.concat(custom_set_2.map)
    |> new()
  end
end
