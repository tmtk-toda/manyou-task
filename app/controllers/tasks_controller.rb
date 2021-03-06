class TasksController < ApplicationController
  # before_action :authenticate_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    #キーワードが入力されていれば、whereメソッドとLIKE検索（部分一致検索）を組み合わせて、必要な情報のみ取得する。
    @tasks = current_user.tasks.search_name(params[:name_key]).search_completed(params[:completed]).search_label(params[:label]).page(params[:page]).per(5)
    if params[:sort_expired] 
      @tasks = current_user.tasks.order(deadline: :desc).page(params[:page]).per(5)
    elsif params[:sort_priority] 
      @tasks = current_user.tasks.order(priority: :desc).page(params[:page]).per(5)
    end  
  end
  
  #   if params[:name_key].present?
  #     if params[:completed].present? && params[:label].nil?
  #      @tasks = Task.where('name LIKE ?', "%#{params[:name_key]}%").where(completed: params[:completed]).page(params[:page]).per(5)
  #     elsif params[:completed].nil? && params[:label].present?
  #      @tasks = Task.where('name LIKE ?', "%#{params[:name_key]}%").search_label(params[:label]).page(params[:page]).per(5)
  #     elsif params[:label].present? && params[:completed].present?
  #      @tasks = Task.where('name LIKE ?', "%#{params[:name_key]}%").where(completed: params[:completed]).search_label(params[:label]).page(params[:page]).per(5)
  #     else params[:completed].nil? && params[:label].nil?
  #       @tasks = Task.where('name LIKE ?', "%#{params[:name_key]}%").page(params[:page]).per(5)
  #     end
  #   elsif params[:name_key].nil?
  #     if params[:completed].present? && params[:label].nil?
  #       @tasks = Task.where(completed: params[:completed]).page(params[:page]).per(5)
  #     else params[:completed].nil? && params[:label].present?
  #       @tasks = Task.search_label(params[:label]).page(params[:page]).per(5)
  #     end  
  #   elsif params[:label].present?
  #     @tasks = Task.search_label(params[:label]).page(params[:page]).per(5)
    # elsif params[:sort_expired] 
    #   @tasks = Task.all.order(deadline: :desc).page(params[:page]).per(5)
    # elsif params[:sort_priority] 
    #   @tasks = Task.all.order(priority: :desc).page(params[:page]).per(5)
  #   else params[:name_key].nil? && params[:label].nil? && params[:completed].nil?
  #     @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(5)
  #   end
  # end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    # binding.irb
    @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :detail, :deadline, :completed, :priority,  label_ids: [])
    end
end
