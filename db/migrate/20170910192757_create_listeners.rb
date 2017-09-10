class CreateListeners < ActiveRecord::Migration[5.1]
  def change
    create_table :listeners do |t|
    	t.references	:music, index: true, foreign_key: { to_table: :music }
		t.references	:user, index: true, foreign_key: { to_table: :accounts }
		t.timestamps
    end
  end
end
