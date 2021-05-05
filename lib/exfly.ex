defmodule Exfly do
  alias Exfly.Bookings.Agent, as: BookingAgent
  alias Exfly.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias Exfly.Users.Agent, as: UserAgent
  alias Exfly.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate create_or_update_booking(params), to: CreateOrUpdateBooking, as: :call
end
