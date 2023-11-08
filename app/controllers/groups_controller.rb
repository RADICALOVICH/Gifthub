class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy calendar]
  before_action :authenticate_user!, only: %i[ new show edit update create destroy index]

  # GET /groups or /groups.json
  def index
    array = Member.where(user_id: current_user.id).pluck(:group_id)
    @groups = Group.where(id: array)
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    # unless @MODEL.find_by(user_id: current_user.id, group_id: @group.id)&.is_admin
    #   flash[:alert] = 'вы не админ группы'
    #   redirect_to root_path
    # end
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)
    if @group.save
      Member.create(user_id: current_user.id, group_id: @group.id, is_admin: true)
      flash[:notice] = 'Группа создана успешно'
      redirect_to group_url(@group)
    else
      flash[:alert] = "Ошибки в заполнении полей: #{@group.errors.details}"
      redirect_to new_group_path
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def list_of_users
    @group = Group.find(params[:id])
    array = Member.where(group_id: params[:id]).pluck(:user_id)
    @users = User.where(id: array)
    @admin_id = Member.find_by(group_id: params[:id], is_admin: true).user_id
  end

  def calendar
    @members = @group.users
  end

  def information
    @group = Group.find(params[:id])
    @admin_id = Member.find_by(group_id: params[:id], is_admin: true).user_id
  end

  def add_user
    if Member.find_by(user_id: params[:user_id], group_id: params[:group_id])
      flash[:alert] = 'Вы уже вступили в эту группу'
    else
      Member.create(user_id: params[:user_id], group_id: params[:group_id])
      flash[:notice] = 'Вы успешно вступили в группу'
    end
    redirect_to root_path
  end

  def invite_users
    @group_id = params[:id]
    @users = User.all
  end
  
  def send_email
    GroupMailer.invite(params[:user_id], params[:group_id]).deliver_later
  end

  def delete_user
    Member.where(group_id: )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:title, :description, :avatar)
    end
end
