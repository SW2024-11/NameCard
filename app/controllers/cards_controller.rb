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
  
    if current_user
      if @mypage
        # ログインしているユーザーが作成したカードのみを表示
        @cards = Card.search(params[:query])
                     .where(user: current_user)
                     .order(:created_at)
      else
        # 同じ会社の人が作成したカードをすべて表示
        @cards = Card.search(params[:query])
                     .where(company: current_user.my_company)
                     .order(:created_at)
      end
    else
      # ログインしていない場合は空の結果を返す
      @cards = Card.none
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
    @card = Card.new(card_params)
    @card.user = User.find_by(id: session[:login_uid])
    
    if @card.save
      redirect_to cards_path(mypage: true)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    @card = Card.find(params[:id])
    if @card.destroy
      redirect_to cards_path(mypage: true)
    else
      redirect_to cards_path(mypage: true)
    end
  end
  
  def show
    @card = Card.find(params[:id])
    @mypage = params[:mypage] == 'true'
    render 'show'
  end
  
  def edit
    @card = Card.find(params[:id])
  end
  
  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to cards_path(mypage: true)
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
