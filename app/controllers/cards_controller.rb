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
         # 会社ページの場合、ユーザーの所属する会社に所属する全ユーザーのカードを表示
        @cards = Card.search(params[:query])
                     .joins(:user) # ユーザーとカードを結合
                     .where(users: { my_company: current_user.my_company }) # ユーザーの会社が一致
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
    @user_memo = @card.memo_for(current_user)
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

  before_action :set_card, only: [:show, :edit, :update, :update_memo, :destroy]

  def update_memo
    @card.update_memo_for(current_user, params[:memo])
    redirect_to card_path(@card, mypage: params[:mypage])
  end
end

private

def card_params
  params.require(:card).permit(:company, :name, :position, :license, :mail, :tell, :company_adress, :image)
end

def set_card
    @card = Card.find(params[:id])
end