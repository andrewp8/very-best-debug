class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at => :desc)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)
    render({ :template => "venue_templates/details" })
  end

  def create
    venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    if venue.name.present?
      venue.save
      matching_venue = Venue.where({:address => venue.address, :name => venue.name, :neighborhood => venue.neighborhood }).first
      redirect_to("/venues/#{matching_venue.id}", {:notice => "Venue created successfully."})
    else
      redirect_to("/venues")
    end
  end
  
  def update
    the_id = params.fetch("venue_id")

    venue = Venue.where({ :id => the_id }).first
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    if venue.name.present?
      venue.save
    end
    redirect_to("/venues/#{venue.id}")
    
  end

  def destroy
    the_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.first
    venue.destroy

    redirect_to("/venues")
  end

end
