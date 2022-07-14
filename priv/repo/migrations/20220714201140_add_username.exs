defmodule Pento.Repo.Migrations.AddUsername do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, size: 127, unique: true, default: Faker.Person.name()
    end

    create unique_index(:users, [:username])
  end
end
