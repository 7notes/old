class CreatePlaylists < ActiveRecord::Migration[5.1]
	def change
		create_table(:playlists, force: true) do |t|
			t.string 		:md5_hash
			t.string		:name
			t.references	:account, index: true, foreign_key: { to_table: :accounts }
			t.integer		:music_count, default: 0
			t.binary		:image, null: true
			t.timestamps
		end
	end
end
