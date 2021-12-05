defmodule Sayuri do
  use Application

  @impl true
  def start(_type, _args) do
    childrens = [Nosedrum.Storage.ETS, Sayuri.Consumer]
    options = [strategy: :one_for_one, name: Sayuri.Supervisor]
    Supervisor.start_link(childrens, options)
  end
end
