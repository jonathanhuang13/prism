defmodule Api.Repo.Migrations.EventBelongsToCategory do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :category_id, references(:categories)
    end
  end
end
