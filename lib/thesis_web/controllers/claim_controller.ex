defmodule ThesisWeb.ClaimController do
  use ThesisWeb, :controller

  alias Thesis.Claims
  alias Thesis.Claims.Claim
  alias Thesis.Claims.Argument

  def index(conn, _params) do
    claims = Claims.list_claims()
    changeset = Claims.change_claim(%Claim{})
    render(conn, "index.html", claims: claims, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Claims.change_claim(%Claim{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"claim" => claim_params}) do
    # TODO: needed?
    claims = Claims.list_claims()

    case Claims.create_claim(claim_params) do
      {:ok, claim} ->
        conn
        |> put_flash(:info, "Claim created successfully.")
        |> redirect(to: claim_path(conn, :show, claim))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", claims: claims, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    claim = Claims.get_claim!(id)
    changeset = Claims.change_argument(%Argument{source_claim_id: id})
    render(conn, "show.html", claim: claim,
      changeset: changeset, action: argument_path(conn, :create))
  end

  def edit(conn, %{"id" => id}) do
    claim = Claims.get_claim!(id)
    changeset = Claims.change_claim(claim)
    render(conn, "edit.html", claim: claim, changeset: changeset)
  end

  def update(conn, %{"id" => id, "claim" => claim_params}) do
    claim = Claims.get_claim!(id)

    case Claims.update_claim(claim, claim_params) do
      {:ok, claim} ->
        conn
        |> put_flash(:info, "Claim updated successfully.")
        |> redirect(to: claim_path(conn, :show, claim))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", claim: claim, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    claim = Claims.get_claim!(id)
    {:ok, _claim} = Claims.delete_claim(claim)

    conn
    |> put_flash(:info, "Claim deleted successfully.")
    |> redirect(to: claim_path(conn, :index))
  end
end
