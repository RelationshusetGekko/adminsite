class Admin::<%= class_name.camelize %>StatisticsController < AdminApplicationController

  def index
    <%= class_name.camelize %>.send(:include, <%= class_name.camelize %>::Statistic)

    @<%= class_name.underscore %>_stats = <%= class_name.camelize %>.statistics

    initalise_growth_parameters
  end
  protected

   def initalise_growth_parameters
     @first_profile_created_at = <%= class_name.camelize %>.minimum("created_at").try(:to_date)
     @today = Time.zone.now.to_date
     @first_<%= class_name.underscore %>_created_at = @today if @first_<%= class_name.underscore %>_created_at.nil?

     year = @today.year
     @month_dif = ((year - @first_<%= class_name.underscore %>_created_at.year) * 12) + (@today.month - @first_<%= class_name.underscore %>_created_at.month)
   end

end