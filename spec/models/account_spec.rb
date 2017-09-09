require 'rails_helper'

# ActiveRecord::Base.logger = Logger.new(STDOUT)

Blacklist.delete_all
Account.delete_all

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
			end
		end
		expect(account.valid?).to be true
	end
	it "search" do
		expect(Account.search.size == 1).to be true
		expect(Account.search(" 0 ").size == 0).to be true
		expect(Account.search(" Nurasyl ").size == 1).to be true
		expect(Account.search(" Aldan ").size == 1).to be true
		expect(Account.search(" nurasyl aldan ").size == 1).to be true
		expect(Account.search(" aldan nurasyl ").size == 1).to be true
		expect(Account.search(" nurasyl aldan nurgazy ").size == 1).to be true
		expect(Account.search(" nurasyl nurgazy aldan ").size == 1).to be true
		expect(Account.search(" нұрасыл nurgazy aldan ").size == 1).to be true
		expect(Account.search(" нұрасыл nurgazy ").size == 1).to be false
		expect(Account.search(" нұрасыл erkhozhaev ").size == 1).to be false
		expect(Account.search(" нұрасыл aldan ").size == 1).to be true
		expect(Account.search(" aldan нұрасыл ").size == 1).to be true
	end
	it "profile" do
		expect(Account.profile(" Gaukhar ") == nil).to be true
		expect(Account.profile(" Nurasyl ")[:username] == "nurasyl").to be true
	end
end
