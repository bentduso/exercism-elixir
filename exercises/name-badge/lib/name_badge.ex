defmodule NameBadge do
  @owner_label "OWNER"

  def print(id, name, nil), do: print(id, name, @owner_label)

  def print(id, name, department) do
    if id == nil do
      "#{name} - #{String.upcase(department)}"
    else
      "[#{id}] - #{name} - #{String.upcase(department)}"
    end
  end
end
