class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :new]

  def index
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
    @booking = Booking.new
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.create(offer_params)
    @offer.user = current_user
    if @offer.save
      redirect_to @offer, notice: 'Your new offer was successfully created!'
    else
      render :new
    end
  end

  private
  def offer_params
    params.require(:offer).permit(:name, :price, :description, :category, :max_travellers, :date, :photo)
  end

end
