defmodule Sayuri.Commands.Ed do
  @behaviour Nosedrum.Command

  alias Nostrum.Api

  @impl true
  def usage, do: ["ed [-GVhs] [-p string] [file]"]

  @impl true
  def description, do: "Ed é apenas um teste"

  @impl true
  def predicates, do: []

  @impl true
  def command(msg, _args), do: Api.create_message!(msg.channel_id, "?")
end
