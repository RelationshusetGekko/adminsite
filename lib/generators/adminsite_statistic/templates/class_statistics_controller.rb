class Admin::<%= class_name.titlecase %>StatisticsController < AdminApplicationController

  def index
    <%= class_name.titlecase %>.send(:include, <%= class_name.titlecase %>::Statistic)

    @<%= class_name.downcase %>_stats = <%= class_name.titlecase %>.statistics

    initalise_growth_parameters
  end
  protected

   def initalise_growth_parameters
     @first_profile_created_at = <%= class_name.titlecase %>.minimum("created_at").try(:to_date)
     @today = Time.zone.now.to_date
     @first_<%= class_name.downcase %>_created_at = @today if @first_<%= class_name.downcase %>_created_at.nil?

     year = @today.year
     @month_dif = ((year - @first_<%= class_name.downcase %>_created_at.year) * 12) + (@today.month - @first_<%= class_name.downcase %>_created_at.month)
   end

end