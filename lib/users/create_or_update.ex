defmodule Exfly.Users.CreateOrUpdate do
  alias Exfly.Users.Agent, as: UserAgent
  alias Exfly.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    name
    |> User.build(email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, "User created or updated successfully"}
  end

  defp save_user({:error, _reasons} = error), do: error
end
