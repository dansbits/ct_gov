module CtGov
  class Facility
    
    def initialize(raw_facility)
      @raw_facility = raw_facility
    end
    
    def name
      @raw_facility['name'].to_s if @raw_facility['name']
    end

    def city
      address.city if address
    end

    def country
      address.country if address
    end

    def state
      address.state if address
    end

    def zip
      address.zip if address
    end

    def address
      Address.new(@raw_facility['address']) unless @raw_facility['address'].nil?
    end
  end
end