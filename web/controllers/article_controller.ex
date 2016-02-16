defmodule Pwiki.ArticleController do
  use Pwiki.Web, :controller
  alias Pwiki.Article

  @input "web/articles/"


  def show(conn,  %{"name" => name}) do
    case File.read(@input <> name <> ".md") do
      {:ok, body}      ->
        concent = Earmark.to_html body
        render conn, "index.html", title: name, concent: concent
      {:error, reason} ->
        redirect conn, to: article_path(conn, :new, name)
    end
  end

  def new(conn,  %{"name" => name}) do
    render conn, "new.html", changeset: Article.changeset(%Article{title: name})
  end

  def create(conn, %{"article" => article}) do
      path = @input <> article["title"] <> ".md"
      case File.write(path, article["content"]) do
         :ok ->  redirect conn, to: article_path(conn, :show, article["title"])
         {:error, reason} -> render conn, Pwiki.ErrorView, "500.html"
      end

  end
end
