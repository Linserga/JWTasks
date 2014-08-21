require 'rails_helper'

RSpec.describe "Tasks", :type => :request do
  describe "GET /tasks" do
    it "should display some tasks" do
    	visit tasks_path
    	expect(page).to have_content('go to bed')
    end
  end
end
