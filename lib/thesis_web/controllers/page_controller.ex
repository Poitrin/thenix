defmodule ThesisWeb.PageController do
  use ThesisWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
