require 'rails_helper'

RSpec.describe AccountHelper, type: :helper do
	context "normalizer" do
		normalizer = AccountHelper::AccountNormalizer.new
		it "username" do
			expect(normalizer.username(" Nurasyl ")).to eq "nurasyl"
		end
		it "first_name" do
			expect(normalizer.first_name(" нұр асыл ")).to eq "Нұрасыл"
		end
		it "last_name" do
			expect(normalizer.last_name(" ал дан ")).to eq "Алдан"
		end
		it "gender" do
			expect(normalizer.gender(" 0 ")).to eq 0
			expect(normalizer.gender(" 1 ")).to eq 1
			expect(normalizer.gender("1")).to eq 1
			expect(normalizer.gender(" ")).to eq nil
		end
		it "email" do
			expect(normalizer.email(" Nurassyl.Aldan@gmail.com ")).to eq "nurassyl.aldan@gmail.com"
			expect(normalizer.email(" ")).to eq nil
		end
		it "password" do
			expect(normalizer.password(" my password ")).to eq "my password"
			expect(normalizer.password(" Nurasyl12345 ")).to eq "Nurasyl12345"
		end
		it "language" do
			expect(normalizer.language("es")).to eq normalizer.config.default[:language]
			expect(normalizer.language("kk")).to eq "kk"
			expect(normalizer.language("ru")).to eq "ru"
		end
		it "is_active" do
			expect(normalizer.is_active(" true ")).to be true
			expect(normalizer.is_active(" 1 ")).to eq true
			expect(normalizer.is_active(" 0 ")).to eq false
			expect(normalizer.is_active(" false ")).to eq false
			expect(normalizer.is_active(" ")).to eq false
			expect(normalizer.is_active(" 2 ")).to eq false
		end
	end
	context "scanner" do
		normalizer = AccountHelper::AccountNormalizer.new
		scanner = AccountHelper::AccountDataScanner.new
		it "username" do
			expect(scanner.username("Nurasyl")).to be true
			expect(scanner.username("nur asyl")).to be false
			expect(scanner.username("_nurasyl")).to be false
			expect(scanner.username("nurasyl_")).to be false
			expect(scanner.username("nurasyl_aldan")).to be true
			expect(scanner.username("nurasyl_aldan_21")).to be true
			expect(scanner.username("21nurasyl")).to be true
			expect(scanner.username("nurasyl11")).to be true
			expect(scanner.username("a_nurasyl")).to be true
			expect(scanner.username("n_aldan")).to be true
			expect(scanner.username("12345")).to be false
			expect(scanner.username("___")).to be false
			expect(scanner.username("21_11_1996")).to be true
			expect(scanner.username("nurasyl__aldan")).to be false
		end
		it "email" do
			expect(scanner.email("Nurassyl.Aldan@gmail.com")).to be true
			expect(scanner.email("nurasyl")).to be false
			expect(scanner.email("_@_")).to be true
			expect(scanner.email("_-@_")).to be true
			expect(scanner.email("nurasyl-aldan@localhost")).to be true
			expect(scanner.email("nurasyl-aldan@")).to be false
			expect(scanner.email("@domain")).to be false
		end
		it "password" do
			expect(scanner.password(" ")).to be true
			expect(scanner.password(" Нұрасыл ")).to be false
			expect(scanner.password(" Nurasyl ")).to be true
			expect(scanner.password(" 1234567 ")).to be true
		end
		it "gender" do
			expect(scanner.gender(" ")).to be false
			expect(scanner.gender(" 2 ")).to be false
			expect(scanner.gender(" 1 ")).to be true
			expect(scanner.gender(" 0 ")).to be true
		end
	end
end
