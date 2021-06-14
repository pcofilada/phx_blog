defmodule PhxBlog.Repo.Migrations.CreateCommentReactions do
  use Ecto.Migration

  def change do
    create table(:comment_reactions) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :comment_id, references(:comments, on_delete: :delete_all)

      timestamps()
    end

    create index(:comment_reactions, [:user_id])
    create index(:comment_reactions, [:comment_id])
  end
end
