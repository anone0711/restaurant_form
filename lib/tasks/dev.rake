namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
      tel: FFaker::PhoneNumber.short_phone_number,
      address: FFaker::Address.street_address,
      opening_hours: FFaker::Time.datetime,
      description: FFaker::Lorem.paragraph,
      category: Category.all.sample)
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do
    users = User.all
    users.each do |user|
      if !user.admin?
        user.destroy
      end
    end

    20.times do |i|
      user_email = FFaker::Internet.free_email
      User.create!(name: user_email.split("@")[0],
        email: user_email,
        password: "12345678"
        )
    end
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end

  task fake_comment: :environment do
    Comment.destroy_all
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(content: FFaker::Lorem.sentence,
          user: User.all.sample)
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comments data"
  end
end