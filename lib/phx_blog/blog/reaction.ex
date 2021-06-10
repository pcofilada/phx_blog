defmodule PhxBlog.Blog.Reaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhxBlog.Accounts.User
  alias PhxBlog.Blog.Post

  schema "reactions" do
    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(reaction, attrs) do
    reaction
    |> cast(attrs, [:user_id, :post_id])
    |> validate_required([:user_id, :post_id])
  end
end
