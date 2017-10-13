class Car < ApplicationRecord
  has_many :bookings
  validates :model, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :license_number, :presence => true
  validates :manufacturer, :presence => true
  validates :style, :presence => true, :inclusion => { :in => ['Hatchback', 'Sedan', 'SUV'] }
  validates :price, :presence => true
 # validates :status, :presence => true, :inclusion => { :in => [0, 1, 2] }
  validates :location, :presence => true

  def self.search(search, search_by)
    where("#{search_by} LIKE ?", "%#{search}%")
  end

  #def available?
  #  bookings.empty? || bookings.map(&:starting).min > Date.tomorrow
  #end

end
