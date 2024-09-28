defmodule CreateRandomData do
  def main do
    Code.require_file("experiments.ex", __DIR__ <> "/../experiments/lib")
    Experiments.generate_csvs(3)
  end
end

CreateRandomData.main()
