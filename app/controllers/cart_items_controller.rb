class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:increase, :decrease, :destroy]

  def index
    @cart_items = current_user.cart_items
  end

  def create
    product = Product.find(params[:product_id])
    cart_item = current_user.cart_items.find_or_initialize_by(product_id: product.id)
    cart_item.quantity =  cart_item.id.nil? ? 1 : cart_item.quantity + 1
    cart_item.price = product.price *  cart_item.quantity
    cart_item.save

    respond_to do |format|
      format.html { redirect_to products_path, notice: "#{product.name} added to cart." }
      format.turbo_stream {
        @cart_items  = current_user.cart_items
        render turbo_stream: turbo_stream.replace("checkout_items", partial: "shared/checkout_items", locals: { cart_items: @cart_items })
      }
    end
  end

  def increase
    @cart_item.increment!(:quantity)
    respond_to_format
  end

  def decrease
    if @cart_item.quantity > 1
      @cart_item.decrement!(:quantity)
    else
      @cart_item.destroy
    end
    respond_to_format
  end

  def destroy
    @cart_item.destroy
    respond_to_format
  end

  private

  def respond_to_format
    respond_to do |format|
      format.html { redirect_to products_path, notice: "#{product.name} added to cart." }
      format.turbo_stream {
        @cart_items  = current_user.cart_items
        render turbo_stream: turbo_stream.replace("checkout_items", partial: "shared/checkout_items", locals: { cart_items: @cart_items })
      }
    end
  end

  def set_cart_item
    @cart_item = current_user.cart_items.find(params[:id])
  end

end
