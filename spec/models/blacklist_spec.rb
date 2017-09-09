require 'rails_helper'

RSpec.describe Blacklist, type: :model do
	context "blacklist" do
		it "validation" do
			user = Account.find_by_username("nurasyl")
			$current_user = user
			blackuser = user.blacklists.new

			ActiveRecord::Base.transaction(isolation: :serializable) do
				begin
					blackuser.User_id = user.id
					blackuser.save!
				rescue ActiveRecord::RecordInvalid
					expect(blackuser.errors.messages[:user].include? "self").to be true
				end
				begin
					blackuser.User_id = 0
					blackuser.save!
				rescue ActiveRecord::RecordInvalid
					expect(blackuser.errors.messages[:user].include? "not_found").to be true
				end
			end
			expect(blackuser.invalid?).to be true
		end
		it "list" do
			new_user = Account.new
			new_user.username = "Gaukhar"
			new_user.password = "123456"
			new_user.first_name = "гаухар"
			new_user.last_name = "абылкасымова"
			new_user.gender = "0"
			new_user.save

			$new_user = new_user

			user = Account.find_by_username("nurasyl")
			$current_user = user
			blackuser = $current_user.blacklists.new
			blackuser.User_id = new_user.id
			blackuser.save
			blackusers = user.blacklists.list
			expect(blackusers.size == 1).to be true
		end
		it "blackuser?" do
			extend UserHelper
			expect(blackuser?($new_user.id)).to be true
		end
		it "blocked?" do
			extend UserHelper
			expect(blocked?($new_user.id)).to be false
		end
	end
end
