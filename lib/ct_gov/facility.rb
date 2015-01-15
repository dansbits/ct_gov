module CtGov
  class Facility
    
    def initialize(raw_facility)
      @raw_facility = raw_facility
    end
    
    def name
      @raw_facility['name']
    end
    
    def address
      Address.new(@raw_facility['address']) unless @raw_facility['address'].nil?
    end
  end
end