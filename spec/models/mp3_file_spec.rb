require 'rails_helper'

RSpec.describe Mp3File, type: :model do
=begin
	it "save file" do
		mp3_file = $current_user.mp3_files.new
		mp3_file.file = File.open("/home/nurasyl/Desktop/2")
		mp3_file.save!

		mp3_file = $current_user.mp3_files.new
		mp3_file.file = File.open("/home/nurasyl/Desktop/2")

		begin
			mp3_file.save!
		rescue ActiveRecord::RecordInvalid
			puts mp3_file.errors.messages
		end
	end
=end
end
