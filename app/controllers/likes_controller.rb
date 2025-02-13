class LikesController < ApplicationController
  before_action :authenticate_user! # Assure que l'utilisateur est connecté

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @like = @gossip.likes.find_or_initialize_by(user: current_user)

    if @like.new_record? && @like.save
      redirect_to @gossip, notice: "Vous avez aimé ce gossip."
    else
      redirect_to @gossip, alert: "Vous avez déjà aimé ce gossip."
    end
  end

  def destroy
    @like = current_user.likes.find_by(gossip_id: params[:gossip_id])
    
    if @like
      @like.destroy
      redirect_to @like.gossip, notice: "Vous n'aimez plus ce gossip."
    else
      redirect_to gossip_path(params[:gossip_id]), alert: "Impossible de retirer le like."
    end
  end
end
