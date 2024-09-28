defmodule ExperimentsTest do
  use ExUnit.Case
  doctest Experiments

  test "greets the world" do
    assert Experiments.hello() == :world
  end
end
