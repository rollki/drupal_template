#!/bin/sh

composer install

# Execute site install with default settings using Drupal console.
drupal site:install standard \
--langcode="en" \
--db-type="mysql" \
--db-host="database" \
--db-name="drupal8" \
--db-user="drupal8" \
--db-pass="drupal8" \
--db-port="3306" \
--site-name="profit4u" \
--site-mail="frs.daddy@gmail.com" \
--account-name="admin" \
--account-pass="admin" \
--account-mail="frs.daddy@gmail.com"

# Fix config import installation issues. Set UUID corresponding to the settings.
drush cset "system.site" uuid "26850c5a-fdbf-49a3-8a92-cca1d30cce4c" -y
drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'

# Import configurations.
drush cim -y

# Cache rebuild
drush cr

drush genu 10 --roles=administrator
