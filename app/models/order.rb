class Order < ActiveRecord::Base
  def self.date_descending
    order("date DESC")
  end
end
