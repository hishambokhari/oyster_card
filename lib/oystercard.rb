class OysterCard
    attr_reader :balance
    LIMIT = 90
    MIN_TICKET_VALUE = 1
    def initialize
      @balance =  0
      @in_journey = false
    
    end

    def top_up(amount)
        raise "limit of #{LIMIT} exceeded!" if @balance + amount > LIMIT
       @balance += amount 
    end

    def touch_in
        raise "Insufficient funds!" if @balance < MIN_TICKET_VALUE
        @in_journey = true
    end

    def touch_out
        deduct(MIN_TICKET_VALUE)
        @in_journey = false
    end

    def in_journey?
        @in_journey
    end


    private

    def deduct(amount)
        @balance -= amount
    end
end

