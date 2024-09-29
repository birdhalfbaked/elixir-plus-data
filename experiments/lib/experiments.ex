defmodule Experiments do
  @moduledoc """
  Contains Some functions for helping do
    what I want
  """

  @asciiLetters ~c"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .!?"

  defp get_random_value(typeInfo) do
    case elem(typeInfo, 1) do
      "string" ->
        if elem(typeInfo, 2) == "uuid" do
          UUID.uuid4()
        else
          Stream.repeatedly(fn -> Enum.random(@asciiLetters) end)
          |> Enum.take(:rand.uniform(100))
          |> List.to_string()
        end

      "number" ->
        :rand.uniform() * 10000

      "integer" ->
        :rand.uniform(10000)

      "boolean" ->
        :rand.uniform() > 0.5
    end
  end

  defp create_csv_file(filename) do
    {:ok, file} = File.open(filename, [:write])
    File.close(file)
  end

  defp create_csv_file_with_data(filename, schemaData) do
    file = File.open!(filename, [:write])

    typeInfo =
      Map.to_list(schemaData)
      |> Enum.map(fn info ->
        {
          elem(info, 0),
          Map.get(elem(info, 1), "type"),
          Map.get(elem(info, 1), "format")
        }
      end)

    columnHeader = Enum.map(typeInfo, fn info -> elem(info, 0) end) |> Enum.join(",")
    IO.binwrite(file, columnHeader <> "\n")

    data =
      Stream.repeatedly(fn -> Enum.map(typeInfo, &get_random_value/1) |> Enum.join(",") end)
      |> Enum.take(1000)
      |> Enum.join("\n")

    IO.binwrite(file, data)

    File.close(file)
  end

  @doc """
  Creates test CSV files
  """
  def generate_csvs(num) when num > 0 do
    filenames = Enum.map(0..(num - 1), fn n -> "./data/generated/data_#{n}.csv" end)
    filenames |> Enum.each(&create_csv_file/1)
  end

  def generate_csvs_from_schema(num, schemaPath) do
    schemaData =
      File.read!(schemaPath)
      |> Jason.decode!([])
      |> Map.get("properties")

    # generate range of filenames and then create data
    Enum.map(0..(num - 1), fn n -> "./data/generated/data_#{n}.csv" end)
    |> Enum.each(fn filename -> create_csv_file_with_data(filename, schemaData) end)
  end
end
