class Order < ActiveRecord::Base
  belongs_to :user

  def self.date_descending
    order("date DESC")
  end

  def self.date(date)
    where(:date => date)
  end
end
