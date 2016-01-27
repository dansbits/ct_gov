require "ct_gov/version"
require 'ct_gov/address'
require 'ct_gov/clinical_trial'
require 'ct_gov/contact'
require 'ct_gov/facility'
require 'ct_gov/investigator'
require 'ct_gov/location'
require 'ct_gov/publication'
require 'ct_gov/search_result'
require 'ct_gov/search_result_set'

require 'saxerator'
require 'uri'
require 'openssl'
require 'net/http'

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

    ClinicalTrial.new(Saxerator.parser(response.body).for_tag(:clinical_study).first) if response.code == "200"
  end

  def self.search(params)
    params[:pg] ||= 1
    query = ::URI.encode_www_form(params)
    uri = ::URI.parse("#{BASE_URL}/ct2/results#{BASE_OPTIONS}&#{query}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    raw_resultset = Saxerator.parser(response.body).for_tag(:search_results).first
    SearchResultSet.new(params, raw_resultset) if response.code == "200"
  end

end

