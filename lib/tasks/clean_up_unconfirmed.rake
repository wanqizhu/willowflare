desc "Delete all unconfirmed users after 30 days"
task :delete_unconfirmed_users => :environment do

  
  puts "deleting unconfirmed and never-active users..."
  puts "ENV: " + Rails.env

  if Rails.env == 'production' # mysql
    users = User.where("confirmed_at is NULL AND confirmation_sent_at <= NOW() - INTERVAL 30 DAY AND info NOT like ?", '%survey%')
  else # sqlite
    users = User.where("confirmed_at is NULL AND confirmation_sent_at <= datetime(\'now\',\'-30 days\') AND info NOT like ?", '%survey%')  
  end

  puts "count = " + users.count.to_s
  users.each do |user|
    
    puts user.email
    puts user.confirmation_sent_at
    puts user.info
    puts user.money
    user.destroy
  end
end