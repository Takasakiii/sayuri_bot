import Config

config :nostrum,
  token: System.get_env("BOT_TOKEN")

config :porcelain,
  driver: Porcelain.Driver.Basic

config :sayuri,
  prefix: "."
