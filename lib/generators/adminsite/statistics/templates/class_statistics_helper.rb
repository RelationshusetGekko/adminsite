module Admin::<%= class_name.camelize %>StatisticsHelper

  def get_number(number, totalnumber)
    percent = get_percent(number, totalnumber)
    return "#{number} (#{percent}%)"
  end

  def get_percent(number, totalnumber)
    return 0 if number.nil? || totalnumber.nil?
    result = 0
    result = ((number * 100.0) / totalnumber) unless totalnumber < 1
    return sprintf("%.1f", result)
  end

end