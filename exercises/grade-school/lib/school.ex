defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new(), do: %{}

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    if Enum.any?(Map.values(school) |> List.flatten(), fn student -> student == name end) do
      {:error, school}
    else
      {:ok, Map.update(school, grade, [name], fn students -> [name | students] end)}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade), do: Map.get(school, grade, []) |> Enum.sort()

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Enum.sort_by(fn {grade, _} -> grade end)
    |> Enum.flat_map(fn {_, students} -> Enum.sort(students) end)
  end
end
