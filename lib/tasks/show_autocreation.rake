namespace :show_autocreation do  
    task :update_show => :environment do 
        Show.all.each do |show|  
          show.update(remaining_seats: show.total_seats) 
           
          puts "hyyyy"
        end
    end
end

