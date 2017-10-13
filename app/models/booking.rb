class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :start_time, :presence => true
  validates :end_time, :presence => true


  validates :booking_duration_check, inclusion: { in: 1..10, message: 'Please choose between 1 hour and 10 hours' }
  validate :date_range, on: :create
  validate :date_range_edit, on: :update

  def booking_duration_check
    if start_time == nil or end_time == nil
      errors.add(:base, 'Dates can not be empty')
    else
      ( Time.parse(end_time.to_s) - Time.parse(start_time.to_s) ) / 3600
    end
  end


  def date_range_edit
    if start_time != nil and end_time != nil
      unless Booking.where('car_id = ?  AND status <2 AND id <> ? AND ((start_time <= ? AND end_time >= ?) OR (start_time >= ? AND end_time <= ?) OR (start_time <= ? AND end_time >= ?))',
                           car_id, id, start_time, start_time,
                           start_time, end_time, end_time, end_time).empty?
        errors.add(:base, 'Car is unavailable, choose other dates')
      end
    end
  end

  def date_range
    if start_time != nil and end_time != nil
      unless Booking.where('car_id = ?  AND status <2 AND id <> ? AND ((start_time <= ? AND end_time >= ?) OR (start_time >= ? AND end_time <= ?) OR (start_time <= ? AND end_time >= ?))',
                           car_id, id, start_time, start_time,
                           start_time, end_time, end_time, end_time).empty?
        errors.add(:base, 'Car is unavailable, choose other dates')
      end
    end
  end


end
