class WeatherHour < ActiveRecord::Base
	validates :area,
    uniqueness: {
      message: "、dateが同じ組み合わせのレコードが既に存在します。",
      scope: [:date,:date_time]
    }

  def get_Unkai(date)
  	a = UnkaiPhoto.find_by_date(date)
  	a.id unless a.nil?
  end

end
