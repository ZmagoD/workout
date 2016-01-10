require 'rails_helper'

RSpec.feature 'Editing exercises' do
  
    before do
      @owner = User.create(first_name: "John", last_name: "Doe", email: "owner@example.com", password:"password")
      
      @owner_exercise =  @owner.exercises.create( duration_in_min: 45, workout: "Cardio Activity", workout_date: "2016-01-06" )
      login_as(@owner)
    end
    
    scenario 'wiht valid inputs succeeds' do
      visit '/'
      click_link 'My Longue'
      link = "a[href='/users/#{@owner.id}/exercises/#{@owner_exercise.id}/edit']"
      find(link).click
      fill_in "Duration", with: 50
      click_button "Update Exercise"
      
      expect(page).to have_content("Exercise has been updated")
      expect(page).to have_content(50)
      expect(page).to_not have_content(45)
    end
end