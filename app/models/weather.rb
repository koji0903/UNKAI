class Weather < ActiveRecord::Base
	validates :area,
    uniqueness: {
      message: "、dateが同じ組み合わせのレコードが既に存在します。",
      scope: [:date]
    }


  def get_Unkkai(date)
  	flag = ""
  	a = UnkaiPhoto.find_by_date(date)
  	flag = a.id unless a.nil?
  	a = UnkaiPhoto.find_by_date(date+1)
  	flag = "T" unless a.nil?
  	a = UnkaiPhoto.find_by_date(date+2)
  	flag = "DT" unless a.nil?
  	flag
  end
end
