defmodule Exfly.Bookings.Report do
  alias Exfly.Bookings.Agent, as: BookingAgent
  alias Exfly.Bookings.Booking

  def create(filename \\ "report.csv") do
    booking_list = build_booking_list()

    File.write(filename, booking_list)
  end

  defp build_booking_list() do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         user_id: user_id,
         origin_city: origin_city,
         destination_city: destination_city,
         complete_date: complete_date
       }) do
    string_date_time = NaiveDateTime.to_string(complete_date)
    "#{user_id},#{origin_city},#{destination_city},#{string_date_time}\n"
  end
end
