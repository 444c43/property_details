module BuildingElements
  def roof_struct(row)
    { "roof_struct" => parse_table(row, "Roof Struct")[2] }
  end

  def roof_cover(row)
    { "roof_cover"  => parse_table(row, "Roofing Cover")[2] }
  end

  def air_cond(row)
    {
      "air_cond" => parse_table(row, "Air Cond")[2]
    }
  end
end
