require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
	include ApplicationHelper
	it "split" do
		expect(split_string(" ").size).to eq 0
		expect(split_string(" nurasyl aldan ").size).to eq 2
		expect(split_string(" nurasyl ").size).to eq 1
	end
	it "to russian" do
		expect(name_to_russian(" Нұрасыл ")).to eq "Нурасыл"
		expect(name_to_russian(" Гауһар ")).to eq "Гаухар"
		expect(name_to_russian(" Назира ")).to eq "Назира"
		expect(name_to_russian(" Даниль ")).to eq "Даниль"
		expect(name_to_russian(" Сағира ")).to eq "Сагира"
		expect(name_to_russian(" Құралбек ")).to eq "Куралбек"
	end
	it "to english" do
		expect(name_to_english(" Нұрасыл ")).to eq "Nurasyl"
		expect(name_to_english(" Гауһар ")).to eq "Gaukhar"
		expect(name_to_english(" Назира ")).to eq "Nazira"
		expect(name_to_english(" Даниль ")).to eq "Danil"
		expect(name_to_english(" Сағира ")).to eq "Sagira"
		expect(name_to_english(" Құралбек ")).to eq "Kuralbek"
		expect(name_to_english(" Қайрат ")).to eq "Kairat"
	end
end
