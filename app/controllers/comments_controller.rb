class CommentsController < ApplicationController
  before_action :authenticate_user! # Assure que l'utilisateur est connecté

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @gossip, notice: "Commentaire ajouté avec succès."
    else
      redirect_to @gossip, alert: "Erreur lors de l'ajout du commentaire."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.gossip, notice: "Commentaire supprimé avec succès."
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
