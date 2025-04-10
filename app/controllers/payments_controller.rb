class PaymentsController < ApplicationController

  def create
    line_items = []
    current_user.cart_items.each do |cart_item|
      line_items << {
        price_data: {
          currency: 'usd',
          product_data: {
          name: cart_item.product.name },
          unit_amount: cart_item.product.price.to_i * 100
        },
        quantity: cart_item.quantity,
      }
    end

    total_amount = number_with_precision(
      current_user.cart_items.sum { |item| item.price.to_f * item.quantity },
      precision: 2
    )
    
    order = current_user.orders.create(
      user: current_user,
      status: "pending",
      total_amount: total_amount,
    )
    current_user.cart_items.each do |cart_item|
      order.order_items.create(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
    end

    if order.id.nil? || order.order_items.empty?
      return redirect_to root_url, notice: "Order not created"
    end


    session = Stripe::Checkout::Session.create({
      line_items: line_items,
      mode: 'payment',
      success_url: request.base_url + "/payments/success.html?order_id=#{order.id}",
      cancel_url: request.base_url + "/payments/cancel.html?order_id=#{order.id}",
    })

    render json: {url: session.url}, status: :ok
  end

  def success
    current_user.cart_items.destroy_all
    current_user.orders.find(params[:order_id]).update(status: "completed" )
    redirect_to root_url, notice: "Purchase Successful"
  end

  def cancel
    current_user.orders.find(params[:order_id]).update(status: "cancelled" ).destroy
    redirect_to root_url, notice: "Purchase Unsuccessful"
  end
end
