defmodule PhxBlogWeb.PostView do
  use PhxBlogWeb, :view

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
end
