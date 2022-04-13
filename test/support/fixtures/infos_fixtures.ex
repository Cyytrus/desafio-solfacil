defmodule TecSolFacil.InfosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TecSolFacil.Infos` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        bairro: "some bairro",
        cep: "some cep",
        ddd: "some ddd",
        ibge: "some ibge",
        localidade: "some localidade",
        logradouro: "some logradouro",
        uf: "some uf"
      })
      |> TecSolFacil.Infos.create_address()

    address
  end
end
