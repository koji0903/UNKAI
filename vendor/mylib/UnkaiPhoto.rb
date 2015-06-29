# coding: utf-8

require 'open-uri'
require 'nokogiri'
require 'pp'

$url_base = "http://www.aso-domannaka.com/unkaiGallery/"
years = (2005..2013).to_a


def get_Html(url)
	charset = nil

	html = open(url,"r:UTF-8") do |f|
		charset = f.charset # 文字種別を取得
		f.read # htmlを読み込んで変数htmlに渡す
	end
	doc = Nokogiri::HTML.parse(html, nil, 'UTF-8')
#	doc = Nokogiri::HTML.parse(html.toutf8, nil, 'utf-8')

	# タイトルを表示
	parse(doc)

end

def save_image(url)
  # ready filepath
  fileName = File.basename(url)
  dirName = ("../../app/assets/images/")
  filePath = dirName + fileName

  # create folder if not exist
  FileUtils.mkdir_p(dirName) unless FileTest.exist?(dirName)

  # write image adata
  open(filePath, 'wb') do |output|
    open(url) do |data|
      output.write(data.read)
    end
  end
end

def parse(doc)
	doc.xpath('//div[@class="unkaiImgCell"]').each do |node|
#		p node['href']
#		node.children.each do |n|
#			p n['href'] unless n['href'].nil?
#			p n['title'] unless n['<title></title>'].nil?#
#		end
		image_link =  node.children[1]['href']
		comment =  node.children[1]['title'].gsub("<br />","").strip
#		 node.children.children[1]['title']
#		p node.children.children[1]['alt']
		date = ""
		begin
			comment =~ /^(\d+)年(\d+)月(\d+)日/
			if ( $1 != nil ) &&  ( $2 != nil ) &&  ( $3 != nil )
				date = $1 + "/" + $2 + "/" + $3
			end
		rescue Exception => e
			date = ""
		end

		time = ""
		begin
			if ( comment =~ /AM/ )
				time = comment.split(' ')[1].split('　')[0]
				time.sub!('AM','')
			elsif ( comment =~ /ＡＭ(.*)】/ )
				time = $1.tr!("０-９", "0-9").gsub("：",":")
			end
		rescue Exception => e
			time = ""
		end

=begin
		p "------------"
		puts "Image:" + image_link
		puts "Comment:" + comment
		puts "Date:" + date
		puts "Time:" + time
=end

	#	save_image($url_base + image_link)

		puts "photo = UnkaiPhoto.create!(date: \"#{date}\", comment: \"#{comment}\", photo_time: \"#{time}\")"
		puts "photo.image = Rails.root.join(\"app/assets/images/#{File.basename(image_link)}\").open"
		puts "photo.save!"
		puts ""


	end
end

years.each do |year|
	url = $url_base + "unkai" + year.to_s + ".html"
	get_Html(url)
end