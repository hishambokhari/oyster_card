require "./lib/station.rb"

class OysterCard
    attr_reader :balance, :entry_station, :exit_station, :journey_history

    LIMIT = 90
    MIN_TICKET_VALUE = 1

    def initialize(station_class = Station)
        @balance =  0
        @station = station_class.new
        @entry_station = nil
        @exit_station = nil
        @journey_history = []

    end

    def top_up(amount)
        raise "limit of #{LIMIT} exceeded!" if @balance + amount > LIMIT
       @balance += amount 
    end

    def touch_in(station)
        raise "Insufficient funds!" if @balance < MIN_TICKET_VALUE
        @entry_station = station
    end

    def touch_out(station)
        deduct(MIN_TICKET_VALUE)
        @exit_station = station
        @journey_history << {entry_station: @entry_station, exit_station: @exit_station} 
        @entry_station = nil
        @exit_station = nil
    end

    

    def in_journey?
        @entry_station != nil
    end



    private

    def deduct(amount)
        @balance -= amount
    end
end

