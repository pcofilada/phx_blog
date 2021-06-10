defmodule PhxBlog.Repo.Migrations.CreateReactions do
  use Ecto.Migration

  def change do
    create table(:reactions) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end

    create index(:reactions, [:user_id])
    create index(:reactions, [:post_id])
  end
end
