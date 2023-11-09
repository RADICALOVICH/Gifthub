class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :check_group_membership, only: [:show]

  def show
    @wishes = @user.wishes
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_group_membership
    unless current_user.groups.exists?(id: @user.groups.ids)
      flash[:alert] = "Вы не можете просматривать профиль этого пользователя."
      redirect_to root_path
    end
  end
end
