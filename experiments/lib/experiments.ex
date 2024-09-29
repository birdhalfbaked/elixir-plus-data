defmodule Experiments do
  @moduledoc """
  Contains Some functions for helping do
    what I want
  """

  def create_csv_file(filename) do
    {:ok, file} = File.open(filename, [:write])
    File.close(file)
  end

  @doc """
  Creates test CSV files
  """
  def generate_csvs(num) when num > 0 do
    filenames = Enum.map(0..num, fn n -> "./data/generated/data_#{n}.csv" end)
    filenames |> Enum.each(&create_csv_file/1)
  end
end
