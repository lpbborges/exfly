defmodule Exfly.Users.AgentTest do
  use ExUnit.Case

  import Exfly.Factory

  alias Exfly.Users.Agent, as: UserAgent
  alias Exfly.Users.User

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert {:ok, _id} = UserAgent.save(user)
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when the user is found, returns the user" do
      user = build(:user)

      {:ok, id} = UserAgent.save(user)

      response = UserAgent.get(id)

      expected_response = {:ok, user}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
