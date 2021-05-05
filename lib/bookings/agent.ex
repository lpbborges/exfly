defmodule Exfly.Bookings.Agent do
  use Agent

  alias Exfly.Bookings.Booking
  alias Exfly.Users.Agent, as: UserAgent

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  def get_all, do: Agent.get(__MODULE__, & &1)

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{user_id: user_id} = booking) do
    case UserAgent.get(user_id) do
      {:error, _reason} = error -> error
      {:ok, _user} -> create_booking(booking)
    end
  end

  defp create_booking(%Booking{} = booking) do
    id = UUID.uuid4()

    Agent.update(__MODULE__, &update_state(&1, booking, id))

    {:ok, id}
  end

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end

  defp update_state(state, %Booking{} = booking, id), do: Map.put(state, id, booking)
end
