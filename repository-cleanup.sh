#!/bin/sh

echo 'Cleaning up repository from previous run'
echo '  - delete content in documentation/'
find documentation/ -name "*.md" -type f -delete
echo '  - delete content in generated_vars/'
find generated_vars -name "*.yml" -type f -delete
echo '  - delete content in intended_configs/'
find intended_configs -name "*.cfg" -type f -delete
