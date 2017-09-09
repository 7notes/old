class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table(:accounts, :force => true) do |t|
      t.string        :username
      t.string        :email, null: true
      t.string        :password

      t.datetime      :sign_in_at
      t.inet          :sign_in_ip, null: true
      t.string        :sign_in_user_agent, null: true

      t.string        :first_name
      t.string        :last_name
      t.string        :first_name_ru
      t.string        :last_name_ru
      t.string        :first_name_en
      t.string        :last_name_en
      t.integer       :gender,                  limit: 1

      t.string        :language
      t.boolean       :is_active,               default: true

      t.datetime      :sign_up_at
      t.inet          :sign_up_ip, null: true
      t.string        :sign_up_user_agent, null: true

      t.string        :country, null: true
      t.string        :city, null: true

      t.integer       :favorites_count, default: 0
      t.integer       :followers_count, default: 0
    end

    add_index :accounts, :email,                unique: true
    add_index :accounts, :username,             unique: true
  end
end
