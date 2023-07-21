# namespace :remaining_seats do
#   desc "TODO"
#   task update_record: :environment do
#     show_time_records = ShowTime.where(remaining_seats: nil)
#     show_time_records.each do |record|
#       record.update(remaining_seats: record.show.screen.total_seats)
#       puts "Record-#{record.id} is updated"
#     rescue StandardError => e
#       puts "#{e}"
#     end
#   end
# end
