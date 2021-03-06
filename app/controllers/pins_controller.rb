class PinsController < ApplicationController
    before_action :find_pin, except: [:index, :new, :create]
    before_action :set_user, only: [:new, :index, :create, :destroy]

    def index
        if params[:destination_id] && @destination = Destination.find_by(id: params[:destination_id])
            @pins = @destination.pins
        else
            @pins = Pin.all
        end
    end

    def new     #render a new form
        if params[:destination_id] && @destination = Destination.find_by(id: params[:destination_id])
            @pin = @destination.pins.build                           #.build helps buidling associated objects
        else
            @pin = Pin.new
            @pin.build_destination
        end
    end

    def show
    end

    def create
        @pin = current_user.pins.build(pin_params)
        if @pin.save
                redirect_to user_path(current_user, @pin)
        else
                redirect_to new_pin_path
        end
            #--------------------------------

        # @pin = current_user.pins.build(pin_params)
        #     if params[:pin][:destination_id]
        #         # byebug
        #         @destination = Destination.find_by(id: params[:pin][:destination_id])
        #         # @pin= @destination.pin.build(pin_params)
        #         @pin.destination = @destination
        #     end
        #     # byebug
        #     if @pin.save
        #         redirect_to pin_path(@pin)
        #     else
        #         render :new
        #     end
    end

    def edit
    end

    def update
        @pin.update(pin_params)
        if @pin.save
            redirect_to pin_path(@pin)
        else
            render :edit
        end
    end

    def destroy
        @pin.destroy
            redirect_to current_user
    end

    private
    def set_user
        @user = User.find_by(id: params[:user_id])
    end

    def pin_params      #strong params which permits fields being created
        params.require(:pin).permit(:rating, :date, :user_id, :destination_id, destination_attributes: [:city, :country])
    end

    def find_pin
        @pin = Pin.find_by_id(params[:id])
    end
end