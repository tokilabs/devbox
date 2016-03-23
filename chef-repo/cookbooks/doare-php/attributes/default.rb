default['web_root'] = '/var/www'

# Method to install php with
# Default: package
default['php']['install_method'] = 'package'

default['php']['session_path'] = '/var/lib/php/session'
default['php']['upload_tmp_dir'] = '/var/lib/php5/tmp'
default['php']['error_log'] = '/var/log/php.log'

# Hash of directives and values to append to php.ini.
# Security recommendations from
# - http://www.madirish.net/199
# - http://www.cyberciti.biz/tips/php-security-best-practices-tutorial.html
# Default: {}
default['php']['directives'] = {
  # general Security
  open_basedir: node['web_root'],
  disable_functions: 'php_uname, getmyuid, getmypid, passthru, leak, listen, diskfreespace, tmpfile, link, ignore_user_abord, shell_exec, dl, set_time_limit, exec, system, highlight_file, source, show_source, fpaththru, virtual, posix_ctermid, posix_getcwd, posix_getegid, posix_geteuid, posix_getgid, posix_getgrgid, posix_getgrnam, posix_getgroups, posix_getlogin, posix_getpgid, posix_getpgrp, posix_getpid, posix, _getppid, posix_getpwnam, posix_getpwuid, posix_getrlimit, posix_getsid, posix_getuid, posix_isatty, posix_kill, posix_mkfifo, posix_setegid, posix_seteuid, posix_setgid, posix_setpgid, posix_setsid, posix_setuid, posix_times, posix_ttyname, posix_uname, proc_open, proc_close, proc_get_status, proc_nice, proc_terminate, phpinfo',
  report_memleaks: 'On',
  register_globals: 'Off',

  # remote files
  allow_url_fopen: 'Off',
  allow_url_include: 'Off',

  session: {
    save_path: node['php']['session_path'],
    cookie_httponly: 'On',
  },

  # Set the temporary directory used for storing files when doing file upload
  upload_tmp_dir: node['php']['upload_tmp_dir'],

  # Restrict PHP Information Leakage
  expose_php: 'Off',

  # Error logging and reporting
  error_reporting: 'E_ALL',
  display_errors: 'Off',
  display_startup_errors: 'Off',
  log_errors: 'On',
  log_errors_max_len: '1024',
  ignore_repeated_errors: 'Off',
  ignore_repeated_errors: 'Off',
  ignore_repeated_source: 'Off',
  error_log: node['php']['error_log'],

  # SQL
  sql: {
    safe_mode: 'Off'
  },

  # Magic Quotes
  magic_quotes_gpc: 'Off',
  magic_quotes_runtime: 'Off',
  magic_quotes_sybase: 'Off',

  # Limits (set in seconds)
  max_execution_time: '30',
  max_input_time: '30',
  memory_limit: '40M'
}

# @todo Install Mod_Security https://www.modsecurity.org/download.html
# @todo Check out PHPIDS https://github.com/PHPIDS/PHPIDS
# @todo Check out http://phpsec.org/projects/guide/

# SEARCH FOR INFECTIONS
# grep -iR 'c99' ~
# grep -iR 'r57' ~
# find /home/doare/ -name \*.php -type f -print0 | xargs -0 grep r57
# grep -RPn "(passthru|shell_exec|system|base64_decode|fopen|fclose|eval)" /var/www/html/


# lockdown:
# find /var/www/html/ -type d -print0 | xargs -0 -I {} chmod 0445 {}
# chattr +i /etc/php.ini
# chattr +i /etc/php.d/*
# chattr +i /etc/my.ini
# chattr +i /etc/httpd/conf/httpd.conf
# chattr +i /etc/
# chattr +i /var/www/html/file1.php
# chattr +i /var/www/html/

# @todo getsebool -a | grep httpd

# @todo use per site php.ini (see: https://docs.newrelic.com/docs/agents/php-agent/configuration/php-directory-ini-settings#php-fpm_per-dir)
# and then set...
# - session.referer_check: 'your_url.tld
# - open_basedir: '/path/to/web/root
