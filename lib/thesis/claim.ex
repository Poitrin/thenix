defmodule Thesis.Claim do
  use Ecto.Schema
  import Ecto.Changeset
  alias Thesis.Claim


  schema "claims" do
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(%Claim{} = claim, attrs) do
    claim
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
