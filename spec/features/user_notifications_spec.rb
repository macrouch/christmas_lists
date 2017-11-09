require 'rails_helper'

describe 'User notifications', js: true do
  before do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_group_with 'Test Group', 'What is 1+2?', '3'

    notification = Notification.create(title: 'Notification Title', message: 'This is a cool notification message!')

    User.first.notifications << notification
  end

  context 'when visiting the site with unread notifications' do
    before do
      visit '/'
    end

    it 'displays unread notifications' do
      expect(page).to have_content 'Notification Title'
      expect(page).to have_content 'This is a cool notification message!'
    end

    context 'when clicking the modal close button' do
      before do
        click_on 'Close'
        wait_for_ajax
      end

      it 'hides the modal' do
        expect(page).to have_no_content 'System Updates'
        expect(page).to have_no_content 'Notification Title'
        expect(page).to have_no_content 'This is a cool notification message!'
      end

      it 'marks the notifications as read' do
        expect(UserNotification.first.is_read).to eq(true)
      end

      context 'when viewing the page after reading the notifications' do
        before do
          visit '/'
        end

        it 'does not display read notifications' do
          expect(page).to have_no_content 'System Updates'
          expect(page).to have_no_content 'Notification Title'
          expect(page).to have_no_content 'This is a cool notification message!'
        end
      end
    end
  end
end
