module SalesHistory
  def last_sale_date(table)
    { "last_sale_date" => first_row(table)[1] }

  end

  def last_sale_price(table)
    { "last_sale_price" => first_row(table)[2] }
  end

  def last_sale_deed_type(table)
    { "last_sale_deed_type" => first_row(table)[3] }
  end

  private

  def first_row(table)
    table[1].css('td').map do |elem|
      elem.text.downcase
    end.reject(&:empty?)
  end
end
