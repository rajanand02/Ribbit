class RibitsController < ApplicationController

  def create
    ribit = Ribit.new(params[:ribit])
    ribit.user_id = current_user.id
    falsh[:error] = "Your Ribbit was over 140 Characters" unless ribit.save
    redirect_to root_url
  end
end 
