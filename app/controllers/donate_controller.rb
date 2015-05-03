class DonateController < ApplicationController
  def new
    @donor = Donor.new
  end

  def create
    require "pry"; binding.pry
    render 'show'
  end

  def show

  end
end
