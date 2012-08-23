class Order < ActiveRecord::Base
  belongs_to :user

  attr_accessible :total_cents

  before_validation :set_defaults

  def self.date_descending
    order("date DESC")
  end

  def self.date(date)
    where(:date => date)
  end

  private
  def set_defaults
    self[:date] ||= Date.today
  end
end
