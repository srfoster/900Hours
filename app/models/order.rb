class Order < ActiveRecord::Base
  attr_accessible :user_id, :amount

	belongs_to :user

	has_many :paypal_logs

	after_create :get_paypal_token

  validates :amount, :numericality => { :only_integer => true }

	# Currently, this is just so I can use Mocha to
	# pass in a mock paypal object for testing.
	# Normally, we want to use the default paypal
	# method.
	def set_paypal(paypal)
		@paypal = paypal	
	end

	def get_paypal_token
		response = paypal.set_express_checkout(GLOBALS['SITE_URL']+"/orders/"+self.id.to_s+"&status=success",GLOBALS['SITE_URL']+"/orders/"+self.id.to_s+"&status=failure","#{amount}.00", {:VERSION => "82.0",:PAYMENTREQUEST_0_AMT=>"#{amount}.00", :L_PAYMENTREQUEST_0_ITEMCATEGORY0=>"Digital", :L_PAYMENTREQUEST_0_NAME0=>"Donation to non-profit: 900 Hours", :L_PAYMENTREQUEST_0_AMT0=>"#{amount}.00"})

		paypal_log("get_paypal_token, set_express_checkout: " + response.to_s)

		self.token = response["TOKEN"]
		self.save
	end

	def try_to_complete(payer_id)
		
		response = paypal.do_express_checkout_payment(self.token, "Sale", payer_id, "1.00", {:VERSION => "82.0",:PAYMENTREQUEST_0_AMT=>"1.00", :L_PAYMENTREQUEST_0_ITEMCATEGORY0=>"Digital", :L_PAYMENTREQUEST_0_NAME0=>"Final Chapter", :L_PAYMENTREQUEST_0_AMT0=>"1.00"})

		paypal_log("try_to_complete, do_express_checkout_payment: " + response.to_s)

		if(response["ACK"] == "Success")
			self.completed_at = Time.now
			save
		end

    Donation.create({:user_id=>user_id,:amount=>amount})

		response
	end

	def get_paypal_details
		response = paypal.get_express_checkout_details(token)

		last_log = paypal_logs.last

		if last_log.nil? or !last_log.message.include?("get_paypal_details, get_express_checkout_details")
			paypal_log("get_paypal_details, get_express_checkout_details: " + response.to_s)
		end

		response
	end

	def is_expired
		response = get_paypal_details 

		return response["ACK"] == "Failure" 
	end

	def is_complete
		if completed_at != nil
			return true
		end

		details = get_paypal_details
		if details["ACK"] == "Success" and details["PAYERID"] != nil
			try_to_complete(details["PAYERID"])
			return completed_at != nil
		end

		return false
	end

	def refresh_token
	    if(is_complete)
		    return
	    end

	    if(token.nil? or is_expired)
		    get_paypal_token #Saves a new token.
	    end
	end

	def paypal
	   if @paypal.nil?
		@paypal = Paypal.new(GLOBALS['PAYPAL_USERNAME'],GLOBALS['PAYPAL_PASSWORD'],GLOBALS['PAYPAL_SIG'], GLOBALS['PAYPAL_STATUS'])
	   end

	   return @paypal
	end

	def paypal_log(to_log)
		p = PaypalLog.new
		p.message = to_log
		p.order_id = self.id
		p.save
	end
end
