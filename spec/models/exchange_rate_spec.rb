require_relative '../rails_helper'

RSpec.describe ExchangeRate do
  describe '.get_rate' do 
    before do
      ExchangeRate.new(currency_code: 'USD', rate: 1).save
      ExchangeRate.new(currency_code: 'AUD', rate: 0.5).save
    end

    it 'returns a rate converting the two currencies' do
      expect(ExchangeRate.get_rate('USD', 'AUD')).to eq(0.5)
      expect(ExchangeRate.get_rate('AUD', 'USD')).to eq(2)
    end

    it 'returns nil for non existent code' do
      expect(ExchangeRate.get_rate('USD', 'FOO')).to be_nil
      expect(ExchangeRate.get_rate('FOO', 'USD')).to be_nil
    end
  end

  describe '.get_codes' do
    before do
      ExchangeRate.new(currency_code: 'USD', rate: 1).save
      ExchangeRate.new(currency_code: 'AUD', rate: 1).save
    end

    it 'returns an array of codes' do
      expect(ExchangeRate.get_codes).to eq(['USD', 'AUD'])
    end
  end
end