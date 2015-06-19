Dir.glob("../../app/assets/images/*.jpg").each do |file|
	name =  File.basename(file)
	b =  File.basename(file,".jpg").sub("unkai_","")
	date =  "20" + b[0] + b[1] + "-" + b[2] + b[3] + "-" + b[4] + b[5]

	puts "photo = UnkaiPhoto.create!(date: \"#{date}\")"
	puts "photo.image = Rails.root.join(\"app/assets/images/#{name}\").open"
	puts "photo.save!"
	puts ""

end