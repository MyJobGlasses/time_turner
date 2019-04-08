RSpec.describe TimeTurner do
  subject(:time_turner) { described_class.new(seed) }

  let(:seed) { rand(0..100_000) }

  it 'has a version number' do
    expect(TimeTurner::VERSION).not_to be nil
  end

  describe '#big_bang' do
    let(:big_bang) { time_turner.big_bang }

    it 'generates a valid time' do
      expect(time_turner.big_bang).to be_between(Time.utc(1970), Time.utc(2420))
    end
  end

  describe '#rand' do
    it 'generates a random time within the default range' do
      high = 0
      low = 1

      100_000.times do
        val = time_turner.rand
        if val > high
          high = val
        elsif val < low
          low = val
        end
      end

      expect(high).to be <= 1
      expect(low).to be >= 0
      expect(high).not_to eq(low)
      expect(time_turner.rand).to be_between(0, 1)
    end

    it 'generates a random time within the valid range' do
      expect(time_turner.rand(1.month.ago..Time.now)).to be_between(1.month.ago, Time.now)
    end

    it 'generates a random time within the specified range' do
      expect(time_turner.rand(2..4)).to be_between(2, 4)
    end
  end
end
