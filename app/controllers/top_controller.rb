class TopController < ApplicationController
    def main
        if session[:login_uid]
            redirect_to users_path
        end
    end
    
    def login_form
        #ログイン画面の表示
    end
    
    def login
        user = User.find_by(uid: params[:uid])
        if  user and BCrypt::Password.new(user.pass) == params[:pass]
            session[:login_uid] = params[:uid]
            redirect_to top_main_path
        else
            render "error",status:422 
        end
    end

    
    def logout
        session.delete(:login_uid)
        redirect_to root_path
    end

end
