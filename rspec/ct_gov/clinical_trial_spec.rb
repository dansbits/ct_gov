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
  
  describe '#browse_conditions' do
    subject { study.browse_conditions }
    
    it 'returns an array of all browse conditions' do
      expect(subject.count).to eq 2
      
      expect(subject).to eq ['Lupus Erythematosus, Systemic', 'Nephritis']
    end
    
    context 'when there are no browse_conditions' do
      before { raw_trial.delete('condition_browse') }
      
      it { expect(subject).to eq [] }
    end
  end
  
  describe '#detailed_description' do
    subject { study.detailed_description }
    
    it { expect(subject).to eq raw_trial['detailed_description']['textblock'].strip }
  end
  
  describe '#eligibility_description' do
    subject { study.eligibility_description }
    
    it { expect(subject).to eq raw_trial['eligibility']['criteria']['textblock'].strip }
  end

  describe '#firstreceived_date' do
    subject { study.firstreceived_date }

    it { expect(subject).to eq Date.parse(raw_trial['firstreceived_date']) }
  end

  describe '#gender' do
    subject { study.gender }

    it { expect(subject).to eq 'Both' }
  end

  describe '#lastchanged_date' do
    subject { study.lastchanged_date }

    it { expect(subject).to eq Date.parse(raw_trial['lastchanged_date']) }
  end

  describe '#healthy_volunteers?' do
    subject { study.healthy_volunteers? }
    
    context 'when the source value is "Accepts Healthy Volunteers"' do
      before { raw_trial['eligibility']['healthy_volunteers'] = 'Accepts Healthy Volunteers' }
      
      it { expect(subject).to eq true }
    end
    
    context 'when the source value is "No"' do
      before { raw_trial['eligibility']['healthy_volunteers'] = 'No' }
      
      it { expect(subject).to eq false }
    end

    context 'when the source value is nil' do
      before { raw_trial['eligibility']['healthy_volunteers'] = nil }

      it { expect(subject).to be_nil }
    end

    context 'when the eligibility element does not exist' do
      before { raw_trial['eligibility'] = nil }

      it { expect(subject).to be_nil }
    end
  end
  
  describe '#browse_interventions' do
    subject { study.browse_interventions }
    
    it 'returns an array of all browse conditions' do
      expect(subject.count).to eq 2
      
      expect(subject).to eq ['Methylprednisolone', 'Mycophenolic']
    end
    
    context 'when there are no browse_conditions' do
      before { raw_trial.delete('intervention_browse') }
      
      it { expect(subject).to eq [] }
    end
  end
  
  describe '.find_by_nctid' do
    let(:nctid) { 'NCT01288560' }
    
    subject { CtGov.find_by_nctid(nctid) } 
    
    it 'returns a clinical trial object' do
      expect(subject).to be_a CtGov::ClinicalTrial
    end
    
    it 'uses the right values' do
      expect(subject.brief_title).to eq 'IMAGE-HF Project I-A: Cardiac Imaging in Ischemic Heart Failure (AIMI-HF)'
    end
  end
  
  describe '#keywords' do
    subject { study.keywords }
    
    let(:expected_keywords) {[
      "Systemic Lupus Erythematosus",
      "Natural History",
      "Lupus Nephritis",
      "Lupus",
      "Systemic Lupus",
      "SLE"
    ]}
    
    it 'returns an array of all keywords for the study' do
      expect(subject.count).to eq 6
      
      expect(subject - expected_keywords).to eq []
    end
  end
  
  describe '#locations' do
    subject { study.locations }
    
    it 'returns an array of locations' do
      expect(subject.first).to be_a CtGov::Location
    end
    
    it 'sets the right values for the locations' do
      loc = subject.first
      
      expect(loc.status).to eq 'Recruiting'
    end
    
    context 'when no location is present' do
      before { raw_trial.delete('location') }
      
      it { expect(subject).to eq [] }
    end
    
    context 'when there are multiple locations' do
      before { raw_trial['location'] = [{'status' => 'Recruiting'},{'status' => 'Not Recruiting'}] }
      
      it 'returns all locations' do
        expect(subject.count).to eq 2
        
        expect(subject.first.status).to eq 'Recruiting'
        expect(subject.last.status).to eq 'Not Recruiting'
      end
    end
  end
  
  describe '#max_age' do
    subject { study.max_age }
    
    it { expect(subject).to eq '30 Years' }
  end
  
  describe '#min_age' do
    subject { study.min_age }
    
    it { expect(subject).to eq '18 Years' }
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
    
    context 'when there are no publications' do
      before { raw_trial.delete('reference') }
      
      it { expect(subject).to eq [] }
    end
  end
  
  describe '#start_date' do
    subject { study.start_date }
    
    it { expect(subject).to eq Date.parse('1994-02-01') }
  end
  
  describe '#study_type' do
    subject { study.study_type }
    
    it { expect(subject).to eq 'Observational' }
  end

  describe '#why_stopped' do
    subject { study.why_stopped }

    it { expect(subject).to eq 'Replaced by another study.' }
  end
end