require_relative 'property_methods'
require 'open-uri'
require 'nokogiri'
require 'csv'
require 'yaml'

class PropertyDetails 
  include PropertyMethods

  def initialize
    @re_numbers = ["1200670000", "1200100000", "1543790900"]
    @base_url = "http://apps.coj.net/PAO_PROPERTYSEARCH/Basic/Detail.aspx?RE="
  end

  def create_csv
    CSV.open("output.csv", "w+") do |csv|
      csv << headers

      re_numbers.each do |re_num|
        line = map_dom_elements(re_num)
        line["re_num"] = re_num
        line = modify_key_values(line)

        csv << line.sort.to_h.values
      end
    end
  end

  private

  attr :re_numbers, :base_url, :doc

  def map_dom_elements(re_num)
    doc = Nokogiri::HTML(open(base_url + re_num))
    YAML.load_file('dom_elements.yaml').map do 
      |key,value| [key, doc.css(value).text]
    end.to_h
  end

  def headers
    header_list = YAML.load_file('headers.yaml')
    header_list.sort.to_h.values
  end
end

search = PropertyDetails.new
search.create_csv
