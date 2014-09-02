class TasksController < ApplicationController
	def index
		@tasks = Task.all
		@task = Task.new
	end

	def create
		#render text: params.inspect

		@task = Task.new(task_params)

		if @task.save
			flash[:success] = 'Task was created'
			redirect_to :back
		else
			@tasks = Task.all
			flash.now[:error] = 'Error'
			render :index
		end		
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])

		if @task.update(task_params)
			flash[:success] = 'Task was updated'
			redirect_to root_path
		else
			flash[:error] = 'Error'
			render :edit
		end
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		flash[:success] = 'Task has been deleted'
		redirect_to root_path
	end

	private
		def task_params
			params.require(:task).permit(:task)
		end
end
