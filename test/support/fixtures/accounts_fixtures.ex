defmodule TecSolFacil.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TecSolFacil.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some@email.com",
        password: "some password"
      })
      |> TecSolFacil.Accounts.create_user()

    user
  end
end
