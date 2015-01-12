module CtGov
  class Investigator
    
    def initialize(raw_investigator)
      @raw_investigator = raw_investigator
    end
    
    def affiliation
      @raw_investigator['affiliation']
    end
    
    def name
      @raw_investigator['last_name']
    end
    
    def role
      @raw_investigator['role']
    end
    
  end
end