class HomeController < ApplicationController
  ITEMS_PER_PAGE = 20

  def index

  end

  def search
    flash[:warning] = "You must specify some search criteria." if !params.has_key?(:bloodtype)
    @donors = Donor.search(params[:bloodtype]).order("created_at ASC").paginate(:page => params[:page], :per_page => ITEMS_PER_PAGE)
  end
end
