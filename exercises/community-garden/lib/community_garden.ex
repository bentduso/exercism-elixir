# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []), do: Agent.start(fn -> %{registry: %{}, next_id: 1} end, opts)

  def list_registrations(pid) do
    Agent.get(pid, fn %{registry: registry} -> Map.values(registry) end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{registry: registry, next_id: next_id} = state ->
      new_plot = %Plot{plot_id: next_id, registered_to: register_to}
      updated_registry = Map.put(registry, next_id, new_plot)
      {new_plot, %{state | registry: updated_registry, next_id: next_id + 1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn %{registry: registry} = state ->
      updated_registry = Map.delete(registry, plot_id)
      %{state | registry: updated_registry}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{registry: registry} ->
      case Map.get(registry, plot_id) do
        nil -> {:not_found, "plot is unregistered"}
        plot -> plot
      end
    end)
  end
end
