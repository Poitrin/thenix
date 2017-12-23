defmodule Thesis.Repo.Migrations.CreateArguments do
  use Ecto.Migration

  def change do
    create table(:arguments) do
      add :source_claim_id, references(:claims)
      add :destination_claim_id, references(:claims)
      add :type, :integer

      timestamps()
    end

  end
end
