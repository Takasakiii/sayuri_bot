defmodule Sayuri do
  use Application

  @impl true
  def start(_type, _args) do
    childrens = [
      {Sayuri.Consumer, name: Sayuri.Consumer},
      {Nosedrum.Interactor.Dispatcher, name: Nosedrum.Interactor.Dispatcher}
    ]

    options = [strategy: :rest_for_one, name: Sayuri.Supervisor]
    Supervisor.start_link(childrens, options)
  end
end
