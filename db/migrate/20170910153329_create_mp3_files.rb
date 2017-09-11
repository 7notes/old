class CreateMp3Files < ActiveRecord::Migration[5.1]
	def change
		create_table(:mp3_files, force: true) do |t|
			t.references	:account, index: true, foreign_key: { to_table: :accounts }
			t.string 		:md5_hash
			t.string		:file_name, limit: 255
			t.integer		:size

			t.integer		:bitrate
			t.integer		:length

			t.string		:title
			t.string		:artist
			t.string		:album

			t.binary		:content
			t.timestamps
		end
		
		add_index :mp3_files, :md5_hash,             unique: true
	end
end
