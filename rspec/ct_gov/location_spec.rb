require_relative '../spec_helper'

describe CtGov::Location do
  
  let(:raw_location) { Saxerator.parser(
    '<location>
      <facility>
        <name>National Institutes of Health Clinical Center, 9000 Rockville Pike</name>
        <address>
          <city>Bethesda</city>
          <state>Maryland</state>
          <zip>20892</zip>
          <country>United States</country>
        </address>
      </facility>
      <status>Recruiting</status>
      <contact>
        <last_name>For more information at the NIH Clinical Center contact Patient Recruitment and Public Liaison Office (PRPL)</last_name>
        <phone>800-411-1222</phone>
        <phone_ext>TTY8664111010</phone_ext>
        <email>prpl@mail.cc.nih.gov</email>
      </contact>
      <contact_backup>
        <last_name>David Hyman, MD</last_name>
        <phone>646-888-4544</phone>
      </contact_backup>
      <investigator>
        <last_name>Matthew Fury, MD, PhD</last_name>
        <role>Principal Investigator</role>
      </investigator>
    </location>'
  ).for_tag(:location).first }
  
  let(:location) { CtGov::Location.new(raw_location) }
  
  describe '#contact' do
    subject { location.contact }
    
    it 'returns a contact' do
      expect(subject).to be_a CtGov::Contact
    end
    
    it 'sets the right values for the contact' do
      expect(subject.phone).to eq '800-411-1222'
    end
    
    context 'when there is no contact backup' do
      before { raw_location['contact'] = nil }
      
      it { expect(subject).to be_nil }
    end
  end
  
  describe '#contact_bacup' do
    subject { location.contact_backup }
    
    it 'returns a contact' do
      expect(subject).to be_a CtGov::Contact
    end
    
    it 'sets the right values for the contact' do
      expect(subject.phone).to eq '646-888-4544'
    end
    
    context 'when there is no contact backup' do
      before { raw_location['contact_backup'] = nil }
      
      it { expect(subject).to be_nil }
    end
  end
  
  describe '#investigators' do
    subject { location.investigators }
    
    it 'returns an array of investigators' do
      investigators = subject
      expect(subject).to be_a Array
      investigators.each { |i| expect(i).to be_a CtGov::Investigator }
    end
    
    it 'returns investigators with the right values' do
      investigator = subject.first
      expect(investigator.name).to eq 'Matthew Fury, MD, PhD'
    end
    
    context 'when there are multiple investigators' do
      before { raw_location['investigator'] = [{'last_name' => 'Homer Simpson'}, {'last_name' => 'Peter Griffin'}] }
      
      it 'returns both investigaors' do
        expect(subject.count).to eq 2
        
        expect(subject.first.name).to eq 'Homer Simpson'
        expect(subject.last.name).to eq 'Peter Griffin'
      end
    end
  end
  
  describe '#facility' do
    subject { location.facility }
    
    it 'returns a facility object' do 
      expect(subject).to be_a CtGov::Facility
    end
    
    it 'passes the right values to the facility' do
      facility = subject
      expect(facility.name).to eq 'National Institutes of Health Clinical Center, 9000 Rockville Pike'
      expect(facility.address.city).to eq 'Bethesda'
    end
    
    context 'when there is no facility' do
      before { raw_location['facility'] = nil }
      
      it { expect(subject).to be_nil }
    end
  end
  
  describe '#status' do
    subject { location.status }
    
    it { expect(subject).to eq 'Recruiting' }
  end
  
end