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
           
        

    end    
end

