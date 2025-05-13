class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = '新しくタスクを作成しました'
      redirect_to @task
    else
      flash.now[:alert] = 'タスク作成に失敗。再度やり直しましょう' ##上手くこのフラッシュメッセージは表示されないので再確認
      
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = 'タスクが更新できました'
      redirect_to tasks_path
    else
      flash[:alert] = 'タスクの更新ができません'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = '削除されました'

    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.turbo_stream { render turbo_stream: turbo_stream.remove("task_#{@task.id}") }
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :completed)
  end


end