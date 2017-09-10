class CreateMp3Files < ActiveRecord::Migration[5.1]
	def change
		create_table(:mp3_files, force: true) do |t|
			t.string 		:md5_hash
			t.string		:name
			t.references	:account, index: true, foreign_key: { to_table: :accounts }
			t.integer		:kpbs
			t.integer		:size
			t.string		:play_time
			t.binary		:content
			t.timestamps
		end

		add_index :mp3_files, :md5_hash, unique: true
	end
end
