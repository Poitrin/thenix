defmodule Thesis.Claims.Claim do
  use Ecto.Schema
  import Ecto.Changeset
  alias Thesis.Claims.Claim


  schema "claims" do
    field :content, :string
    field :stand_alone, :boolean

    has_many :arguments, Thesis.Claims.Argument, foreign_key: :source_claim_id

    timestamps()
  end

  @doc false
  def changeset(%Claim{} = claim, attrs) do
    claim
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end

  def filter_by_type(arguments, type) do
    arguments |> Enum.filter(fn(argument) -> argument.type == type end)
  end

  def type_name(type) do
    # TODO: Translation!
    %{1 => "Pros", 2 => "Cons"}[type]
  end
end
