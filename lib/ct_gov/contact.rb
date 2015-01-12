module CtGov
  class Contact
    
    def initialize(raw_contact)
      @raw_contact = raw_contact
    end
    
    def name
      @raw_contact['last_name']
    end
    
    def phone
      @raw_contact['phone']
    end
    
    def phone_extension
      @raw_contact['phone_ext']
    end
    
    def email
      @raw_contact['email']
    end
  end
end