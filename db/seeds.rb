class Seed
  def self.start
    seed = Seed.new
    seed.destroy_all
    seed.generate_all
    puts "Database seeded"
  end

  def destroy_all
    Post.destroy_all
    User.destroy_all
    Day.destroy_all
    Group.destroy_all
  end

  def generate_all
    generate_groups
    generate_days
    generate_users
    generate_posts
  end

  private

    def generate_groups
      calendars = {
        1 => 'casimircreative.com_59k8msrrc2ddhcv787vubvp0s4@group.calendar.google.com',
        2 => 'casimircreative.com_rps2hg1nfqjih4rcl3gl6s4lpk@group.calendar.google.com',
        3 => 'casimircreative.com_e9k9b6n7bok174ilmqbfdr0sc4@group.calendar.google.com',
        4 => 'casimircreative.com_c1s3vspg5v09vh5cnnh88dn2nc@group.calendar.google.com'
      }
      calendars.each do |mod_number, calendar_id|
        Group.create(name: "Mod #{mod_number}", calendar_id: calendar_id)
      end
    end

    def generate_days
      Group.all.each do |group|
        (1..6).to_a.each do |week|
          (0..6).to_a.each do |day_of_week|
            Day.create(group: group, day_of_week: day_of_week, week: week)
          end
        end
      end
    end

    def generate_users
      Group.all.each.with_index do |group, index|
        group.users << User.create(name: random_name, role:1, group: group, uid: "x000#{index}")
      end
    end

    def generate_posts
      User.all.each do |user|
        user.group.days.each do |day|
          day.posts << Post.create(body: random_body, user: user, tone: 'Robotic')
        end
      end
    end

    def random_name
      "#{Faker::Superhero.descriptor.delete(' ')}-#{Faker::Name.first_name}".downcase
    end

    def random_body
      [Faker::Quote.famous_last_words, Faker::Hacker.say_something_smart, Faker::GreekPhilosophers.quote]
        .sample.first(222)
    end
end

Seed.start
