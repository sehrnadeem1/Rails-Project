class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy

  # validate :delivery_time_cannot_be_earlier_than_present

  # def delivery_time_cannot_be_earlier_than_present
  #   if delivery_time.present? && delivery_time < DateTime.now
  #     errors.add(:delivery_time, "can't be earlier than the present time")
  #   end
  # end

end
