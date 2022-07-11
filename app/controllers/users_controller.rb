class UsersController < ApplicationController

    def index
       # call_action
    end 

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    
    end


    def update
        respond_to do |format|
            if @user.update(friend_params)
              format.html { redirect_to user_url(@user), notice: "user was successfully updated." }
              format.json { render :show, status: :ok, location: @user }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
        
    end


    def scrape
        @user = User.find(params[:id])
        @user.role = 2
        @user.save
      end



      private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

          # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:nom, :role)
      end

      def set_admin
        @user = User.find(params[:id])
        @user.role = 2
        @user.save

        respond_to do |format|
            format.html { redirect_to users_path, notice: "notif 2 vers admin" }
        end

    end

     # Only allow a list of trusted parameters through.
     def user_params
        params.require(:user).permit(:email, :nom, :role)
      end
  

end
