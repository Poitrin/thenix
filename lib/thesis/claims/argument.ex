defmodule Thesis.Claims.Argument do
  use Ecto.Schema
  import Ecto.Changeset
  alias Thesis.Claims.Argument


  schema "arguments" do
    belongs_to :source_claim, Thesis.Claims.Claim
    belongs_to :destination_claim, Thesis.Claims.Claim
    field :type, :integer

    timestamps()
  end

  @doc false
  def changeset(%Argument{} = argument, attrs) do
    argument
    |> cast(attrs, [:type, :source_claim_id])
    |> cast_assoc(:destination_claim)
    |> validate_required([:type, :source_claim_id, :destination_claim])
  end
end
