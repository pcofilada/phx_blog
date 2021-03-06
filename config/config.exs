# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phx_blog,
  ecto_repos: [PhxBlog.Repo]

# Configures the endpoint
config :phx_blog, PhxBlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QpKFZjSUh7rd3803zqF3EvrOBIYhxe4oRpsD3zdv+lpTyzyw7MSzNGoPJyeE0Wxw",
  render_errors: [view: PhxBlogWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhxBlog.PubSub,
  live_view: [signing_salt: "zPBlLX99"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
