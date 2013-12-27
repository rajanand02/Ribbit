class UsersController < ApplicationController

  def new
    if current_user
      redirect_to buddies_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up"
    else
      render 'new'
    end
  end

  def index
    @users = User.all
    @ribit = Ribit.new
  end

  def show
    @user = User.find(params[:id])
    @ribit = Ribit.new
    @relationship = Relationship.where(
      follower_id: current_user.id,
      followed_id: @user.id
    ).first_or_initialize if current_user
  end

  def edit
    @user = User.find(params[:id]) 
    redirect_to @user unless @user == current_user
  end

  def update
    @user = User.find(params[:id]) 
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: "Profile updated successfully"
    else
      render 'edit'
    end
  end

  def buddies
    if current_user
      @ribit = Ribit.new
      buddies_ids = current_user.followeds.map(&:id).push(current_user.id)
      @ribits = Ribit.find_all_by_user_id buddies_ids
    else
      redirect_to root_url
    end
  end
end
