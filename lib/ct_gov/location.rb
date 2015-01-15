module CtGov
  class Location
    
    def initialize(raw_location)
      @raw_location = raw_location
    end
    
    def contact
      Contact.new(@raw_location['contact']) unless @raw_location['contact'].nil?
    end
    
    def contact_backup
      Contact.new(@raw_location['contact_backup']) unless @raw_location['contact_backup'].nil?
    end
    
    def facility
      Facility.new(@raw_location['facility']) unless @raw_location['facility'].nil?
    end
    
    def investigators
      [@raw_location['investigator']].flatten.map do |investigator|
        Investigator.new(investigator) unless investigator.nil?
      end
    end
    
    def status
      @raw_location['status']
    end
  end
end