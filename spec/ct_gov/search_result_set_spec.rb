require_relative "../spec_helper"

describe CtGov::SearchResultSet do

  let(:sample_result) { Saxerator.parser(File.read('spec/data/sample_result.xml')).for_tag(:search_results).first }

  describe "#each" do

    it "iterates the resultset" do
      resultset = described_class.new({ term: "diabetes" }, sample_result)

      count = 0

      resultset.each do |result|
        count = count + 1
        expect(result).to be_a CtGov::SearchResult
      end

      expect(count).to eq 20
    end

  end

  describe "#first" do

    it "returns the first result" do
      resultset = described_class.new({ term: "diabetes" }, sample_result)
      result = resultset.first

      expect(result.nct_id).to eq 'NCT01665521'
    end
  end

  describe "#next_page" do

    it "gets the next page of results" do
      resultset = described_class.new({ term: "diabetes", pg: 1 }, sample_result)

      expect(CtGov).to receive(:search).with({ term: "diabetes", pg: 2 })

      resultset.next_page
    end

  end
end