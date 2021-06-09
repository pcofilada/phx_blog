defmodule PhxBlog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhxBlog.Accounts.User
  alias PhxBlog.Blog.Comment

  @derive {Phoenix.Param, key: :slug}
  schema "posts" do
    field :body, :string
    field :slug, :string
    field :title, :string

    belongs_to :user, User

    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    attrs = Map.merge(attrs, generate_slug(attrs))

    post
    |> cast(attrs, [:title, :body, :slug, :user_id])
    |> validate_title()
    |> validate_body()
    |> validate_required([:user_id])
    |> unique_constraint(:slug)
  end

  defp validate_title(changeset) do
    changeset
    |> validate_required([:title], message: "Title can't be blank")
  end

  defp validate_body(changeset) do
    changeset
    |> validate_required([:body], message: "Body can't be blank")
  end

  defp generate_slug(%{ "title" => title }) do
    slug = String.downcase(title) |> String.replace(" ", "-")
    %{"slug" => slug}
  end

  defp generate_slug(_params) do
    %{}
  end
end
