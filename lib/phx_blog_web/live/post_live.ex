defmodule PhxBlogWeb.PostLive do
  use PhxBlogWeb, :live_view

  alias PhxBlog.Accounts
  alias PhxBlog.Blog
  alias PhxBlog.Blog.Post
  alias PhxBlog.Blog.Comment

  def mount(%{"id" => id}, session, socket) do
    Blog.subscribe()
    post = Blog.get_post!(id)
    user = if session["user_token"], do: Accounts.get_user_by_session_token(session["user_token"]), else: nil

    {:ok, assign(socket, post: post, user: user)}
  end

  def handle_event("comment", %{"comment" => comment}, socket) do
    comment_params = Map.merge(comment, %{"user_id" => socket.assigns.user.id, "post_id" => socket.assigns.post.id})
    Blog.create_comment(comment_params)

    {:noreply, fetch(socket)}
  end

  def truncate(text) do
    "#{text |> String.slice(0, 200) |> String.trim_trailing}..."
  end

  def format_date(date) do
    {:ok, formatted_date} = Timex.format(date, "%b %d '%y", :strftime)
    formatted_date
  end

  def author_name(user) do
    "#{user.first_name} #{user.last_name}"
  end

  defp fetch(socket) do
    assign(socket, post: post = Blog.get_post!(socket.assigns.post.slug))
  end
end
