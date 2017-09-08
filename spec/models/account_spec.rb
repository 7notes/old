require 'rails_helper'

# ActiveRecord::Base.logger = Logger.new(STDOUT)

RSpec.configure do |c|
    c.use_transactional_examples = false
    c.order = "defined"
end

RSpec.describe Account, type: :model do
	account = Account.new
	it "sign up" do
		account.username = "Nurasyl"
		account.email = ""
		account.password = "123456"
		account.first_name = "нұрасыл"
		account.last_name = "алдан"
		account.gender = "1"
		account.language = "kk"
		
		ActiveRecord::Base.transaction(isolation: :serializable) do
			begin
				account.save!
			rescue ActiveRecord::RecordInvalid
				puts account.errors.messages
			end
		end
		expect(account.valid?).to be true
	end
	after(:all) { Account.destroy_all }
end

Account.find(1) rescue nil
