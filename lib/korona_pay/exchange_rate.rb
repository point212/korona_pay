require_relative 'client'

module KoronaPay::ExchangeRate
    def exchange_rate(from, to)
      KoronaPay::Client.tariffs('RUS', 810, 'GEO', '981', 100)[:exchange_rate]
    end
end



