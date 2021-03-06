class BlacklistValidator < ActiveModel::Validator
  include AccountHelper
  def validate(record)
	normalizer = AccountNormalizer.new
    id = normalizer.id(record.User_id)
    if Account.exists?(id)
      if id == $current_user.id
        record.errors[:user] << "self"
      else
        if $current_user.blacklists.exists?(user_id: id)
          record.errors[:user] << "unique"
        else
          if $current_user.blacklists.limit(Blacklist.limit).count(:account_id) >= Blacklist.limit
            record.errors[:user] << "limit"
          else
            record.user = Account.select(:id).find(id)
          end
        end
      end
    else
      record.errors[:user] << "not_found"
    end
  end
end

class Blacklist < ApplicationRecord
	include ActiveModel::Validations
	validates_with BlacklistValidator

	belongs_to :account, class_name: "Account", foreign_key: "account_id"
	belongs_to :user, class_name: "Account", foreign_key: "user_id"

	class_attribute :limit
	self.limit = 500

	attr_accessor :User_id

  before_save do
    favorite = $current_user.favorites.find_by(user_id: id)
    unless favorite.nil?
      favorite.destroy!
      # Favorites count update.
      $current_user.favorites_count = $current_user.favorites_count-1
      $current_user.save!
    end
    follower = $current_user.followers.find_by(account_id: id)
    unless follower.nil?
      follower.destroy!
      # Followers count update.
      user = Account.find(self.User_id)
      user.followers_count = user.followers_count-1
      user.save!
    end
  end

	def self.list page = 1
		page = page.to_i
		page = 1 if page < 1
		return $current_user.blacklists.joins(:user).select("created_at", "user_id", "accounts.username", "accounts.first_name", "accounts.last_name", "accounts.first_name_ru", "accounts.last_name_ru", "accounts.first_name_en", "accounts.last_name_en", "accounts.sign_in_at").order("accounts.sign_in_at DESC").where("accounts.is_active = ?", true).paginate(:page => page, :per_page => 50)
	end
end
