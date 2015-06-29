class Weather < ActiveRecord::Base
	validates :area,
    uniqueness: {
      message: "、dateが同じ組み合わせのレコードが既に存在します。",
      scope: [:date]
    }


  def get_Unkai(date)
  	flag = ""
    # 当日出た
  	a = UnkaiPhoto.find_by_date(date)
    unless a.nil?
    	flag = a.id.to_i
      return flag
    end
    # 明日出る
  	a = UnkaiPhoto.find_by_date(date+1)
    unless a.nil?
    	flag = "明日出る！"
      return flag
    end
    # 明後日出る
  	a = UnkaiPhoto.find_by_date(date+2)
  	flag = "明後日出る！" unless a.nil?
  	flag
  end
end
