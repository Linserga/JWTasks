require 'rails_helper'

RSpec.describe "Tasks", :type => :request do
  
  let!(:task){FactoryGirl.create(:task)}

  describe "GET /tasks" do
    it "should display some tasks" do
    	visit tasks_path
    	expect(page).to have_content('The First Task')
    end

    it 'creates a new task with valid params' do
    	visit tasks_path
    	fill_in 'Task', with: 'go to work'
    	click_button 'Create Task'

    	expect(current_path).to eq(tasks_path)
    	expect(page).to have_content 'go to work'

    	#save_and_open_page
    end

    it 'does not create task with invalid params' do
    	visit tasks_path
    	fill_in 'Task', with: ''
    	click_button 'Create Task'

    	expect(current_path).to eq(tasks_path)
    	expect(page).to have_selector('div.alert.alert-error')
    end
  end

  describe 'PUT /tasks' do
  	it 'edits a task' do
  		visit tasks_path
  		click_link 'Edit'

  		expect(current_path).to eq(edit_task_path(task))
  		#expect(page).to have_content(task.task)
  		expect(find_field('Task').value).to eq(task.task)

  		fill_in 'Task', with: 'updated task'
  		click_button 'Update Task'

  		expect(current_path).to eq(root_path)
  		expect(page).to have_content 'updated task'
  	end

  	it 'should not update an empty task' do
  		visit tasks_path
  		click_link 'Edit'
  		fill_in 'Task', with: ''
  		click_button 'Update Task'

  		#expect(current_path).to eq(task_path(task))
  		expect(page).to have_selector('div.alert.alert-error')
  	end
  end

  describe 'DELETE /tasks' do
  	it 'should delete task' do
  		visit tasks_path
  		find("#task_#{task.id}").click_link 'Delete'

  		expect(page).to have_content('Task has been deleted')
  		expect(page).not_to have_content('The First Task')
  	end
  end
end
