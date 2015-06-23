class Weather < ActiveRecord::Base
	validates :area,
    uniqueness: {
      message: "、dateが同じ組み合わせのレコードが既に存在します。",
      scope: [:date]
    }


  def get_Unkkai(date)
  	a = UnkaiPhoto.find_by_date(date)
  	a.id unless a.nil?
  end
end
