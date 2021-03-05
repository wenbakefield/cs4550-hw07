defmodule Events.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :date, :naive_datetime, null: false
      add :description, :string, null: false
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end
