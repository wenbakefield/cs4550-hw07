defmodule EventsWeb.UserController do
  use EventsWeb, :controller

  alias Events.Users
  alias Events.Users.User
  alias Events.Photos
  alias EventsWeb.SessionController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    pp = user_params["photo"]
    user_params = 
      if pp do 
        {:ok, hash} = Photos.save_photo(pp.filename, pp.path)
        Map.put(user_params, "photo_hash", hash)
      else
        user_params
      end
    if Users.get_user_from_email(user_params["email"]) do 
      conn
      |> put_flash(:error, "User already registered!")
      |> redirect(to: Routes.user_path(conn, :new))
      |> halt()
    else
      case Users.create_user(user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          SessionController.create(conn, %{"email" => user.email})

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)
    pp = user_params["photo"]
    user_params = 
      if pp do
        {:ok, hash} = Photos.save_photo(pp.filename, pp.path)
        Map.put(user_params, "photo_hash", hash)
      else
        user_params
      end

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
  
  def photo(conn, %{"id" => id}) do
  	user = Users.get_user!(id)
  	{:ok, _name, data} = Photos.load_photo(user.photo_hash)
  	conn
  	|> put_resp_content_type("image/jpeg")
  	|> send_resp(200, data)
  end
end
