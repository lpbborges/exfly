defmodule Exfly.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exfly.Users.Agent, as: UserAgent
  alias Exfly.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{
        name: "John Doe",
        email: "johndoe@test.com",
        cpf: "98765432100"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "John Doe Jr",
        email: "johndoejr@test.com",
        cpf: 98
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
