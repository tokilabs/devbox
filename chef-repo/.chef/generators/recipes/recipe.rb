require_relative '../helpers'

cookbook_dir = TemplateHelpers.cookbook_dir
template_vars = {
  :config => Chef::Config,
  :helper => TemplateHelpers
}

context = ChefDK::Generator.context
recipe_path = File.join(cookbook_dir, "recipes", "#{context.new_file_basename}.rb")
spec_helper_path = File.join(cookbook_dir, "spec", "spec_helper.rb")
spec_path = File.join(cookbook_dir, "spec", "unit", "recipes", "#{context.new_file_basename}_spec.rb")

# Chefspec
directory "#{cookbook_dir}/spec/unit/recipes" do
  recursive true
end

cookbook_file spec_helper_path do
  action :create_if_missing
end

template spec_path do
  source "recipe_spec.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  variables template_vars
  action :create_if_missing
end

# Recipe
template recipe_path do
  source "recipe.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  variables template_vars
end
