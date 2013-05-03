class OrdersController < ApplicationController

  def create
    if(session[:user].nil?)
        render :json => {:error_message=> "You must be logged in"} and return
    end

    user   = User.find(session[:user])
    orders = user.orders
    
    #If it's the first order, let them create it.
    if(orders.blank?)
       make_the_order(user, params[:amount])
    else #Clean up the user's stale orders so that no one spams our database
       orders.each do |o|
         if o.completed_at.nil?
           o.destroy
         end
       end

       make_the_order(user, params[:amount])
    end
  end

  def make_the_order(user, amount)
    begin
        order = Order.create!({:amount => amount, :user_id => user.id})
    rescue Exception => e
        render :json => {:error_message=> "Not a valid amount"} and return
    end

    render :json => {:order_id=>order.token}
    return
  end

  def show
    if(session[:user].nil?)
      raise "Forbidden access to order"
    end

    @order = Order.find(params[:id])
    user = User.find(session[:user]) 
    if(@order.user != user)
      raise "Forbidden access to order"
    end
   

    respond_to do |format|  
      format.html {
	    # If this is the callback from Paypal
	    if(params[:status] == "success" && params['PayerID'])
	      @order.try_to_complete(params['PayerID'])

	      render :nothing => true and return
	    end

	    if(@order.is_complete) #Note: Will repair a damaged order if possible.  So if something goes wrong durng in the purchase flow, a refresh will fix the problem.
        redirect_to "/" and return
	    end

	    #Tries to refresh the token if it's stale
      if(Time.now - @order.updated_at > 2.hours or @order.token.nil?)
		    @order.refresh_token 
        redirect_to "/" and return
	    end
      }
      format.json {
	     render :json => @order
      }  
    end 

    redirect_to "/" and return
  end

  def new
    #Works because we're only selling one product.
    #  So we can just grab any order attached to the current user.  If it's complete, the show-page will take care of it.  If it's not, same deal.
    if(current_user.orders.size > 0)
	@order = current_user.orders.first	
    else
    	@order = Order.create
	Ordering.create(:user_id=>current_user.id, :order_id => @order.id)
    end

    redirect_to @order
  end

end
