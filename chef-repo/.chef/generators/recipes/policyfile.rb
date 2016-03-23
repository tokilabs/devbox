require_relative '../helpers'

template_vars = {
  :config => Chef::Config,
  :helper => TemplateHelpers
}

context = ChefDK::Generator.context
policyfile_path = File.join(context.policyfile_dir, "#{context.new_file_basename}.rb")

template policyfile_path do
  source "Policyfile.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  variables template_vars
end
