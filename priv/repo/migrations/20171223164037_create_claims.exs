defmodule Thesis.Repo.Migrations.CreateClaims do
  use Ecto.Migration

  def change do
    create table(:claims) do
      add :content, :string, size: 4000

      timestamps()
    end

  end
end
