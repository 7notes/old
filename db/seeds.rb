class DropLikes < ActiveRecord::Migration[5.1]
  drop_table :likes, if_exists: true
end
class DropListeners < ActiveRecord::Migration[5.1]
  drop_table :listeners, if_exists: true
end
class DropMusic < ActiveRecord::Migration[5.1]
  drop_table :music, if_exists: true
end
class DropPlaylists < ActiveRecord::Migration[5.1]
  drop_table :playlists, if_exists: true
end
class DropMp3Files < ActiveRecord::Migration[5.1]
  drop_table :mp3_files, if_exists: true
end
class DropFavorites < ActiveRecord::Migration[5.1]
  drop_table :favorites, if_exists: true
end
class DropBlacklists < ActiveRecord::Migration[5.1]
  drop_table :blacklists, if_exists: true
end
class DropAccounts < ActiveRecord::Migration[5.1]
  drop_table :accounts, if_exists: true
end
class DropOthers < ActiveRecord::Migration[5.1]
  drop_table :ar_internal_metadata, if_exists: true
  drop_table :schema_migrations, if_exists: true
end
