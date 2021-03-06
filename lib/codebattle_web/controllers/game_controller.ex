defmodule CodebattleWeb.GameController do
  use Codebattle.Web, :controller

  def index(conn, _params) do
    games = Codebattle.Repo.all(CodebattleWeb.Game)
    render(conn, "index.html", games: games)
  end

  def create(conn, %{}) do
    game = Codebattle.Repo.insert!(%CodebattleWeb.Game{})
    Game.Supervisor.start_game(game)
    conn
    |> put_flash(:info, "Игра создана")
    |> redirect(to: game_path(conn, :index))
  end
end
