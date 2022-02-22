class SessionsController < ApplicationController
    def new
    end 

    def create
        # is the email entered already in the database? find_by allows to search for exactly one entry
        entered_email = params["email"]
        entered_password = params["password"]
        @user = User.find_by({email: entered_email})

        if @user #if yes, email matches, check password
            if BCrypt::Password.new(@user.password) == entered_password
                #if password matches, redirect to 
                session["user_id"] = @user.id
               flash[:notice] = "Welcome!"
                redirect_to "/companies"
            else 
                #password does not match
                flash[:notice] = "Password is incorrect"
                redirect_to "/sessions/new"
            end 
       else
        #email doesn't match, send back to login page
        flash[:notice] = "No user with that email address"
        redirect_to "/sessions/new"
       end
    end 

    def destroy
        session["user_id"] = nil
        flash[:notice] = "You have been logged out"
        redirect_to "/sessions/new"
    end 
end
