module CtGov
  class SearchResult

    attr_accessor :result

    def initialize(raw_result)
      @result = raw_result
    end

    def condition_summary
      @result['condition_summary'].to_s
    end

    def intervention_summary
      @result['intervention_summary'].to_s
    end

    def last_changed
      Date.parse(@result['last_changed'].to_s)
    end

    def nct_id
      @result['nct_id'].to_s
    end

    def order
      @result['order'].to_i
    end

    def score
      @result['score'].to_f
    end

    def status
      @result['status'].to_s
    end

    def title
      @result['title'].to_s
    end
  end
end