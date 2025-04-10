class Product < ApplicationRecord
  has_many :variants, dependent: :destroy
  has_many :cart_items, class_name: "CartItems",  dependent: :destroy
  has_one_attached :image
  accepts_nested_attributes_for :variants, allow_destroy: true

  validates :name, :price, :stock_quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { only_integer: true }

  after_create_commit { log_activity('created') }
  after_update_commit { log_activity('updated') }
  after_destroy_commit { log_activity('deleted') }

  def self.search(query)
    if query.present?
      where('name LIKE ?', "%#{query}%")
        .or(where('description LIKE ?', "%#{query}%"))
    else
      all
    end
  end

  private

  def log_activity(action)
    ActivityLog.create!(record_type: 'Product', record_id: id, action: action, message: "Product #{name} was #{action}.")
  end
end
