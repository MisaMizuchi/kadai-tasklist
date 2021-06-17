class TasksController < ApplicationController
  before_action :require_user_logged_in
  def index
    @tasks = current_user.tasks.all
  end
  
  def show
    set_task
  end
  
  def new
    @task = current_user.task.new
  end
  
  def create
    
    @task = current_user.task.new(task_params)
    
    if @task.save
      flash[:success] = "タスクが正常に追加されました"
      redirect_to @task
    else 
      flash.now[:danger] = "タスクが追加されませんでした"
      render :new
    end
  end
  
  def edit
    set_task
  end
  
  def update
    set_task
    
    if @task.update(task_params)
      flash[:success] = "タスクは正常に更新されました"
      redirect_to @task
      
    else
      flash.now[:danger] = "タスクは更新されませんでした"
      render :edit
    end

  end
  
  def destroy
    set_task
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url
  end
  
  private
  
  
  def set_task
    @task = current_user.task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
