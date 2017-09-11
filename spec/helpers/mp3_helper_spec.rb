require 'rails_helper'

RSpec.describe Mp3Helper, type: :helper do
	it "seconds to minutes" do
		expect(seconds_to_minutes(60)).to eq "1:00"
		expect(seconds_to_minutes(60, true)[:min]).to eq 1
		expect(seconds_to_minutes(69)).to eq "1:09"
	end
end
