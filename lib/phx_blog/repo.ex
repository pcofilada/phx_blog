defmodule PhxBlog.Repo do
  use Ecto.Repo,
    otp_app: :phx_blog,
    adapter: Ecto.Adapters.MyXQL
end
