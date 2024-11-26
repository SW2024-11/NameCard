class TopController < ApplicationController
    def top_page
        if session[:login_uid]
            redirect_to users_path
        end
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
end
