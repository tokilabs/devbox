require_relative '../helpers'

cookbook_dir = TemplateHelpers.cookbook_dir
template_vars = {
  :config => Chef::Config,
  :helper => TemplateHelpers
}

context = ChefDK::Generator.context

resource_dir = File.join(cookbook_dir, "resources")
resource_path = File.join(resource_dir, "#{context.new_file_basename}.rb")

provider_dir = File.join(cookbook_dir, "providers")
provider_path = File.join(provider_dir, "#{context.new_file_basename}.rb")

directory resource_dir

template resource_path do
  source "resource.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  variables template_vars
end

directory provider_dir

template provider_path do
  source "provider.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  variables template_vars
end
