class OysterCard
    attr_reader :balance
LIMIT = 90
    def initialize
      @balance =  0
      @in_journey = false
    
    end

    def top_up(amount)
        raise "limit of #{LIMIT} exceeded!" if @balance + amount > LIMIT
       @balance += amount 
    end

    def deduct(amount)
        @balance -= amount
    end

    def touch_in
        @in_journey = true
    end

    def in_journey?
        @in_journey
    end

    def touch_out
        @in_journey = false
    end
end

