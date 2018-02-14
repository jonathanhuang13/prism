defmodule Prism.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :start, :utc_datetime
      add :end, :utc_datetime
      add :location, :string
      add :description, :string

      timestamps()
  end
end
