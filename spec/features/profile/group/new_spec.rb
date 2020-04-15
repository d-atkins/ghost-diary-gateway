require "rails_helper"

RSpec.describe 'Profile/Group New -' do
  describe 'Registered user' do
    describe 'without a group' do
      it 'can join a group' do
        create(:group, name: 'Mod 1')
        create(:group, name: 'Mod 2')
        group = create(:group, name: 'Mod 3')
        user = User.create(name: 'User', uid: '1111')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(create(:day, group: group))

        visit '/'

        expect(page).to have_content("It seems you haven't joined a group yet.")
        click_link('Join a group now!')

        expect(current_path).to eq(new_profile_group_path)
        
        select 'Mod 3', :from => :group_select
        click_button('Join')

        expect(current_path).to eq('/posts')
        expect(page).to have_content('You have joined Mod 3!')
        expect(page).to_not have_content("It seems you haven't joined a group yet.")
      end
    end
  end
end
