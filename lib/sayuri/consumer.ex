defmodule Sayuri.Consumer do
  require Logger
  alias Nosedrum.Invoker.Split, as: CommandHandle
  alias Nosedrum.Storage.ETS, as: CommandStorage
  alias Sayuri.Commands
  use Nostrum.Consumer

  @commands %{
    "ed" => Commands.Ed
  }

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:READY, _data, _ws_state}) do
    Enum.each(@commands, fn {nome, cmd} -> CommandStorage.add_command([nome], cmd) end)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    CommandHandle.handle_message(msg, CommandStorage)
  end

  def handle_event({event, _content, _ws}) do
    Logger.log(:warning, "Evento não tratado: #{Atom.to_string(event)}")
  end
end
