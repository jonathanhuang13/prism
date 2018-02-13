defmodule Prism.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :parent_id, references(:categories)

      timestamps()
    end

  create index(:categories, [:parent_id])

  end
end
