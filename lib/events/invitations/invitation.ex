defmodule Events.Invitations.Invitation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invitations" do
    field :email, :string
    field :status, :string
    belongs_to :post, Events.Posts.Post
    belongs_to :user, Events.Users.User
    timestamps()
  end

  @doc false
  def changeset(invitation, attrs) do
    invitation
    |> cast(attrs, [:email, :status, :post_id, :user_id])
    |> validate_required([:email, :status, :post_id])
  end
end
