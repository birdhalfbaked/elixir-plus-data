defmodule CreateRandomData do
  def spawn_processes(processAccumulator, remaining) when remaining > 0 do
    parent = self()

    processAccumulator
    |> List.insert_at(
      0,
      spawn(fn ->
        Experiments.async_generate_csvs_from_schema(
          parent,
          remaining,
          "./data/example.schema.json"
        )
      end)
    )
    |> spawn_processes(remaining - 1)
  end

  def spawn_processes(processAccumulator, _) do
    processAccumulator
  end

  def main do
    spawn_processes([], 5)
    |> Enum.each(fn _ ->
      receive do
        {:ok, msg} ->
          IO.puts(msg <> " finished")
      after
        1_000 ->
          IO.puts("timeout")
      end
    end)
  end
end

CreateRandomData.main()
