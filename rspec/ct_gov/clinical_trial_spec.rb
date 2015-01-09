require_relative '../spec_helper'

describe CtGov::ClinicalTrial do
  
  let(:raw_trial) { Saxerator.parser(File.read('rspec/data/sample_trial.xml')).for_tag(:clinical_study).first }
  
  let(:study) { described_class.new(raw_trial) }
  
  describe '#nctid' do
    subject { study.nctid }
    
    it { expect(subject).to eq 'NCT00001372' }
  end
  
  describe '#brief_title' do
    subject { study.brief_title }
    
    it { expect(subject).to eq 'Study of Systemic Lupus Erythematosus' }
  end
  
  describe '#official_title' do
    subject { study.official_title }
    
    it { expect(subject).to eq 'Studies of the Pathogenesis and Natural History of Systemic Lupus Erythematosus (SLE)' }
  end
  
  describe '#brief_summary' do
    subject { study.brief_summary }
    
    it { expect(subject).to eq raw_trial['brief_summary']['textblock'].strip }
  end
  
  describe '#detailed_description' do
    subject { study.detailed_description }
    
    it { expect(subject).to eq raw_trial['detailed_description']['textblock'].strip }
  end
  
  describe '#overall_status' do
    subject { study.overall_status }
    
    it { expect(subject).to eq 'Recruiting' }
  end
  
  describe '#start_date' do
    subject { study.start_date }
    
    it { expect(subject).to eq Date.parse('1994-02-01') }
  end
  
  describe '#study_type' do
    subject { study.study_type }
    
    it { expect(subject).to eq 'Observational' }
  end
  
  describe '#eligibility_description' do
    subject { study.eligibility_description }
    
    it { expect(subject).to eq raw_trial['eligibility']['criteria']['textblock'] }
  end
  
  describe '#publications' do
    subject { study.publications }
    
    it { expect(subject.first).to be_a CtGov::Publication }
    
    it { expect(subject.count).to eq 3 }
    
    it { expect(subject.first.pmid).to eq '7762914' }
  end
end