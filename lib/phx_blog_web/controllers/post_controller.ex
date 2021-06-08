defmodule PhxBlogWeb.PostController do
  use PhxBlogWeb, :controller

  alias PhxBlog.Blog
  alias PhxBlog.Blog.Post

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.html", post: post)
  end
end
