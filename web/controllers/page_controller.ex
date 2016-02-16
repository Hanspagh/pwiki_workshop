defmodule Pwiki.PageController do
  use Pwiki.Web, :controller

  @input "web/articles/"

  def index(conn, _params) do
    render conn, "index.html"
  end

  def random(conn, _params) do
    {:ok, articles} = File.ls(@input)
    IO.inspect articles
    article = articles |> Enum.random
    IO.inspect article
    redirect conn, to: "/" <> ( article |> String.replace(".md",""))
  end
end
