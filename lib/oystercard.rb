require "./lib/station.rb"

class OysterCard
    attr_reader :balance, :entry_station

    LIMIT = 90
    MIN_TICKET_VALUE = 1

    def initialize(station_class = Station)
        @balance =  0
        @station = station_class.new
        @entry_station 
    end

    def top_up(amount)
        raise "limit of #{LIMIT} exceeded!" if @balance + amount > LIMIT
       @balance += amount 
    end

    def touch_in(station)
        raise "Insufficient funds!" if @balance < MIN_TICKET_VALUE
        @entry_station = station
    end

    def touch_out
        deduct(MIN_TICKET_VALUE)
        @entry_station = nil
    end

    def in_journey?
        @entry_station != nil
    end


    private

    def deduct(amount)
        @balance -= amount
    end
end

