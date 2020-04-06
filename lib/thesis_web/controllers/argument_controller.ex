defmodule ThesisWeb.ArgumentController do
  use ThesisWeb, :controller

  alias Thesis.Claims
  alias Thesis.Claims.Argument

  def index(conn, _params) do
    arguments = Claims.list_arguments()
    render(conn, "index.html", arguments: arguments)
  end

  def new(conn, _params) do
    changeset = Claims.change_argument(%Argument{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"argument" => argument_params}) do
    case Claims.create_argument(argument_params) do
      {:ok, argument} ->
        conn
        |> put_flash(:info, "Argument created successfully.")
        |> redirect(to: claim_path(conn, :show, argument.source_claim_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    argument = Claims.get_argument!(id)
    render(conn, "show.html", argument: argument)
  end

  def edit(conn, %{"id" => id}) do
    argument = Claims.get_argument!(id)
    changeset = Claims.change_argument(argument)
    render(conn, "edit.html", argument: argument, changeset: changeset)
  end

  def update(conn, %{"id" => id, "argument" => argument_params}) do
    argument = Claims.get_argument!(id)

    case Claims.update_argument(argument, argument_params) do
      {:ok, argument} ->
        conn
        |> put_flash(:info, "Argument updated successfully.")
        |> redirect(to: argument_path(conn, :show, argument))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", argument: argument, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    argument = Claims.get_argument!(id)
    {:ok, _argument} = Claims.delete_argument(argument)

    conn
    |> put_flash(:info, "Argument deleted successfully.")
    |> redirect(to: argument_path(conn, :index))
  end
end
