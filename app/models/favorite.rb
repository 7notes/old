class FavoriteValidator < ActiveModel::Validator
  include AccountHelper
  include UserHelper
  def validate(record)
	normalizer = AccountNormalizer.new
    id = normalizer.id(record.User_id)
    if Account.exists?(id)
      if id == $current_user.id
        record.errors[:user] << "self"
      else
        if $current_user.blacklists.exists?(user_id: id)
          record.errors[:user] << "is_exists"
        else
          if $current_user.blacklists.limit(Favorite.limit).count(:account_id) >= Favorite.limit
            record.errors[:user] << "limit"
          else
            if blocked?(record.User_id)
            	record.errors[:user] << "blocked"
            else
            	record.user = Account.select(:id).find(id)
            end
          end
        end
      end
    else
      record.errors[:user] << "not_found"
    end
  end
end

class Favorite < ApplicationRecord
	include ActiveModel::Validations
	validates_with FavoriteValidator

	belongs_to :account, class_name: "Account", foreign_key: "account_id"
	belongs_to :user, class_name: "Account", foreign_key: "user_id"

	class_attribute :limit
	self.limit = 1000

	attr_accessor :User_id

	before_save do
		# Favorites count update.
		$current_user.favorites_count = $current_user.favorites_count+1
		$current_user.save!
		# Followers count update.
		user = Account.find(self.User_id)
		user.followers_count = user.followers_count+1
		user.save!
	end
	before_destroy do
		# Favorites count update.
		$current_user.favorites_count = $current_user.favorites_count-1
		$current_user.save!
		# Followers count update.
		user = Account.find(self.user_id)
		user.followers_count = user.followers_count-1
		user.save!
	end

	def self.favorites page = 1
		page = page.to_i
		page = 1 if page < 1
		return $current_user.favorites.joins(:user).select("created_at", "user_id", "accounts.username", "accounts.first_name", "accounts.last_name", "accounts.first_name_ru", "accounts.last_name_ru", "accounts.first_name_en", "accounts.last_name_en", "accounts.sign_in_at").order("accounts.sign_in_at DESC").where("accounts.is_active = ?", true).paginate(:page => page, :per_page => 50)
	end
	def self.followers page = 1
		page = page.to_i
		page = 1 if page < 1
		return $current_user.followers.joins(:account).select("created_at", "user_id", "accounts.username", "accounts.first_name", "accounts.last_name", "accounts.first_name_ru", "accounts.last_name_ru", "accounts.first_name_en", "accounts.last_name_en", "accounts.sign_in_at").order("accounts.sign_in_at DESC").where("accounts.is_active = ?", true).paginate(:page => page, :per_page => 50)
	end
end
