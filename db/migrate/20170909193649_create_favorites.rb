class CreateFavorites < ActiveRecord::Migration[5.1]
	def change
		create_table(:favorites, id: false, force: true) do |t|
			t.references	:account, index: true, foreign_key: { to_table: :accounts }
			t.references	:user, index: true, foreign_key: { to_table: :accounts }
			t.timestamps
		end
	end
end
