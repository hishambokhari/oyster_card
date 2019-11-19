require 'oystercard'


describe OysterCard do

    LIMIT = OysterCard::LIMIT  
    MIN_TICKET_VALUE = OysterCard::MIN_TICKET_VALUE

    it '#balance ' do
        expect(subject.balance).to eql(0)
    end

    describe '#top_up' do
        it { is_expected.to respond_to(:top_up).with(1).argument }

        
        it "should top up the balance" do
            expect{ subject.top_up(1) }.to change { subject.balance }.by 1
        end
        it "should raise an error when the max limit is exceeded" do
          
          expect{ subject.top_up(95)}.to raise_error("limit of #{LIMIT} exceeded!")

        end
        

    end    

    describe "#deduct" do
        it "deducts 20 from the balance" do
            subject.top_up(30)
            expect{ subject.deduct(20) }.to change { subject.balance }.by -20
        end
    end

    describe "#in_journey" do
        
        it "should return true if touched in" do
            subject.top_up(MIN_TICKET_VALUE)
            subject.touch_in
            expect( subject.in_journey?).to eq(true)
        end

        it "should return false if touched out" do
            subject.touch_out
            expect( subject.in_journey?).to eq(false)  
        end 
    end

    describe "#touch_in" do
        it "raises an error if balance less than minimum ticket price" do
            message = "Insufficient funds!"
            expect{ subject.touch_in }.to raise_error(message)
        end
    end



end



