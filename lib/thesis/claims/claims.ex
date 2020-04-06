defmodule Thesis.Claims do
  @moduledoc """
  The Claims context.
  """

  import Ecto.Query, warn: false
  alias Thesis.Repo

  alias Thesis.Claims.Claim

  @doc """
  Returns the list of claims.

  ## Examples

      iex> list_claims()
      [%Claim{}, ...]

  """
  def list_claims do
    from(c in Claim, where: c.stand_alone == true)
      |> Repo.all()
  end

  @doc """
  Gets a single claim.

  Raises `Ecto.NoResultsError` if the Claim does not exist.

  ## Examples

      iex> get_claim!(123)
      %Claim{}

      iex> get_claim!(456)
      ** (Ecto.NoResultsError)

  """
  def get_claim!(id), do: Repo.get!(Claim, id)
    |> Repo.preload(arguments: [:destination_claim])

  def get_main_claim_id(claim_id) do
    query = """
WITH RECURSIVE all_arguments AS (
SELECT source_claim_id, destination_claim_id
  FROM arguments
  WHERE destination_claim_id = $1
UNION ALL
SELECT a.source_claim_id, a.destination_claim_id
  FROM arguments a
  JOIN all_arguments b ON b.source_claim_id = a.destination_claim_id
)
SELECT source_claim_id
  FROM all_arguments a
  JOIN claims c ON a.source_claim_id = c.id AND stand_alone = TRUE
    """

    {:ok, result} = Repo.query(query, [claim_id])
    if result.num_rows > 0 do
      result.rows |> List.first |> List.first
    end
  end

  @doc """
  Creates a claim.

  ## Examples

      iex> create_claim(%{field: value})
      {:ok, %Claim{}}

      iex> create_claim(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_claim(attrs \\ %{}) do
    %Claim{stand_alone: true}
    |> Claim.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a claim.

  ## Examples

      iex> update_claim(claim, %{field: new_value})
      {:ok, %Claim{}}

      iex> update_claim(claim, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_claim(%Claim{} = claim, attrs) do
    claim
    |> Claim.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Claim.

  ## Examples

      iex> delete_claim(claim)
      {:ok, %Claim{}}

      iex> delete_claim(claim)
      {:error, %Ecto.Changeset{}}

  """
  def delete_claim(%Claim{} = claim) do
    Repo.delete(claim)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking claim changes.

  ## Examples

      iex> change_claim(claim)
      %Ecto.Changeset{source: %Claim{}}

  """
  def change_claim(%Claim{} = claim) do
    Claim.changeset(claim, %{})
  end

  alias Thesis.Claims.Argument

  @doc """
  Returns the list of arguments.

  ## Examples

      iex> list_arguments()
      [%Argument{}, ...]

  """
  def list_arguments do
    Repo.all(Argument)
  end

  @doc """
  Gets a single argument.

  Raises `Ecto.NoResultsError` if the Argument does not exist.

  ## Examples

      iex> get_argument!(123)
      %Argument{}

      iex> get_argument!(456)
      ** (Ecto.NoResultsError)

  """
  def get_argument!(id), do: Repo.get!(Argument, id)

  @doc """
  Creates a argument.

  ## Examples

      iex> create_argument(%{field: value})
      {:ok, %Argument{}}

      iex> create_argument(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_argument(attrs \\ %{}) do
    %Argument{}
    |> Argument.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a argument.

  ## Examples

      iex> update_argument(argument, %{field: new_value})
      {:ok, %Argument{}}

      iex> update_argument(argument, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_argument(%Argument{} = argument, attrs) do
    argument
    |> Argument.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Argument.

  ## Examples

      iex> delete_argument(argument)
      {:ok, %Argument{}}

      iex> delete_argument(argument)
      {:error, %Ecto.Changeset{}}

  """
  def delete_argument(%Argument{} = argument) do
    Repo.delete(argument)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking argument changes.

  ## Examples

      iex> change_argument(argument)
      %Ecto.Changeset{source: %Argument{}}

  """
  def change_argument(%Argument{} = argument) do
    Argument.changeset(argument, %{})
  end
end
