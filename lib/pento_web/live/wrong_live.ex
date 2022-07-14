defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}
  # alias Pento.Accounts

  def mount(_params, session, socket) do
    {:ok,
     assign(
       socket,
       score: 0,
       wins: 0,
       select: :rand.uniform(10),
       message: "Make a guess! 😜",
       repl: "",
       time: time(),
       win_class: "text-3xl",
       win: false,
       session_id: session["live_socket_id"]
     )}
  end

  def render(assigns) do
    Phoenix.View.render(PentoWeb.LiveView, "wrong_live.html", assigns)
  end

  def time() do
    DateTime.utc_now() |> Timex.format!("%D %r", :strftime)
  end

  def handle_event("guess", %{"number" => guess} = _data, socket) do
    # {score, text_msg, style, win, total wins}
    msg =
      case String.to_integer(guess) == socket.assigns.select do
        true ->
          {1, "is Right, congrats!", "text-3xl", true, socket.assigns.wins + 1}

        _ ->
          {-0.5, "Wrong. Guess again.", "text-3xl", false, socket.assigns.wins}
      end

    score = socket.assigns.score + elem(msg, 0)
    message = "Your guess: #{guess}"
    repl = "<span class=\"text-lg font-baloo-400\">#{elem(msg, 1)}</span>"

    {
      :noreply,
      assign(
        socket,
        message: message,
        repl: repl,
        score: score,
        time: time(),
        win_class: elem(msg, 2),
        win: elem(msg, 3),
        wins: elem(msg, 4)
      )
    }
  end

  def handle_params(params, _uri, socket) do
    case params["win"] do
      # win is a true
      "true" ->
        {
          :noreply,
          assign(
            socket,
            select: :rand.uniform(10),
            message: "Make a guess! 😜",
            repl: "",
            time: time(),
            win_class: "text-3xl",
            win: false
          )
        }

      _ ->
        {:noreply, socket}
    end
  end
end
