defmodule PhxBlogWeb.PostController do
  use PhxBlogWeb, :controller

  alias PhxBlog.Blog
  alias PhxBlog.Blog.Post
  alias PhxBlog.Blog.Comment

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    comment_changeset = Blog.change_comment(%Comment{})
    render(conn, "show.html", post: post, comment_changeset: comment_changeset)
  end
end
