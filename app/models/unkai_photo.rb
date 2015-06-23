class UnkaiPhoto < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	def previous
		UnkaiPhoto.where("id < ?", self.id).order("id DESC").first
	end

	def next
		UnkaiPhoto.where("id > ?", self.id).order("id ASC").first
	end

end
