class Order < ApplicationRecord
  has_many :line_items
  monetize :total_cents, numericality: true
  validates :stripe_charge_id, presence: true

  def total_amount
    line_items.sum { |line_item| line_item.total_price }
  end
end
