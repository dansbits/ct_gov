module CtGov
  class Publication
    
    def initialize(raw_publication)
      @raw_publication = raw_publication
    end
    
    def citation
      @raw_publication['citation']
    end
    
    def pmid
      @raw_publication['PMID']
    end
    
  end
end