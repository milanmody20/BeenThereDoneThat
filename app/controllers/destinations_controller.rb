class DestinationsController < ApplicationController

    def index
        @destinations = Destination.order_by_country           #order_by_country is a scope method defined in models/estination.rb
    end

    def new     #render a new form
        @destination = Destination.new
        @destination.pins.build
    end

    def show
        find_destination
    end

    def create
        @destination = Destination.new(destination_params)
        if @pin.save
            redirect_to destination_path(@destination)
        else
            render :new
        end
    end

    def edit
        find_destination
    end

    def update
        find_destination
        @destination.update(params[:destination])
    end

    def destroy
        find_destination
        @destination.destroy
            redirect_to destinations_path
    end

    private
    def destination_params      #strong params which permits fields being created
        params.require(:destination).permit(:city, :country, pins_attributes: [:rating, :date])
    end

    def find_destination
        @destination = Destination.find_by(params[:destination_id])
    end

end
