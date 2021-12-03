defmodule Sayuri do
  require Logger
  use Application

  @impl true
  def start(_type, _args) do
    childrens = [Sayuri.Consumer]
    options = [strategy: :one_for_one, name: :sayuri]
    Supervisor.start_link(childrens, options)
  end
end
