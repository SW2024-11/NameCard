class CardsController < ApplicationController
  def index
    if params[:view_type] == 'mypage'
      @cards = Card.all               #ココ
      render 'show_mypage'
    @cards = Card.all                 #ココ
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
      flash[:notice] = '追加しました。'
      redirect_to root_path
    else
      render 'new'#, status: :unprocessable_entity
    end
  end
  
  def destroy
    @card = Card.find(params[:id])
    if @card.destroy
      flash[:notice] = '削除しました。'
      redirect_to root_path
    else
      render 'index_mypage'#, status: :unprocessable_entity
    end
  end
  
  def show                             #ココ
    @card = Card.find(params[:id])
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
      flash[:notice] = '更新しました。'
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
