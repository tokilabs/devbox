# Wordpress flexible Nginx config

This whole setup assumes that the root of the site is the blog and that all files that will be referenced reside on the host.

## TO DO

- Check Nginx fastcgi_cache at https://codex.wordpress.org/Nginx

## References

- https://codex.wordpress.org/Nginx
- https://mozilla.github.io/server-side-tls/ssl-config-generator/?server=nginx-1.4.6&openssl=1.0.1f&hsts=yes&profile=intermediate

## Folders / files

    /etc/nginx/
      |- global/
      |  '- restrictions.conf
      |
      '- sites-available/
         |- brazilfoundation/
         |  |- force-https.conf
         |  |-http-only.conf
         |  |-https.conf
         |  |-php-fpm.conf
         |  |-redirect-to-https.conf
         |  |-server-main.conf
         |  '-wordpress.conf
         | 
         '- wordpress/
            |- restrictions.conf
            |- super-cache.conf
            |- w3-total-cache.conf
            |- w3-total-cache-ms-domains.conf
            |- w3-total-cache-ms-subdir.conf
            '- w3-total-cache-single.conf
