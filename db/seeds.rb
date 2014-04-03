# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
# puts 'ROLES'
# YAML.load(ENV['ROLES']).each do |role|
#  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
#  puts 'role: ' << role
# end
puts 'Seeding default user accounts:'

admin_user = User.find_or_create_by(email: ENV['ADMIN_EMAIL'].dup)
admin_user.first_name = ENV['ADMIN_FIRST_NAME'].dup
admin_user.last_name = ENV['ADMIN_LAST_NAME'].dup
admin_user.phone = ENV['ADMIN_PHONE'].dup
admin_user.password = ENV['ADMIN_PASSWORD'].dup
admin_user.password_confirmation = ENV['ADMIN_PASSWORD'].dup
admin_user.role = User::SERVICE_ADMIN
admin_user.save

puts "\tAdmin user: #{admin_user.email}"
puts "\tAdmin user errors: #{admin_user.errors.messages}" if admin_user.errors
