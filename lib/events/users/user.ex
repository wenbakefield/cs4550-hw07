defmodule Events.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :bio, :string
    field :photo_hash, :string
    has_many :posts, Events.Posts.Post
    has_many :comments, Events.Comments.Comment
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :bio, :photo_hash])
    |> validate_required([:name, :email])
  end
end
