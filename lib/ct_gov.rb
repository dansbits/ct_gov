require "ct_gov/version"
require 'ct_gov/clinical_trial'
require 'ct_gov/contact'
require 'ct_gov/investigator'
require 'ct_gov/publication'

require 'saxerator'

module CtGov
  
  BASE_URL = 'https://www.clinicaltrials.gov'
  BASE_OPTIONS = '?displayxml=true'
  
  def self.find_by_nctid(nctid)
    uri = ::URI.parse("#{BASE_URL}/ct2/show/#{nctid}#{BASE_OPTIONS}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    ClinicalTrial.new(Saxerator.parser(response.body)) if response.code == "200"
  end

end

