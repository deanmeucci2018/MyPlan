module SessionsHelper
    
    def log_in(user)
        session[:user_id] = user.id #saves the id of the user to the session hash
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
            #this could also be written as: 
            #@current_user = @current_user || User.find_by(id: session[:user_id])
            #this means that if the @current_user is not nil, return it, otherwise, assign to it the User object with the specified id. 
    end

    def logged_in?
        !current_user.nil? #returns true if the user is logged in and false otherwise. This can of course be implemented differently.
    end

    def  log_out
        session.delete(:user_id) 
        @current_user = nil
    end
    #logout current user by deleting its id from the session and setting @current_user to nil


    def current_user?(user)
	    user == current_user  #returns true if the parameter is the current user that is logged in.
    end

    
end
