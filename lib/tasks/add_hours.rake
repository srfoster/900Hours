namespace :hours do

  task :add_for_user, [:user_id, :num_hours] => [:environment] do |t, args|
    user = User.find(args.user_id)
    
    1.upto(args.num_hours.to_i) do
      h = Hour.new
      h.force_create = true  
      user.hours << h
    end

  end
end
