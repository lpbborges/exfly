defmodule Exfly.Bookings.BookingTest do
  use ExUnit.Case

  import Exfly.Factory

  alias Exfly.Bookings.Booking
  alias Exfly.Users.Agent, as: UserAgent
  alias Exfly.Users.User

  describe "build/4" do
    test "when all params are valid, returns the booking" do
      UserAgent.start_link(%{})

      user = build(:user)

      {:ok, user_id} = UserAgent.save(user)

      response =
        Booking.build(
          user_id,
          %{date: ~D[2010-01-13], time: ~T[23:00:07.005]},
          "New York City",
          "Chicago"
        )

      expected_response = {:ok, build(:booking, user_id: user_id)}

      assert response == expected_response
    end
  end
end
