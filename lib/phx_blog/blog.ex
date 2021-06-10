defmodule PhxBlog.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias PhxBlog.Repo

  alias PhxBlog.Blog.Post

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(PhxBlog.PubSub, @topic)
  end

  @doc """
  Returns the list of created posts by a user.

  ## Examples

      iex> user_posts()
      [%Post{}, ...]

  """
  def user_posts(user_id) do
    Post
    |> where(user_id: ^user_id)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
    |> Repo.preload([:user, :comments])
  end

  @doc """
  Gets a single post for a user.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!("hello-world")
      %Post{}

      iex> get_post!("error")
      ** (Ecto.NoResultsError)
  """
  def get_user_post!(user_id, slug) do
    Post
    |> Repo.get_by!(user_id: user_id, slug: slug)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Post
    |> order_by(desc: :inserted_at)
    |> Repo.all()
    |> Repo.preload([:user, :comments])
  end

@doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(slug) do
    Post
    |> Repo.get_by!(slug: slug)
    |> Repo.preload([:user])
    |> Repo.preload([comments: :user])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  alias PhxBlog.Blog.Comment

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
    |> broadcast_change([:comment, :created])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(PhxBlog.PubSub, @topic, {__MODULE__, event, result})

    {:ok, result}
  end
end
