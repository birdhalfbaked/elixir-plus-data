defmodule Experiments.MixProject do
  use Mix.Project

  def project do
    [
      app: :experiments,
      # only cowards start with 0.x.x
      version: "1.0.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:jason, "~> 1.4"}, {:uuid, "~> 1.1"}]
  end
end
