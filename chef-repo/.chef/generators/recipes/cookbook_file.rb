require_relative '../helpers'

cookbook_dir = TemplateHelpers.cookbook_dir
template_vars = {
  :config => Chef::Config,
  :helper => TemplateHelpers
}
context = ChefDK::Generator.context
files_dir = File.join(cookbook_dir, "files", "default")
cookbook_file_path = File.join(cookbook_dir, "files", "default", "#{context.new_file_basename}")

directory files_dir do
  recursive true
end

if source_file = context.content_source

  file cookbook_file_path do
    content(IO.read(source_file))
  end

else

  template cookbook_file_path do
    source "cookbook_file.erb"
    helpers(ChefDK::Generator::TemplateHelper)
    variables template_vars
  end

end
