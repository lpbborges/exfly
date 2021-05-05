defmodule Exfly.Bookings.CreateOrUpdate do
  alias Exfly.Bookings.Agent, as: BookingAgent
  alias Exfly.Bookings.Booking

  def call(%{
        user_id: user_id,
        complete_date: complete_date,
        origin_city: origin_city,
        destination_city: destination_city
      }) do
    user_id
    |> Booking.build(complete_date, origin_city, destination_city)
    |> save_booking()
  end

  defp save_booking({:ok, %Booking{} = booking}) do
    BookingAgent.save(booking)

    {:ok, "Booking created or updated successfully"}
  end

  defp save_booking({:error, _reasons} = error), do: error
end
