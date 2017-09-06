# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
class DropAccounts < ActiveRecord::Migration[5.1]
  drop_table :users, if_exists: true
end
class DropOthers < ActiveRecord::Migration[5.1]
  drop_table :ar_internal_metadata, if_exists: true
  drop_table :schema_migrations, if_exists: true
end
