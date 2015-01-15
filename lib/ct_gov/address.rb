module CtGov
  class Address
    
    def initialize(raw_address)
      @raw_address = raw_address
    end
    
    def city
      @raw_address['city']
    end
    
    def country
      @raw_address['country']
    end
    
    def state
      @raw_address['state']
    end
    
    def zip
      @raw_address['zip']
    end
  end
end