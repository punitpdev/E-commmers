# app/controllers/products_controller.rb
class Admin::ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @min_price = params[:min_price].presence
    @stock_quantity = params[:stock_quantity].presence

    @products =Product.search(params[:search])
    @products = @products.where('price >= ?', @min_price) if @min_price.present?
    @products = @products.where('stock_quantity >= ?', @stock_quantity) if @stock_quantity.present?

    @products = @products.order(created_at: :desc)
  end

  def show
  end

  def new
    @product = Product.new
    @product.variants.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Product created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product deleted"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :stock_quantity,
      :image,
      variants_attributes: [:id, :option_type, :value, :_destroy]
    )
  end
end
