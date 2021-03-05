defmodule Events.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :date, :naive_datetime
    field :description, :string
    field :title, :string
    
    belongs_to :user, Events.Users.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :date, :description, :user_id])
    |> validate_required([:title, :date, :user_id])
  end
end
