class GossipsController < ApplicationController
  before_action :set_gossip, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
  @comments = @gossip.comments
  end

  def new
    @gossip = Gossip.new
  end

  def city_gossips
    @city = params[:city]
    @gossips = Gossip.joins(:user).where(users: { city: @city })
  end

  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user # Assurez-vous que l'utilisateur est connecté

    if @gossip.save
      redirect_to @gossip, notice: "Gossip was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @gossip.update(gossip_params)
      redirect_to @gossip, notice: "Le gossip a été mis à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    if current_user == @gossip.user
      @gossip.destroy
      redirect_to gossips_path, notice: "Le gossip a été supprimé avec succès."
    else
      redirect_to gossips_path, alert: "Vous n'êtes pas autorisé à supprimer ce gossip."
    end
  end

  private

  def set_gossip
    @gossip = Gossip.find(params[:id])
  end

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end

  def authenticate_user
    unless current_user
      redirect_to login_path, alert: 'You need to log in to access this page.'
    end
  end

  def authorize_user
    unless current_user == @gossip.user
      redirect_to gossips_path, alert: "You are not authorized to perform this action."
    end
  end
end
