defmodule PhxBlogWeb.CommentController do
  use PhxBlogWeb, :controller

  alias PhxBlog.Blog
  alias PhxBlog.Blog.Comment

  def create(conn, %{"id" => id, "comment" => comment_params}) do
    user_id = conn.assigns.current_user.id
    post = Blog.get_post!(id)

    comment_params = Map.merge(comment_params, %{"user_id" => user_id, "post_id" => post.id})

    case Blog.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Can't comment right now. Try again later.")
        |> redirect(to: Routes.post_path(conn, :show, post))
    end
  end
end
