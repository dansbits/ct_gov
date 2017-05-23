require_relative '../spec_helper'

describe CtGov::Publication do
  
  let(:raw_publication) { {
    'citation' => "Boumpas DT, Fessler BJ, Austin HA 3rd, Balow JE, Klippel JH, Lockshin MD. Systemic lupus erythematosus: emerging concepts. Part 2: Dermatologic and joint disease, the antiphospholipid antibody syndrome, pregnancy and hormonal therapy, morbidity and mortality, and pathogenesis. Ann Intern Med. 1995 Jul 1;123(1):42-53. Review.",
    'PMID' => '7762914'
  }}
  
  let(:publication) { CtGov::Publication.new(raw_publication) }
  
  describe '#citation' do
    subject { publication.citation }
    
    it { expect(subject).to eq "Boumpas DT, Fessler BJ, Austin HA 3rd, Balow JE, Klippel JH, Lockshin MD. Systemic lupus erythematosus: emerging concepts. Part 2: Dermatologic and joint disease, the antiphospholipid antibody syndrome, pregnancy and hormonal therapy, morbidity and mortality, and pathogenesis. Ann Intern Med. 1995 Jul 1;123(1):42-53. Review." }
  end
  
  describe '#pmid' do
    subject { publication.pmid }
    
    it { expect(subject).to eq "7762914" }
  end
end