class Mp3File < ApplicationRecord
	attr_accessor :file
	SIZE_LIMIT = 15000000 # 15 MB.

	before_validation do
		TagLib::MPEG::File.open(self.file.path) do |mp3_file|
			tag = mp3_file.id3v2_tag
			properties = mp3_file.audio_properties

			self.bitrate = properties.bitrate
			self.length = properties.length

			self.title = tag.title
			self.artist = tag.artist
			self.album = tag.album
			self.content = self.file.read

			self.file_name = File.basename(self.file.path)
			self.size = self.file.size
			self.md5_hash = Digest::MD5.hexdigest(self.content).to_s
		end
	end

	validates :md5_hash, uniqueness: { message: 'unique' }

	validate :validate_size, :validate_mime

	def validate_size
		if self.file.size > SIZE_LIMIT
			errors.add(:file, "limit")
		end
	end
	def validate_mime
		unless MimeMagic.by_magic(File.open(self.file.path)) == "audio/mpeg"
			errors.add(:file, "mime")
		end
	end
end
