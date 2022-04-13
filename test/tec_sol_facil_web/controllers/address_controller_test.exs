defmodule TecSolFacilWeb.AddressControllerTest do
  use TecSolFacilWeb.ConnCase

  import TecSolFacil.InfosFixtures

  alias TecSolFacil.Infos.Address

  @create_attrs %{
    bairro: "some bairro",
    cep: "some cep",
    ddd: "some ddd",
    ibge: "some ibge",
    localidade: "some localidade",
    logradouro: "some logradouro",
    uf: "some uf"
  }
  @update_attrs %{
    bairro: "some updated bairro",
    cep: "some updated cep",
    ddd: "some updated ddd",
    ibge: "some updated ibge",
    localidade: "some updated localidade",
    logradouro: "some updated logradouro",
    uf: "some updated uf"
  }
  @invalid_attrs %{
    bairro: nil,
    cep: nil,
    ddd: nil,
    ibge: nil,
    localidade: nil,
    logradouro: nil,
    uf: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all addresses", %{conn: conn} do
      conn = get(conn, Routes.address_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create address" do
    test "renders address when data is valid", %{conn: conn} do
      conn = post(conn, Routes.address_path(conn, :create), address: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.address_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "bairro" => "some bairro",
               "cep" => "some cep",
               "ddd" => "some ddd",
               "ibge" => "some ibge",
               "localidade" => "some localidade",
               "logradouro" => "some logradouro",
               "uf" => "some uf"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.address_path(conn, :create), address: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update address" do
    setup [:create_address]

    test "renders address when data is valid", %{conn: conn, address: %Address{id: id} = address} do
      conn = put(conn, Routes.address_path(conn, :update, address), address: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.address_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "bairro" => "some updated bairro",
               "cep" => "some updated cep",
               "ddd" => "some updated ddd",
               "ibge" => "some updated ibge",
               "localidade" => "some updated localidade",
               "logradouro" => "some updated logradouro",
               "uf" => "some updated uf"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, address: address} do
      conn = put(conn, Routes.address_path(conn, :update, address), address: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete address" do
    setup [:create_address]

    test "deletes chosen address", %{conn: conn, address: address} do
      conn = delete(conn, Routes.address_path(conn, :delete, address))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.address_path(conn, :show, address))
      end
    end
  end

  defp create_address(_) do
    address = address_fixture()
    %{address: address}
  end
end
