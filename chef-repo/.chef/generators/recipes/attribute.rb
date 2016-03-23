require_relative '../helpers'

cookbook_dir = TemplateHelpers.cookbook_dir
template_vars = {
  :config => Chef::Config,
  :helper => TemplateHelpers
}

context = ChefDK::Generator.context
attribute_dir = File.join(cookbook_dir, "attributes")
attribute_path = File.join(cookbook_dir, "attributes", "#{context.new_file_basename}.rb")

directory attribute_dir

template attribute_path do
  source "attribute.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  variables template_vars
end
