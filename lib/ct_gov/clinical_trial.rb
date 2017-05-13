module CtGov
  class ClinicalTrial

    attr_accessor :raw_trial

    def initialize(raw_trial)
      @raw_trial = raw_trial
    end
    
    def healthy_volunteers?
      return nil if @raw_trial['eligibility'].nil?

      healthy_volunteers = @raw_trial['eligibility']['healthy_volunteers']

      if healthy_volunteers == 'Accepts Healthy Volunteers'
        return true
      elsif healthy_volunteers == 'No'
        return false
      end
    end
    
    def nctid
      @raw_trial['id_info']['nct_id']
    end
    
    def brief_title
      squash_string(@raw_trial['brief_title'])
    end
    
    def browse_conditions
      @raw_trial['condition_browse'].nil? ? [] : [@raw_trial['condition_browse']['mesh_term']].flatten
    end
    
    def completion_date
      Date.parse(@raw_trial['completion_date']) if @raw_trial['completion_date']
    end
    
    def browse_interventions
      @raw_trial['intervention_browse'].nil? ? [] : [@raw_trial['intervention_browse']['mesh_term']].flatten
    end

    def gender
      squash_string @raw_trial['eligibility']['gender'] if @raw_trial['eligibility']
    end

    def self.find_by_nctid(nctid)
      uri = ::URI.parse("#{CtGov::BASE_URL}/ct2/show/#{nctid}#{CtGov::BASE_OPTIONS}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
  
      ClinicalTrial.new(Saxerator.parser(response.body).for_tag(:clinical_study).first) if response.code == "200"
    end

    def firstreceived_date
      Date.parse(@raw_trial['firstreceived_date'])
    end

    def lastchanged_date
      Date.parse(@raw_trial['lastchanged_date'])
    end

    def keywords
      @raw_trial['keyword'].nil? ? [] : [@raw_trial['keyword']].flatten
    end
    
    def locations
      if @raw_trial['location'].nil?
        []
      else
        [@raw_trial['location']].flatten.map do |loc|
          Location.new(loc) unless loc.nil?
        end
      end
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
      @raw_trial['brief_summary']['textblock'].strip if @raw_trial['brief_summary']
    end
    
    def detailed_description
      @raw_trial['detailed_description']['textblock'].strip if @raw_trial['detailed_description']
    end
    
    def eligibility_description
      if @raw_trial['eligibility'] && @raw_trial['eligibility']['criteria']
        squash_string(@raw_trial['eligibility']['criteria']['textblock'].strip)
      end
    end
    
    def min_age
      age_string = @raw_trial['eligibility']['minimum_age'] if @raw_trial['eligibility']

      if age_string == 'N/A'
        return nil
      else
        return age_string
      end
    end
    
    def max_age
      age_string = @raw_trial['eligibility']['maximum_age']  if @raw_trial['eligibility']

      if age_string == 'N/A'
        return nil
      else
        return age_string
      end
    end
    
    def overall_status
      @raw_trial['overall_status']
    end
    
    def publications
      if @raw_trial['reference'].nil?
        []
      else
        [@raw_trial['reference']].flatten.map do |reference|
          Publication.new(reference)
        end
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

    def why_stopped
      squash_string(@raw_trial['why_stopped'])
    end

    private

    def squash_string(string)
      string == "" ? nil : string
    end
  end
end
