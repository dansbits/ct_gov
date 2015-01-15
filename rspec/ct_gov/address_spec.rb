require_relative '../spec_helper'

describe CtGov::Address do
  
  let(:raw_address) { 
    Saxerator.parser('<address>
        <city>Bethesda</city>
        <state>Maryland</state>
        <zip>20892</zip>
        <country>United States</country>
      </address>').for_tag(:address).first 
  }
      
  let(:address) { CtGov::Address.new(raw_address) }
  
  describe '#city' do
    subject { address.city }
    
    it { expect(subject).to eq 'Bethesda' }
  end
  
  describe '#state' do
    subject { address.state }
    
    it { expect(subject).to eq 'Maryland' }
  end
  
  describe '#zip' do
    subject { address.zip }
    
    it { expect(subject).to eq '20892' }
  end
  
  describe '#country' do
    subject { address.country }
    
    it { expect(subject).to eq 'United States' }
  end
  
end