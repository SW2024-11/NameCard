class TopController < ApplicationController
    def top_page
        if session[:login_uid]
            redirect_to users_path
        end
    end
end
