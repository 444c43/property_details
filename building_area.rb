module BuildingArea
  def heated_area(row)
    { "heated_area" => parse_table(row, "Total")[2] }
  end
end
