module CtGov
  class ClinicalTrial
    def initialize(raw_trial)
      @raw_trial = raw_trial
    end
    
    def nctid
      @raw_trial['id_info']['nct_id']
    end
    
    def brief_title
      @raw_trial['brief_title']
    end
    
    def official_title
      @raw_trial['official_title']
    end
    
    def brief_summary
      @raw_trial['brief_summary']['textblock'].strip
    end
    
    def detailed_description
      @raw_trial['detailed_description']['textblock'].strip
    end
    
    def eligibility_description
      @raw_trial['eligibility']['criteria']['textblock']
    end
    
    def overall_status
      @raw_trial['overall_status']
    end
    
    def publications
      @raw_trial['reference'].map do |reference|
        Publication.new(reference)
      end
    end
    
    def start_date
      Date.parse(@raw_trial['start_date'])
    end
    
    def study_type
      @raw_trial['study_type']
    end
  end
end
