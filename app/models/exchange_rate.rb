class ExchangeRate < ApplicationRecord
  API_URL = 'https://open.er-api.com/v6/latest/USD'

  def self.get_rate(input_code, output_code)
    self.update_rates if self.needs_updating?

    input_rate = ExchangeRate.where(currency_code: input_code).first
    output_rate = ExchangeRate.where(currency_code: output_code).first
    return nil if input_rate.nil? || output_rate.nil?

    output_rate.rate/input_rate.rate
  end

  def self.get_codes
    self.update_rates if self.needs_updating?

    ExchangeRate.all.pluck(:currency_code)
  end

  private 
  
  def self.needs_updating?
    # Older than 24 hours, check the most recently updated record in case some currencies drop out of the dataset etc.
    # THe rates only update once every 24 hours as per the doc (https://open.exchangerate-api.com/v6/latest)
    DateTime.now.to_i - (ExchangeRate.maximum(:updated_at) || 0).to_i > 86400
  end

  def self.update_rates
    resp = HTTParty.get(API_URL)
    data = JSON.parse(resp.body)
    return unless data['result'] == 'success'

    data['rates'].each do |code, rate|
      er = ExchangeRate.where(currency_code: code).first_or_create
      er.update!(rate: rate)
    end
  end
end
