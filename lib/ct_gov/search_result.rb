module CtGov
  class SearchResult

    attr_accessor :result

    def initialize(raw_result)
      @result = raw_result
    end

    def condition_summary
      @result['condition_summary']
    end

    def intervention_summary
      @result['intervention_summary']
    end

    def last_changed
      Date.parse(@result['last_changed'])
    end

    def nct_id
      @result['nct_id']
    end

    def order
      @result['order'].to_i
    end

    def score
      @result['score'].to_f
    end

    def status
      @result['status']
    end

    def title
      @result['title']
    end
  end
end