class PinsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_pin, only: [:edit, :show, :update, :destroy]
    
    def index
        @pins = Pin.all.order("created_at DESC")
    end
    
    def new
        @pin = Pin.new
    end
    
    def create
        @pin = Pin.new(pin_params)
        @pin.user = current_user
        
        if @pin.save
            flash[:notice] = "Successfully new pin created"
            redirect_to @pin 
        else
            flash[:danger] = "Some error occurred while saving pin"
            render 'new'
        end
    end
    
    def edit
        
    end
    
    def update
        if @pin.update(pin_params)
            flash[:notice] = "Pin was successfullt updated"
            redirect_to @pin
        else
            flash[:danger] = "There was some error in updating. Please try again later"
            render 'edit'
        end
    end
    
    def destroy
        if @pin.destroy
            flash[:notice] = "Pin was successfully Deleted"
            redirect_to root_path
        else
            flash[:danger] = "There was some problem in deleting the Pin. Please try again later"
            redirect_to root_path
        end
    end
    
    def show
    end
    
    private
        def pin_params
           params.require(:pin).permit(:title, :description) 
        end
        
        def find_pin
           @pin = Pin.find(params[:id]) 
        end
end
