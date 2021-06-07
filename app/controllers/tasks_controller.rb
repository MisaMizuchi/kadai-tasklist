class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end
  
  def show
    set_task
  end
  
  def new
    @task = Task.new
  end
  
  def create
    set_task
    
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
  
  #Strong Parameter
  
  def set_task
    @task = Task.find(params[:id])
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
