class CardsController < ApplicationController
  #def index
  #  if params[:view_type] == 'mypage'
  #    @view_type = params[:view_type]
  #    card_ids = params[:card_ids].split(',')
  #    @cards = Card.search(params[:query]).where(id: card_ids).order(:created_at)
  #    render 'index_mypage'
  #  else
  #    @cards = Card.search(params[:query]).order(:created_at)
  #    render 'index'
  #  end
  #end
  
  def index
    @mypage = params[:mypage] == 'true'
    @cards = if @mypage
               Card.search(params[:query])
                   .where(company: current_user.company)
                   .order(:created_at)
             else
               Card.search(params[:query])
                   .order(:created_at)
             end
    render 'index'
  end
  
  def new
    @card = Card.new
  end
  
  #def create
  #  c = Card.new(card_params)
  #  c.user = User.find_by(my_name: session[:login_uid])
  #  if c.save
  #    redirect_to card_with_view_type_path(params[:id], 'mypage')
  #  else
  #    render 'new'
  #  end
  #end
  
  def create
    c = Card.new(card_params)
    c.user = User.find_by(my_name: session[:login_uid])
    if c.save
      redirect_to cards_path
    else
      render 'new'
    end
  end
  
  def destroy
    @card = Card.find(params[:id])
    if @card.destroy
      redirect_to cards_path
    else
      redirect_to cards_path
    end
  end
  
  def show
    @card = Card.find(params[:id])
    render 'show'
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
      redirect_to cards_path
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
