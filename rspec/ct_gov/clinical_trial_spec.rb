require_relative '../spec_helper'

describe CtGov::ClinicalTrial do
  
  let(:raw_trial) { Saxerator.parser(File.read('rspec/data/sample_trial.xml')).for_tag(:clinical_study).first }
  
  let(:study) { described_class.new(raw_trial) }
  
  
  describe '#brief_summary' do
    subject { study.brief_summary }
    
    it { expect(subject).to eq raw_trial['brief_summary']['textblock'].strip }
  end
  
  describe '#brief_title' do
    subject { study.brief_title }
    
    it { expect(subject).to eq 'Study of Systemic Lupus Erythematosus' }
  end
  
  describe '#completion_date' do
    subject { study.completion_date }
    
    it { expect(subject).to eq Date.parse('2015-07-01') }
  end
  
  describe '#detailed_description' do
    subject { study.detailed_description }
    
    it { expect(subject).to eq raw_trial['detailed_description']['textblock'].strip }
  end
  
  describe '#eligibility_description' do
    subject { study.eligibility_description }
    
    it { expect(subject).to eq raw_trial['eligibility']['criteria']['textblock'] }
  end
  
  describe '#healthy_volunteers?' do
    subject { study.healthy_volunteers? }
    
    context 'when the source value is "Accepts Healthy Volunteers"' do
      before { raw_trial['eligibility']['accepts_healthy_volunteers'] = 'Accepts Healthy Volunteers' }
      
      it { expect(subject).to eq true }
    end
    
    context 'when the source value is anything else' do
      before { raw_trial['eligibility']['accepts_healthy_volunteers'] = 'No way!' }
      
      it { expect(subject).to eq false }
    end
  end
  
  describe '#max_age' do
    subject { study.max_age }
    
    it { expect(subject).to eq raw_trial['eligibility']['maximum_age'] }
  end
  
  describe '#min_age' do
    subject { study.min_age }
    
    it { expect(subject).to eq raw_trial['eligibility']['minimum_age'] }
  end
  
  describe '#nctid' do
    subject { study.nctid }
    
    it { expect(subject).to eq 'NCT00001372' }
  end
  
  describe '#official_title' do
    subject { study.official_title }
    
    it { expect(subject).to eq 'Studies of the Pathogenesis and Natural History of Systemic Lupus Erythematosus (SLE)' }
  end
  
  describe '#overall_contacts' do
    subject { study.overall_contacts }
    
    it { expect(subject.count).to eq 2 }
    
    it { expect(subject.first).to be_a CtGov::Contact }
    
    it { expect(subject.first.name).to eq 'Elizabeth Joyal, R.N.' }
  end
  
  describe '#overall_status' do
    subject { study.overall_status }
    
    it { expect(subject).to eq 'Recruiting' }
  end
  
  describe '#overall_official' do
    subject { study.overall_official }
    
    it { expect(subject).to be_a CtGov::Investigator }
    
    it { expect(subject.name).to eq 'Sarfaraz A Hasni, M.D.' }
    
    context 'when overall official is not present' do
      before { raw_trial.delete('overall_official') }
      
      it { expect(subject).to be_nil }
    end
  end
  
  describe '#primary_completion_date' do
    subject { study.primary_completion_date }
    
    it { expect(subject).to eq Date.parse('2015-08-01') }
  end
  
  describe '#publications' do
    subject { study.publications }
    
    it { expect(subject.first).to be_a CtGov::Publication }
    
    it { expect(subject.count).to eq 3 }
    
    it { expect(subject.first.pmid).to eq '7762914' }
  end
  
  describe '#start_date' do
    subject { study.start_date }
    
    it { expect(subject).to eq Date.parse('1994-02-01') }
  end
  
  describe '#study_type' do
    subject { study.study_type }
    
    it { expect(subject).to eq 'Observational' }
  end
end