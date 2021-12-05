defmodule Sayuri.Modules.Status do
  require Logger
  alias Nostrum.Api
  @status ["grande dia", "dia", "tarde", "noite"]

  def status_task(position \\ 0) do
    item = Enum.at(@status, position)
    Api.update_status(:online, item, 1)

    Process.sleep(10000)

    if position >= length(@status) do
      status_task(0)
    else
      status_task(position + 1)
    end
  end
end
