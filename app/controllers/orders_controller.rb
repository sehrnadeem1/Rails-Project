class OrdersController < ApplicationController
	load_and_authorize_resource :user
	load_and_authorize_resource :order

	def index
		if @user.waiter?
			@orders = @user.orders
			respond_to do |format|
	    	format.html
	  	end
	  else
	  	respond_to do |format|
	    	format.html
	  	end
		end
	end

	def create
		if @order.save
			respond_to do |format|
	    	format.html { redirect_to user_order_path(@user, @order), notice: 'Order successfully created.' }
	  	end
		else
			flash.now[:alert] = "Order could not be created."
			respond_to do |format|
	    	format.html { render 'new' }
	  	end
		end
	end

	def update
		if @order.update(order_params)
			respond_to do |format|
	    	format.html { redirect_to user_order_path(@user, @order), notice: 'Order successfully updated.' }
	    end
		else
			flash.now[:alert] = 'Order could not be updated.'
			respond_to do |format|
	    	format.html { render 'edit' }
	    end
		end
	end

	def destroy
		if @order.destroy
			flash[:notice] = "Order deleted."
		else
			flash[:alert] = "Order could not be deleted."
		end
		respond_to do |format|
	    	format.html { redirect_to user_orders_path(@user) }
	  end
	end

	private
	def order_params
		params.require(:order).permit(:status, :description, :delivery_time)
	end
end
