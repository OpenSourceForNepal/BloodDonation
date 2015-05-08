class DonateController < ApplicationController
  def new
    @donor = Donor.new
  end

  def create
    @donor = Donor.where(cell_phone: donor_params[:cell_phone]).first_or_initialize(donor_params)

    if @donor.id.present?
      flash[:success] = 'We already have you on Donor List, if you have not please go ahead and donate your blood to following people /hospitals.'
      redirect_to donate_path(@donor)
    elsif @donor.save
      flash[:success] = "Thanks for being a Donor, please go ahead and donate blood to following people / hospital."
      redirect_to donate_path(@donor)
    else
      render :new
    end
  end

  def show
    @donor = Donor.find(params[:id])
  end

  private
  def donor_params
    params.require(:donor).permit(:full_name, :cell_phone, :email, :address, :commute_radius, :blood_type, :lat, :long)
  end
end
