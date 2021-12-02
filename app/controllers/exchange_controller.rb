class ExchangeController < ApplicationController
  def convert
    rate = ExchangeRate.get_rate(params[:input_currency], params[:output_currency])
    result = rate.nil? ? 'failed' : sprintf('%.2f', rate * params[:amount].to_f)
    render json: { result: result }
  end

  def currency_codes
    render json: { data: ExchangeRate.get_codes }
  end
end
