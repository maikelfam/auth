class ApplicationController < ActionController::Base
    before_action :current_user
    #before any action is taken, run this method for all controllers

    def current_user
        if session["user_id"]
            @current_user = User.find(session["user_id"])
        end
    end 
end
