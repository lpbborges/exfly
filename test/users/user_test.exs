defmodule Exfly.Users.UserTest do
  use ExUnit.Case

  alias Exfly.Users.User

  import Exfly.Factory

  describe "build/3" do
    test "when all params are valid, returns the user" do
      response = User.build("John Doe", "johndoe@test.com", "12345678900")

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      response = User.build("John Doe", "johndoe@test.com", 98)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
