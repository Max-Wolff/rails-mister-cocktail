class DosesController < ApplicationController
  # resources :doses, only: [:show, :new, :create, :destroy]
  def new
    id = params[:cocktail_id].to_i
    @cocktail = Cocktail.find(id)
    @dose = Dose.new(cocktail_id: id)
  end

  def create
    id = params[:cocktail_id].to_i
    @cocktail = Cocktail.find(id)
    @dose = Dose.new(dose_params)
    if @dose.save
      p @dose
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
  end

  private

  def dose_params
    params.require(:dose).permit(:cocktail_id, :description, :ingredient_id)
  end
end
