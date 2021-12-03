defmodule Sayuri.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    prefix = Application.fetch_env!(:sayuri, :prefix)
    msg_text = msg.content

    if String.starts_with?(msg_text, prefix) do
      msg_text = String.slice(msg_text, 1..String.length(msg_text))

      case msg_text do
        "shiba" -> Api.create_message!(msg.channel_id, "gay")
        "takasaki" -> Api.create_message!(msg.channel_id, "viado")
        _ -> :ignore
      end
    end
  end

  def handle_event({event, _content, _ws}) do
    IO.puts("Evento não tratado: #{Atom.to_string(event)}")
  end
end
