defmodule Exfly.Factory do
  use ExMachina

  alias Exfly.Bookings.Booking
  alias Exfly.Users.User

  def user_factory do
    %User{
      name: "John Doe",
      email: "johndoe@test.com",
      cpf: "12345678900"
    }
  end

  def booking_factory do
    {:ok, complete_date_time} = NaiveDateTime.new(~D[2010-01-13], ~T[23:00:07.005])

    %Booking{
      user_id: UUID.uuid4(),
      complete_date: complete_date_time,
      origin_city: "New York City",
      destination_city: "Chicago"
    }
  end
end
