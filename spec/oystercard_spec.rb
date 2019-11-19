require 'oystercard'


describe OysterCard do

    it '#balance ' do
        expect(subject.balance).to eql(0)
    end

    describe '#top_up' do
        it { is_expected.to respond_to(:top_up).with(1).argument }

        
        it "should top up the balance" do
            expect{ subject.top_up(1) }.to change { subject.balance }.by 1
        end
        it "should raise an error when the max limit is exceeded" do
          LIMIT = OysterCard::LIMIT  
          expect{ subject.top_up(95)}.to raise_error("limit of #{LIMIT} exceeded!")

        end
        

    end    

    describe "#deduct" do
        it "deducts 20 from the balance" do
            subject.top_up(30)
            expect{ subject.deduct(20) }.to change { subject.balance }.by -20
        end
    end

end

