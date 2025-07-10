# TelegramFetch

A simple Elixir library to help fetch account information from Telegram users by username.

### Usage:

```elixir
TelegramFetch.fetch_by_username("username_here")
```

```elixir
{:ok,
 %TelegramFetch.TelegramInfo{
   bio: "Account Bio Here",
   avatar: "https://telegram.org/img/t_logo_2x.png",
   display_name: "Display Name Here",
   username: "username_here"
 }}
```