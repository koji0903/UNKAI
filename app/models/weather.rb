class Weather < ActiveRecord::Base
	validates :area,
    uniqueness: {
      message: "、dateが同じ組み合わせのレコードが既に存在します。",
      scope: [:date]
    }


  def get_Unkai(date)
  	flag = ""
  	a = UnkaiPhoto.find_by_date(date)
  	flag = a.id.to_i unless a.nil?
  	a = UnkaiPhoto.find_by_date(date+1)
  	flag = "明日出る！" unless a.nil?
  	a = UnkaiPhoto.find_by_date(date+2)
  	flag = "明後日出る！" unless a.nil?
  	flag
  end
end
