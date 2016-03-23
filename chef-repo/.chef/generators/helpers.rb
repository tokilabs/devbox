# Context variables
#    @have_git=true,
#    @skip_git_init=true,
#    @berks=nil,
#    @policy=nil,
#    @license="all_rights",
#    @copyright_holder="The Authors",
#    @email="you
#    @example.com",
#    @generator_cookbook=nil,
#    @generator_arg=[],
#    @cookbook_root="",
#    @cookbook_name="company_shortname",
#    @recipe_name="default",
#    @include_chef_repo_source=false,
#    @policy_name="company_shortname",
#    @policy_run_list="company_shortname::default",
#    @policy_local_cookbook=".",
#    @use_berkshelf=true

module TemplateHelpers
  ### Finds the cookbooks dir on the current dir or any dir above
  ### If none is found it returns context.cookbook_root
  def self.cookbooks_root
    prev_dir = Dir.pwd
    Dir.chdir '..' while !Dir.exist? 'cookbooks' and Dir.pwd != "/"

    if Dir.pwd != '/'
      cookbooks_dir = File.join(Dir.pwd, 'cookbooks')
    else
      cookbooks_dir = ChefDK::Generator.context.cookbook_root
    end

    # go back to the previous cwd (so we don't break anything)
    Dir.chdir prev_dir
    return cookbooks_dir
  end

  def self.cookbook_dir
    File.join(self.cookbooks_root, ChefDK::Generator.context.cookbook_name)
  end

  def self.year
    Time.now.year
  end

  def self.copyright_holder
    Chef::Config.cookbook_copyright
  end

  def self.license
    case Chef::Config.cookbook_license
    when 'apache2'
      'Apache v2.0'
    when 'gplv2'
      'GPL v2'
    when 'gplv3'
      'GPL v3'
    when 'mit'
      'MIT'
    else
      'Proprietary - All Rights Reserved'
    end
  end

  # Prints the full license.
  # To add it to the preamble of a file you may pass a string to be set
  # as the comment before each line
  def self.license_description(comment=nil)
    config = Chef::Config
    case config.cookbook_license
    when 'apache2'
      result = <<-EOH
Copyright #{self.year} #{config.cookbook_copyright}
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
EOH
    when 'mit'
      result = <<-EOH
The MIT License (MIT)
Copyright (c) #{self.year} #{config.cookbook_copyright}
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
EOH
    when 'gplv2'
      result = <<-EOH
Copyright (C) #{self.year}  #{config.cookbook_copyright}
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
EOH
    when 'gplv3'
      result = <<-EOH
Copyright (C) #{self.year}  #{config.cookbook_copyright}
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
EOH
    else
      result = "Copyright (c) #{self.year} #{config.cookbook_copyright}, All Rights Reserved."
    end

    if comment
      # Ensure there's no trailing whitespace
      result.gsub(/^(.+)$/, "#{comment} \\1").gsub(/^$/, "#{comment}")
    else
      result
    end
  end
end
