defmodule Events.Repo.Migrations.CreateInvitations do
  use Ecto.Migration

  def change do
    create table(:invitations) do
      add :email, :string, null: false
      add :status, :string, null: true
      add :post_id, references(:posts, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: true
      timestamps()
    end
    create index(:invitations, [:post_id])
    create index(:invitations, [:user_id])
  end
end
