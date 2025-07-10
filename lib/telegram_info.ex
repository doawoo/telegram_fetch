defmodule TelegramFetch.TelegramInfo do
  use TypedStruct

  typedstruct do
    field :username, String.t(), enforce: true
    field :display_name, String.t(), enforce: true
    field :avatar, String.t(), enforce: true
    field :bio, String.t(), enforce: true
  end
end
