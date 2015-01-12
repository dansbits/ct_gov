require_relative '../spec_helper'

describe CtGov::Investigator do
  
  let(:raw_data) { 
    '<overall_official>
      <last_name>Sarfaraz A Hasni, M.D.</last_name>
      <role>Principal Investigator</role>
      <affiliation>National Institute of Arthritis and Musculoskeletal and Skin Diseases (NIAMS)</affiliation>
    </overall_official>' 
  }
  
  let(:investigator) { CtGov::Investigator.new(Saxerator.parser(raw_data).for_tag(:overall_official).first) }
  
  describe '#name' do
    subject { investigator.name }
    
    it { expect(subject).to eq 'Sarfaraz A Hasni, M.D.' }
  end
  
  describe '#role' do
    subject { investigator.role }
    
    it { expect(subject).to eq 'Principal Investigator' }
  end
  
  describe '#affiliation' do
    subject { investigator.affiliation }
    
    it { expect(subject).to eq 'National Institute of Arthritis and Musculoskeletal and Skin Diseases (NIAMS)' }
  end
end