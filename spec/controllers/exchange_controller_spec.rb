require_relative '../rails_helper'

RSpec.describe ExchangeController do
  describe '#convert' do
    before do
      ExchangeRate.new(currency_code: 'USD', rate: 1).save
      ExchangeRate.new(currency_code: 'AUD', rate: 0.5).save
    end

    it 'converts a dollar amount' do
      post :convert, params: { input_currency: 'USD', output_currency: 'AUD', amount: 10 }
      expect(response.body).to eq("{\"result\":\"5.00\"}")
    end

    it 'returns failure for invalid code' do
      post :convert, params: { input_currency: 'USD', output_currency: 'FOO', amount: 10 }
      expect(response.body).to eq("{\"result\":\"failed\"}")
    end
  end
end