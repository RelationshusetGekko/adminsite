class Admin::<%= class_name %>ExportsController < AdminApplicationController
  before_filter :set_export_and_file_types
  before_filter :retrieve_file, :only => [:show, :destroy]

  def create
    Resque::enqueue(<%= class_name %>Export, params[:export_name_scope], params[:file_type])
    flash[:notice] = 'Export in process, come back here later to donwload it.'
    redirect_to(admin_<%= file_name %>_exports_path)
  end

  def show
    send_file(@export_file)
  end

  def destroy
    FileUtils.rm(@export_file)
    redirect_to(admin_<%= file_name %>_exports_path)
  end

  private
  def retrieve_file
    params[:id].match /^(.*)_(.*)$/
    @export_file = <%= class_name %>Export.default_path_to_export.join("#{$1}.#{$2}")

    unless File.file?(@export_file)
      flash[:error] = "File #{@export_file.basename} does not exist"
      redirect_to(admin_<%= file_name %>_exports_path) and return false
    end

  end

  def set_export_and_file_types
    @export_name_scopes = ['all']
    @file_types   = ['xlsx', 'csv']
  end

end