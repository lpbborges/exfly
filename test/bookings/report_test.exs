defmodule Exlivery.Bookings.ReportTest do
  use ExUnit.Case

  import Exfly.Factory

  alias Exfly.Bookings.Agent, as: BookingAgent
  alias Exfly.Bookings.Report
  alias Exfly.Users.Agent, as: UserAgent

  describe "create/1" do
    test "creates the report file" do
      Exfly.start_agents()

      user = build(:user)

      {:ok, user_id} = UserAgent.save(user)

      booking = build(:booking, user_id: user_id)

      BookingAgent.save(booking)

      BookingAgent.save(booking)

      expected_response =
        "#{user_id},New York City,Chicago,2010-01-13 23:00:07.005\n" <>
          "#{user_id},New York City,Chicago,2010-01-13 23:00:07.005\n"

      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      assert response == expected_response
    end
  end
end
