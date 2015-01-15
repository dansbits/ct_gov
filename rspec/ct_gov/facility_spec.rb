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
  
  let(:facility) { CtGov::Facility.new(raw_facility) }
  
  describe '#name' do
    subject { facility.name }
    
    it { expect(subject).to eq 'National Institutes of Health Clinical Center, 9000 Rockville Pike' }
  end
  
  describe '#address' do
    subject { facility.address }
    
    it 'returns an address' do
      expect(subject).to be_a CtGov::Address
    end
    
    it 'returns an address with the right values' do
      expect(subject.city).to eq 'Bethesda'
    end
  end
end