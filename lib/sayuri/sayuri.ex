defmodule Sayuri do
  use Application

  @impl true
  def start(_type, _args) do
    childrens = [
      {Task.Supervisor, name: Sayuri.TaskSupervisor},
      Sayuri.Modules.HandleForms,
      Sayuri.Modules.HandleFormsEts,
      Sayuri.Modules.Consumer,
      {Nosedrum.Interactor.Dispatcher, name: Nosedrum.Interactor.Dispatcher}
    ]

    options = [strategy: :one_for_all, name: Sayuri.Supervisor]
    Supervisor.start_link(childrens, options)
  end
end
