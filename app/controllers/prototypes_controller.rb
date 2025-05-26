class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    @prototypes = Prototype.includes(:user).all
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @prototype = Prototype.find(params[:id])
      unless user_signed_in?
    redirect_to action: :index
  end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


def update
  @prototype = Prototype.find(params[:id])
  if @prototype.update(prototype_params)
    redirect_to prototype_path(@prototype)
  else
    render :edit, status: :unprocessable_entity
  end
end



  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
  end
end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def authorize_user!
    # 現在のユーザーがこのプロトタイプの投稿者でなければトップページへリダイレクト
    unless current_user == @prototype.user
      redirect_to root_path
    end
  end
end
end
