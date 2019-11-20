require 'oystercard'


describe OysterCard do

    LIMIT = OysterCard::LIMIT
    MIN_TICKET_VALUE = OysterCard::MIN_TICKET_VALUE
    let(:station)  {double :station}
    let(:entry_station) {double :station}
    let(:exit_station) {double :station}
    let(:journey) {{entry_station: entry_station, exit_station: exit_station} }

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

    describe "#in_journey" do

        it "should return true if touched in" do
            subject.top_up(MIN_TICKET_VALUE)
            subject.touch_in(entry_station)
            expect( subject.in_journey?).to eq(true)
        end

        it "should return false if touched out" do
            subject.touch_out(exit_station)
            expect( subject.in_journey?).to eq(false)
        end
    end



    describe "#touch_in" do
        it "raises an error if balance less than minimum ticket price" do
            message = "Insufficient funds!"
            expect{ subject.touch_in(station) }.to raise_error(message)
        end

        it "remembers the station" do
            subject.top_up(MIN_TICKET_VALUE)
            subject.touch_in(entry_station)
            expect(subject.entry_station).to eq entry_station
        end
    end
    describe "#touch_out" do

        it "deduct the minimum ticket price from the balance" do
            expect{ subject.touch_out(exit_station) }.to change{ subject.balance}.by -MIN_TICKET_VALUE
        end

        it "changes entry_station to nil once touched out" do
            subject.top_up(MIN_TICKET_VALUE)
            subject.touch_in(entry_station)
            subject.touch_out(exit_station)
            expect(subject.entry_station).to eq nil
        end
        it "should add entry and exit station to journey history" do
        subject.top_up(MIN_TICKET_VALUE)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journey_history).to include journey
        end

    end
    describe "#journey_history" do
        it "should be empty when using a new card" do
        expect(subject.journey_history).to be_empty
        end

        it "should only contain one journey when card has touched in and out once" do
        subject.top_up(MIN_TICKET_VALUE)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journey_history.length).to eq 1
        end
    end


end
