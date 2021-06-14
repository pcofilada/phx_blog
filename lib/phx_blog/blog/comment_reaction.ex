defmodule PhxBlog.Blog.CommentReaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhxBlog.Accounts.User
  alias PhxBlog.Blog.Comment

  schema "comment_reactions" do
    belongs_to :user, User
    belongs_to :comment, Comment

    timestamps()
  end

  @doc false
  def changeset(commen_reaction, attrs) do
    commen_reaction
    |> cast(attrs, [:user_id, :comment_id])
    |> validate_required([:user_id, :comment_id])
  end
end
