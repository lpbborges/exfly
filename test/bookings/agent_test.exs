defmodule Exfly.Bookings.AgentTest do
  use ExUnit.Case

  import Exfly.Factory

  alias Exfly.Bookings.Agent, as: BookingAgent
  alias Exfly.Bookings.Booking
  alias Exfly.Users.Agent, as: UserAgent

  describe "save/1" do
    setup do
      Exfly.start_agents()

      :ok
    end

    test "saves the booking when user exists" do
      user = build(:user)

      {:ok, user_id} = UserAgent.save(user)

      booking = build(:booking, user_id: user_id)

      assert {:ok, _id} = BookingAgent.save(booking)
    end

    test "when user not exists, returns an error" do
      booking = build(:booking)

      response = BookingAgent.save(booking)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      BookingAgent.start_link(%{})

      :ok
    end

    # test "when the user is found, returns the user" do
    #   user = build(:user)

    #   {:ok, id} = BookingAgent.save(user)

    #   response = BookingAgent.get(id)

    #   expected_response = {:ok, user}

    #   assert response == expected_response
    # end

    # test "when the user is not found, returns an error" do
    #   response = BookingAgent.get("00000000000")

    #   expected_response = {:error, "Booking not found"}

    #   assert response == expected_response
    # end
  end
end
