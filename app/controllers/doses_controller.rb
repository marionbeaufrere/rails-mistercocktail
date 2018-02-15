class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = Cocktail.find(params[:cocktail_id])
    # @dose.ingredient = Ingredient.find(params[:dose][:ingredient].to_i)
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail)
    else
      @cocktail = Cocktail.find(params[:cocktail_id])
      render :new
    end
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end