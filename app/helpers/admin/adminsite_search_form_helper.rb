module Admin::AdminsiteSearchFormHelper

  def column_of_attr(search_attr)
    return if search_attr.blank?
    resource_class.columns.each{|c| return c if c.name == search_attr.to_s.downcase }
    nil
  end

  def input_type_of_column(column)
    case
    when column.sql_type.match(/\Acharacter varying/)
      return :string
    when column.sql_type.match(/\Atimestamp/)
      return :date
    when column.sql_type.match(/\integer/)
      return :number
    else
      column.sql_type.try(:to_sym)
    end
  end

  def ransack_predicate_input_type(input_type)
    case input_type
    when :boolean
      return [:eq]
    when :text
      return [:eq, :cont]
    when :string
      return [:eq, :cont]
    when :date
      return [:lteq, :gteq]
    when :number
      return [:eq, :lteq, :gteq]
    else
      [:eq]
    end
  end

end