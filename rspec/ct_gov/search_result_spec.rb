require_relative "../spec_helper"

describe SearchResult do

  let(:sample_resultset) { Saxerator.parser(File.read('rspec/data/sample_result.xml')).for_tag(:search_results).first }

  let(:result) { described_class.new(sample_resultset['clinical_study'].first) }

  describe "#order" do
    it { expect(result.order).to eq 1 }
  end

  describe "#score" do
    it { expect(result.score).to eq 0.99037 }
  end

  describe "#nct_id" do
    it { expect(result.nct_id).to eq 'NCT01665521' }
  end

  describe "#title" do
    it { expect(result.title).to eq "Efficacy Evaluation of the HEART Pathway in Emergency Department Patients With Acute Chest Pain" }
  end

  describe "#status" do
    it { expect(result.status).to eq "Active, not recruiting" }
  end

  describe "#condition_summary" do
    it { expect(result.condition_summary).to eq "Acute Coronary Syndrome; Chest Pain" }
  end

  describe "#intervention_summary" do
    it { expect(result.intervention_summary).to eq "Other: HEART Pathway" }
  end

  describe "#last_changed" do
    it { expect(result.last_changed).to eq Date.parse("December 8, 2015") }
  end
end