class CardsController < ApplicationController
  def index
    if params[:view_type] == 'mypage'
      @view_type = params[:view_type]
      card_ids = params[:card_ids].split(',')
      @cards = Card.where(id: card_ids) 
      render 'index_mypage'
    else
      @cards = Card.search(params[:query]).order(:created_at)
      render 'index'
    end
  end
  
  def new
    @card = Card.new
  end
  
  def create
    @card = current_user.cards.build(card_params)
    if @card.save
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def destroy
    @card = Card.find(params[:id])
    if @card.destroy
      redirect_to card_with_view_type_path(params[:id], 'mypage')
    else
      redirect_to card_with_view_type_path(params[:id], 'mypage')
    end
  end
  
  def show
    @card = Card.find(params[:id])
    if params[:view_type] == 'myshow'
      render 'show_mypage'
    else
      render 'show'
    end
  end
  
  def edit
    @card = Card.find(params[:id])
  end
  
  def update
    @card = Card.find(params[:id])
    if @card.update(company: params[:card][:company], 
                    name: params[:card][:name], 
                    position: params[:card][:position],
                    license: params[:card][:license],
                    mail: params[:card][:mail],
                    tell: params[:card][:tell],
                    company_adress: params[:card][:company_adress],
                    image: params[:card][:image])
      redirect_to card_with_view_type_path(@card.id, 'mypage')
    else
      render 'edit'
    end
  end
  
  def get_image
    image = Card.find(params[:id])
    send_data image.file, disposition: :inline, type: 'image/png'
  end
end

private

def card_params
  params.require(:card).permit(:company, :name, :position, :license, :mail, :tell, :company_adress, :image)
end
