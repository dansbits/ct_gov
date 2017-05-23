require_relative '../spec_helper'

describe CtGov::Facility do
  let(:raw_facility) {
    Saxerator.parser('
    <facility>
      <name>National Institutes of Health Clinical Center, 9000 Rockville Pike</name>
      <address>
        <city>Bethesda</city>
        <state>Maryland</state>
        <zip>20892</zip>
        <country>United States</country>
      </address>
    </facility>').for_tag(:facility).first
  }

  let(:blank_raw_facility) {
    Saxerator.parser('<facility></facility>').for_tag(:facility).first
  }

  let(:facility) { CtGov::Facility.new(raw_facility) }
  let(:blank_facility) { CtGov::Facility.new(blank_raw_facility) }

  describe '#name' do
    subject { facility.name }
    
    it { expect(subject).to eq 'National Institutes of Health Clinical Center, 9000 Rockville Pike' }

    it 'returns nil when name is missing' do
      expect(blank_facility.name).to be_nil
    end
  end

  describe '#city' do
    subject { facility.city }

    it { expect(subject).to eq 'Bethesda' }

    it 'returns nil when city is missing' do
      expect(blank_facility.city).to be_nil
    end
  end

  describe '#state' do
    subject { facility.state }

    it { expect(subject).to eq 'Maryland' }

    it 'returns nil when state is missing' do
      expect(blank_facility.state).to be_nil
    end
  end

  describe '#zip' do
    subject { facility.zip }

    it { expect(subject).to eq '20892' }

    it 'returns nil when zip is missing' do
      expect(blank_facility.zip).to be_nil
    end
  end

  describe '#country' do
    subject { facility.country }

    it { expect(subject).to eq 'United States' }

    it 'returns nil when city is missing' do
      expect(blank_facility.country).to be_nil
    end

    context 'when address is present but not country' do
      let(:xml_doc) { Saxerator.parser('<facility><address><city>Boston</city></address></facility>').for_tag(:facility).first }

      subject { CtGov::Facility.new(xml_doc).country }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#address' do
    subject { facility.address }
    
    it 'returns an address' do
      expect(subject).to be_a CtGov::Address
    end
    
    it 'returns an address with the right values' do
      expect(subject.city).to eq 'Bethesda'
    end

    it 'returns nil when there is no address' do
      expect(blank_facility.country).to be_nil
    end
  end
end