class Admin::<%= class_name %>ExportsController < AdminApplicationController

  def create
    Resque::enqueue(<%= class_name %>Export)
    flash[:notice] = 'Export in process, come back here later to donwload it.'
    redirect_to(admin_#{file_name}_exports_path)
  end

  def show
    filename = params[:id]+".#{<%= class_name %>Export.file_ext}"
    export_file = <%= class_name %>Export.default_path_to_export.join(filename)
    if File.file?(export_file)
      send_file(export_file)
    else
      flash[:error] = "File #{filename} does not exist"
      redirect_to(admin_#{file_name}_exports_path)
    end
  end

  def destroy
    filename = params[:id]+".#{<%= class_name %>Export.file_ext}"
    export_file = <%= class_name %>Export.default_path_to_export.join(filename)
    if File.file?(export_file)
      FileUtils.rm(export_file)
    else
      flash[:error] = "File #{filename} does not exist"
    end
    redirect_to(admin_#{file_name}_exports_path)
  end

end