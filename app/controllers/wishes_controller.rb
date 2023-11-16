class WishesController < ApplicationController
  before_action :set_wish, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new show edit update create destroy index]

  # GET /wishes or /wishes.json
  def index
    @wishes = Wish.all
  end

  # GET /wishes/1 or /wishes/1.json
  def show
  end

  # GET /wishes/new
  def new
    @wish = Wish.new
  end

  # GET /wishes/1/edit
  def edit
  end

  # POST /wishes or /wishes.json
  def create
    @wish = Wish.new(
      title: wish_params[:title],
      short_description: wish_params[:short_description],
      picture: wish_params[:picture],
      url: wish_params[:url],
      user_id: current_user.id
    )
    if @wish.save
      flash[:notice] = 'Пожелание создано успешно'
      redirect_to root_path
    else
      flash[:alert] = "Ошибки в заполнении полей: #{@wish.errors.details}"
      redirect_to new_wish_path
    end
  end

  # PATCH/PUT /wishes/1 or /wishes/1.json
  def update
    respond_to do |format|
      if @wish.update(wish_params)
        format.html { redirect_to wish_url(@wish), notice: "Wish was successfully updated." }
        format.json { render :show, status: :ok, location: @wish }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wishes/1 or /wishes/1.json
  def destroy
    @wish.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user.id), notice: "Wish was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wish
      @wish = Wish.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wish_params
      params.require(:wish).permit(:title, :short_description, :user_id, :url, :picture)
    end
end
