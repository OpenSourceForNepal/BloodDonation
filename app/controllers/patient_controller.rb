class PatientController < ApplicationController
  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.where(cell_phone: patient_params[:cell_phone]).first_or_initialize(patient_params)

    if @patient.id.present?
      flash[:success] = 'We already have you on our needs list.'
      redirect_to donate_path(@patient)
    elsif @patient.save
      flash[:success] = "Thank you for registering with us. Here are hospitals / potential donors you can contact in your area."
      redirect_to donate_path(@patient)
    else
      render :new
    end
  end

  def show
    @patient = Patient.find(params[:id])
  end

  private
  def patient_params
    params.require(:patient).permit(:full_name, :cell_phone, :email, :address, :commute_radius, :blood_type, :lat, :long)
  end
end
