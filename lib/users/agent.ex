defmodule Exfly.Users.Agent do
  alias Exfly.Users.User

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    id = UUID.uuid4()

    Agent.update(__MODULE__, &update_state(&1, user, id))

    {:ok, id}
  end

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{} = user, id), do: Map.put(state, id, user)
end
