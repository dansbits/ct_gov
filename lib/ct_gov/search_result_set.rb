module CtGov
  class SearchResultSet

    include Enumerable

    def initialize(params, response_xml)
      @params = params
      @response_xml = response_xml

      @response_xml['clinical_study'] ||= []
    end

    def each
      @response_xml['clinical_study'].each do |result|
        yield SearchResult.new(result)
      end
    end

    def next_page
      new_params = @params
      new_params[:pg] = new_params[:pg] + 1

      CtGov.search(new_params)
    end

  end
end