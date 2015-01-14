module CtGov
  class ClinicalTrial
    def initialize(raw_trial)
      @raw_trial = raw_trial
    end
    
    def healthy_volunteers?
      @raw_trial['eligibility']['accepts_healthy_volunteers'] == 'Accepts Healthy Volunteers'
    end
    
    def nctid
      @raw_trial['id_info']['nct_id']
    end
    
    def brief_title
      @raw_trial['brief_title']
    end
    
    def completion_date
      Date.parse(@raw_trial['completion_date'])
    end
    
    def official_title
      @raw_trial['official_title']
    end
    
    def overall_contacts
      contacts = []
      
      contacts.push Contact.new(@raw_trial['overall_contact']) if @raw_trial['overall_contact']
      
      [@raw_trial['overall_contact_backup']].flatten.each do |contact|
        contacts.push Contact.new(contact)
      end
      
      contacts
    end
    
    def overall_official
      CtGov::Investigator.new(@raw_trial['overall_official']) unless @raw_trial['overall_official'].nil?
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
    
    def min_age
      @raw_trial['eligibility']['minimum_age']
    end
    
    def max_age
      @raw_trial['eligibility']['maximum_age']
    end
    
    def overall_status
      @raw_trial['overall_status']
    end
    
    def publications
      @raw_trial['reference'].map do |reference|
        Publication.new(reference)
      end
    end
    
    def primary_completion_date
      Date.parse(@raw_trial['primary_completion_date'])
    end
    
    def start_date
      Date.parse(@raw_trial['start_date'])
    end
    
    def study_type
      @raw_trial['study_type']
    end
  end
end
