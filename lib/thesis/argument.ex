defmodule Thesis.Argument do
  use Ecto.Schema
  import Ecto.Changeset
  alias Thesis.Argument


  schema "arguments" do
    belongs_to :source_claim, Thesis.Claim
    belongs_to :destination_claim, Thesis.Claim
    field :type, :integer

    timestamps()
  end

  @doc false
  def changeset(%Argument{} = argument, attrs) do
    argument
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
