require_relative 'spec_helper'

describe CtGov do
  
  describe '#find_by_nctid' do
    
    let(:nctid) { 'NCT01288560' }
    
    subject { CtGov.find_by_nctid(nctid) } 
    
    it 'returns a clinical trial object' do
      expect(subject).to be_a CtGov::ClinicalTrial
    end
  end
  
end