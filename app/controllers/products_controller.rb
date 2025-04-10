# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def index
    @query = params[:query]
    @category = params[:category]

    @products = Product.all
    @products = @products.where("name LIKE ?", "%#{@query}%") if @query.present?
    @products = @products.where(category: @category) if @category.present?

    @cart_items = current_user.cart_items
    
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end


  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
