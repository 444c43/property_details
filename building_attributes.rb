module BuildingAttributes
  def bathrooms(row)
    text = parse_table(row, "Baths")
    { text[0] => text[1] }
  end

  def bedrooms(row)
    text = parse_table(row, "Bedrooms")
    { text[0] => text[1] }
  end
end
