defmodule Sayuri.MixProject do
  use Mix.Project

  def project do
    [
      app: :sayuri,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {
        Sayuri,
        []
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nostrum, "~> 0.4"},
      {:nosedrum, "~> 0.4"}
    ]
  end
end
