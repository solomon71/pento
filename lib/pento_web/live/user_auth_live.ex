defmodule PentoWeb.Live.UserAuthLive do
  import Phoenix.LiveView

  alias Pento.Accounts
  alias PentoWeb.Router.Helpers, as: Routes

  def on_mount(_, params, %{"user_token" => user_token}, socket) do
    user = Accounts.get_user_by_session_token(user_token)

    # IO.inspect(user)
    # IO.inspect(params)

    socket =
      socket
      |> assign(:current_user, user)

    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: Routes.user_session_path(socket, :new))}
    end
  end

end
