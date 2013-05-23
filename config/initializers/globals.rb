
GLOBALS = {}

if(ENV['APP_LOCATION'] == "http://aqueous-tundra-6832.herokuapp.com")
    GLOBALS["SITE_URL"] = "http://aqueous-tundra-6832.herokuapp.com"

    GLOBALS["PAYPAL_USERNAME"] = "wimbel_1327078279_biz_api1.gmail.com"
    GLOBALS["PAYPAL_PASSWORD"] = "1327078305" 
    GLOBALS["PAYPAL_SIG"] = "A6COWyU594pqfsumIgnTz34jI6zNA0p3HRfZqKL85zK3mB7TbFGxMsl0"
    GLOBALS["PAYPAL_URL"] = "https://www.sandbox.paypal.com"
    GLOBALS["PAYPAL_STATUS"] = :sandbox

    GLOBALS["FB_APP_ID"] = "465189880225165"
    GLOBALS["FB_SECRET"] = "15ad91e792b9a7b440b50f9d5503dd6d"
else
    GLOBALS["SITE_URL"] = "http://hours.dev"

    GLOBALS["PAYPAL_USERNAME"] = "wimbel_1327078279_biz_api1.gmail.com"
    GLOBALS["PAYPAL_PASSWORD"] = "1327078305" 
    GLOBALS["PAYPAL_SIG"] = "A6COWyU594pqfsumIgnTz34jI6zNA0p3HRfZqKL85zK3mB7TbFGxMsl0"
    GLOBALS["PAYPAL_URL"] = "https://www.sandbox.paypal.com"
    GLOBALS["PAYPAL_STATUS"] = :sandbox

    GLOBALS["FB_APP_ID"] = "514550045275215"
    GLOBALS["FB_SECRET"] = "8727015eb6b3ed7c3a8832067ccd2651"
end
