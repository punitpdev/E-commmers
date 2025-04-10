class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  validates :total_amount, presence: true
  validates :status, presence: true

  def update_product_stock
    order_items.each do |item|
      product = item.product
      product.update(stock_quantity: product.stock_quantity - item.quantity)
    end
  end
end
