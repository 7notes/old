class CreateMusic < ActiveRecord::Migration[5.1]
  def change
    create_table(:music, force: true) do |t|
    	t.references	:account, index: true, foreign_key: { to_table: :accounts }
    	t.references	:mp3_file, index: true, foreign_key: { to_table: :mp3_files }
		t.references	:playlist, index: true, foreign_key: { to_table: :playlists }
		t.boolean		:is_uploaded, default: false
		t.integer		:likes_count, default: 0
		t.integer		:play_count, default: 0
		t.integer		:order, default: 0
		t.integer		:size

		t.integer		:bitrate
		t.integer		:length
		
		t.string		:title
		t.string		:artist

		t.timestamps
    end
  end
end
