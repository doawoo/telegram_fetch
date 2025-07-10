defmodule TelegramFetch.MixProject do
  use Mix.Project

  def project do
    [
      app: :telegram_fetch,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.14"},
      {:floki, "~> 0.38.0"},
      {:typed_struct, "~> 0.3.0"}
    ]
  end
end
