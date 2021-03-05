# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Events.Repo.insert!(%Events.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Events.Repo
alias Events.Users.User
alias Events.Posts.Post

alice = Repo.insert!(%User{name: "Alice", email: "alice@gmail.com"})
bob = Repo.insert!(%User{name: "Bob", email: "bob@gmail.com"})

Repo.insert!(%Post{user_id: alice.id, title: "Alice's Party", date: ~N[2000-01-01 23:00:07], description: "Please come."})
Repo.insert!(%Post{user_id: bob.id, title: "Bob's BBQ", date: ~N[2000-01-01 23:00:07], description: "I cook a mean steak."})
