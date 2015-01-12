require_relative '../spec_helper'

describe CtGov::Contact do
  
  let(:raw_data) { '
    <contact>
      <last_name>Elizabeth Joyal, R.N.</last_name>
      <phone>(301) 435-4489</phone>
      <phone_ext>321</phone_ext>
      <email>ejoyal@mail.cc.nih.gov</email>
    </contact>'
  }
  
  let(:contact) { CtGov::Contact.new(Saxerator.parser(raw_data).for_tag(:contact).first) }
  
  describe '#name' do
    subject { contact.name }
    
    it { expect(subject).to eq 'Elizabeth Joyal, R.N.' }
  end
  
  describe '#phone' do
    subject { contact.phone }
    
    it { expect(subject).to eq '(301) 435-4489' }
  end
  
  describe '#phone_extension' do
    subject { contact.phone_extension }
    
    it { expect(subject).to eq '321' }
  end
  
  describe '#email' do
    subject { contact.email }
    
    it { expect(subject).to eq 'ejoyal@mail.cc.nih.gov' }
  end
  
end