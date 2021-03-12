defmodule EventsWeb.Helpers do
  def isSignedIn?(conn) do
    conn.assigns[:current_user] != nil
  end

  def isPoster?(conn, user_id) do
    user = conn.assigns[:current_user]
    user && user.id == user_id
  end
  
  def getUID(conn) do
    user = conn.assigns[:current_user]
    user && user.id
  end
  
  def getStatus(conn) do
    post = conn.assigns[:post]
    invitations = post.invitations
    yes = Enum.count(invitations, fn x -> x.status == "Yes" end)
    maybe = Enum.count(invitations, fn x -> x.status == "Maybe" end)
    no = Enum.count(invitations, fn x -> x.status == "No" end)
    pending = Enum.count(invitations, fn x -> x.status == "Pending" end)
    "Yes: " <> to_string(yes) <> " | Maybe: " <> to_string(maybe) <> " | No: " <> to_string(no) <> " | Pending: " <> to_string(pending)
  end
  
  def isInvited?(conn, post) do
    invitations = post.invitations
    email = conn.assigns[:current_user].email
    result =  Enum.count(invitations, fn x -> x.email == email end)
    if result > 0 do
      true
    end
  end 
end
