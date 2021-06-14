defmodule PhxBlog.Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhxBlog.Accounts.User
  alias PhxBlog.Blog.Post
  alias PhxBlog.Blog.CommentReaction

  schema "comments" do
    field :content, :string

    belongs_to :user, User
    belongs_to :post, Post

    has_many :comment_reactions, CommentReaction

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :user_id, :post_id])
    |> validate_required([:content], message: "Content can't be blank")
  end
end
