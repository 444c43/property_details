require_relative 'record_builder'
require 'open-uri'
require 'nokogiri'
require 'csv'
require 'yaml'
require 'byebug'

class PropertyDetails 
  include RecordBuilder 

  def initialize
    @re_numbers = open_re_file 
    @base_url = "http://apps.coj.net/PAO_PROPERTYSEARCH/Basic/Detail.aspx?RE="
    @dom = YAML.load_file('config/dom_elements.yaml')
  end

  def create_csv
    CSV.open("output.csv", "w+") do |csv|
      csv << headers 
      re_numbers.each do |re_num|
        @page = get_page(re_num)
        line = create_record.merge({"re_num" => re_num})
        csv << line.values
      end
    end
  end

  private

  attr :re_numbers, :base_url, :doc

  def open_re_file
    File.open('numbers.txt').map { |line| line.chomp}
  end

  def create_record
    line = map_dom_elements
    line.merge(add_tables)
  end

  def get_page(re_num)
    Nokogiri::HTML(open(base_url + re_num))
  end
end

search = PropertyDetails.new
search.create_csv
