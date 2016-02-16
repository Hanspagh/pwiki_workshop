defmodule Pwiki.PageController do
  use Pwiki.Web, :controller

  @input "web/articles/"

  def index(conn, _params) do
    render conn, "index.html"
  end

  def random(conn, _params) do
    {:ok, articles} = File.ls(@input)
    article = articles |> Enum.random
    redirect conn, to: article_path(conn, :show , article |> String.replace(".md",""))
  end
end
