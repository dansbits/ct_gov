require_relative 'spec_helper'

describe CtGov do
  
  describe '#find_by_nctid' do
    
    let(:nctid) { 'NCT01288560' }
    
    subject { CtGov.find_by_nctid(nctid) } 
    
    it 'returns a clinical trial object' do
      expect(subject).to be_a CtGov::ClinicalTrial
    end

  end

  describe '#search' do

    subject { CtGov.search(term: "diabetes") }

    it "queries clinicaltrials.gov with the specified criteria" do
      resultset = subject

      expect(resultset).to be_a CtGov::SearchResultSet

      expect(resultset.first.order).to eq 1
    end
  end
  
end