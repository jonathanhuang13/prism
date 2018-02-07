defmodule Api.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :parent_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:categories, [:parent_id])
  end
end
