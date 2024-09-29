defmodule CreateRandomData do
  def main do
    Experiments.generate_csvs_from_schema(3, "./data/example.schema.json")
  end
end

CreateRandomData.main()
