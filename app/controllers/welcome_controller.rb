class WelcomeController < ApplicationController

    def index
      donations            = Donation.all
      @number_of_dollars   = donations.inject(0){|f,s| f+s.amount }
      @number_of_donations = donations.size
      @donation_or_donations   = @number_of_donations == 1 ? "donation" : "donations"

      hours = Hour.all
      @number_of_hours     = hours.size
      @number_of_children  = hours.collect{|h| h.user_id}.uniq.size
      @child_or_children   = @number_of_children == 1 ? "child" : "children"
      
      @is_logged_in = !session[:user].nil? 

      if @is_logged_in
        @user = User.find(session[:user])
      end
    end

end
