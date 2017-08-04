module PropertyMethods
  def modify_key_values(line)
    line = modify_mailing_locale(line)
    modify_bed_and_bath(line)
  end

  private

  def modify_mailing_locale(line)
    locale = line["mailing_locale"].scan(city_state_zip).flatten
    line["mailing_city"] = locale[0]
    line["mailing_state"] = locale[1]
    line["mailing_zip"] = locale[2]
    line.delete("mailing_locale")
    line
  end

  def modify_bed_and_bath(line)
    line["bedrooms"] = line["bed_and_baths"].scan(rooms("Bedrooms"))[0][1]
    line["bathrooms"] = line["bed_and_baths"].scan(rooms("Baths"))[0][1]
    line.delete("bed_and_baths")
    line
  end

  def city_state_zip
    /(\w+),\s(\w{2})\s(.*)/
  end

  def rooms(type)
    /(#{type})(\d+\.\d+)/
  end
end
