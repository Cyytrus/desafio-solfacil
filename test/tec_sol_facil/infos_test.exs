defmodule TecSolFacil.InfosTest do
  use TecSolFacil.DataCase

  alias TecSolFacil.Infos

  describe "addresses" do
    alias TecSolFacil.Infos.Address

    import TecSolFacil.InfosFixtures

    @invalid_attrs %{
      bairro: nil,
      cep: nil,
      ddd: nil,
      ibge: nil,
      localidade: nil,
      logradouro: nil,
      uf: nil
    }
  end
end
