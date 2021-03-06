defmodule Thesis.Repo.Migrations.CreateClaims do
  use Ecto.Migration

  def change do
    create table(:claims) do
      add :content, :string, size: 4000
      add :stand_alone, :boolean, default: false

      timestamps()
    end

  end
end
