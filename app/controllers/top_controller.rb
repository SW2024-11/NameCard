class TopController < ApplicationController
    def main
        if session[:login_uid]
            redirect_to cards_path
        end
    end
    
    def login_form
        #ログイン画面の表示
    end
    
    def login
        user = User.find_by(my_name: params[:my_name])
        if  user && user.pass == params[:pass]
            session[:login_uid] = user.id  #params[:my_name]
            redirect_to top_main_path
        else
            redirect_to top_login_path
        end
    end

    
    def logout
        session.delete(:login_uid)
        redirect_to root_path
    end

end
