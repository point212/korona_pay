# frozen_string_literal: true

require_relative "korona_pay/version"
require_relative 'korona_pay/exchange_rate'

module KoronaPay
  class Error < StandardError; end

  extend ExchangeRate
end
