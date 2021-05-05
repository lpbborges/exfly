defmodule Exfly.Bookings.Booking do
  @keys [:user_id, :complete_date, :origin_city, :destination_city]

  @enforce_keys @keys

  defstruct @keys

  def build(user_id, complete_date, origin_city, destination_city) do
    {:ok,
     %__MODULE__{
       user_id: user_id,
       complete_date: save_date_time(complete_date),
       origin_city: origin_city,
       destination_city: destination_city
     }}
  end

  defp save_date_time(%{date: date, time: time}) do
    {:ok, complete_date_time} = NaiveDateTime.new(date, time)

    complete_date_time
  end
end
