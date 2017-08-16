require_relative 'building_area'
require_relative 'building_attributes'
require_relative 'building_elements'
require_relative 'sales_history'

module RecordBuilder 
  include BuildingAttributes
  include BuildingElements
  include BuildingArea
  include SalesHistory

  def headers
    list = @dom.map do | key, value |
      value.keys
    end.flatten

    list << "re_number"
  end

  def map_dom_elements
    @dom["elements"].map do |key,value|
      [key, @page.css(value).text]
    end.to_h
  end

  def add_tables
    tables = {}
    @dom["tables"].map do |key,value|
      table = @page.css(value).css('tr')
      tables.merge!(send(key, table))
    end
    tables
  end

  private

  def parse_table(table_element, text)
    table_element.map { |row| row.css('td').map {|elem| elem.text } if row.content.include? text }.compact.flatten
  end
end
