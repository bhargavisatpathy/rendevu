class TwilioMessenger

  def initialize(to_phone, message)
    @to_phone = to_phone
    @message = message
  end

  def send_sms
    client = Twilio::REST::Client.new ENV['twilio_account_sid'], ENV['twilio_auth_token']
    client.messages.create from: '7206135838', to: @to_phone, body: @message#, status_callback: request.base_url + '/twilio/status'
  end
end
