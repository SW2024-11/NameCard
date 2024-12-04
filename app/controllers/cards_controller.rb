class CardsController < ApplicationController
  def index
    if params[:view_type] == 'mypage'
      @cards = Card.all               #ココ
      render 'index_mypage'
    else
      @cards = Card.all               #ココ
      render 'index'
    end
  end
  
  def new
    @card = Card.new
  end
  
  def create
    @card = Card.new(company: params[:card][:company], 
                    name: params[:card][:name], 
                    position: params[:card][:position],
                    license: params[:card][:license],
                    mail: params[:card][:mail],
                    tell: params[:card][:tell],
                    company_adress: params[:card][:company_adress],
                    image: params[:card][:image])
    if @card.save
      redirect_to card_with_view_type_path(@card.id, 'mypage')
    else
      render 'new'#, status: :unprocessable_entity
    end
  end
  
  def destroy
    @card = Card.find(params[:id])
    if @card.destroy
      redirect_to card_with_view_type_path(@card.id, 'mypage')
    else
      render card_with_view_type_path(@card.id, 'mypage')
    end
  end
  
  def show                                 #ココ
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
      redirect_to root_path
    else
      render 'edit'#, status: :unprocessable_entity
    end
  end
  
  def get_image
    image = Card.find(params[:id])
    send_data image.file, disposition: :inline, type: 'image/png'
  end
end
