class HospitalController < ApplicationController
  def new
    @hospital = Hospital.new
  end

  def create
    @hospital = Hospital.where(contact_person_phone: hospital_params[:contact_person_phone]).first_or_initialize(hospital_params)

    if @hospital.id.present?
      flash[:success] = 'We already have this hospital on our list. Here are potential donors near the hospital\'s location'
      redirect_to hospital_path(@hospital)
    elsif @hospital.save
      flash[:success] = "Thank you for registering with us. Here are potential donors you can contact in your area."
      redirect_to hospital_path(@hospital)
    else
      render :new
    end
  end

  def show
    @hospital = Hospital.find(params[:id])
  end

  private
  def hospital_params
    params.require(:hospital).permit(:name, :city, :state, :contact_person_phone, :lat, :long)
  end
end