defmodule TecSolFacilWeb.Oban.Exporters.CsvExporter do
  use Oban.Worker, queue: :events, unique: [period: 60]

  alias TecSolFacil.Infos

  @info_fields ~w[bairro cep ddd ibge localidade logradouro uf]a

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{}}) do
    fields = [:logradouro, :cep, :bairro, :localidade, :uf, :ibge, :ddd]
    records = Infos.list_addresses()

    print_file = csv_content(records, fields)

    {:ok, file} = File.open("exports.csv", [:write])
    IO.binwrite(file, print_file)
    File.close(file)
  end

  defp csv_content(records, fields) do
    records
    |> Enum.map(fn record ->
      record
      |> Map.from_struct()
      # gives an empty map
      |> Map.take([])
      |> Map.merge(Map.take(record, fields))
      |> Map.values()
    end)
    |> then(fn x -> [@info_fields | x] end)
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end
end
