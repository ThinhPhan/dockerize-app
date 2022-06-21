#!/bin/bash
set -e

# Các gem đã cài đặt đã được mount từ volume vào folder /bundle trong container sẽ không phải install nữa,
# chỉ khi có thay đổi mới thực hiện install.
# bundle check || bundle install --binstubs="$BUNDLE_BIN"

# Check xem đã có database chưa, nếu chưa sẽ tạo database và migrate database.
# Check database is exist or not. If not exist, create database and migrate database.
bundle exec rails db:prepare

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Run rails server
bundle exec rails s -b 0.0.0.0 -p 3000

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
