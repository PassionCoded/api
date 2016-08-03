desc "Remove duplicate passions and change to lower case"
task :remove_dupes_and_downcase => :environment do
  puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
  puts "Removing duplicate passions and downcase"
  puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
  User.all.each do |user|
    passion_names = []

    Passion.where(user: user).each do |passion|
      passion_names.push passion.name.downcase
      passion.destroy
    end

    passion_names.uniq!

    passion_names.each do |name|
      new_passion = Passion.new(name: name, user: user)
      new_passion.save
    end
  end
end
