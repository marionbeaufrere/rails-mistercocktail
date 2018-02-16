class CocktailsController < ApplicationController
  def index
    # @cocktails = Cocktail.all
    @cocktails = if params[:term]
      Cocktail.where('lower(name) LIKE ?', "%#{params[:term]}%")
    else
      Cocktail.all
    end
    # @cocktails = Cocktail.search(params[:term])
  end

  # def self.search(term)
  #   if term
  #     where('name LIKE ?', "%#{term}%")
  #   else
  #     all
  #   end
  # end

  def show
    @cocktail = Cocktail.find(params[:id])
    @doses = @cocktail.doses
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to new_cocktail_dose_path(@cocktail)
    else
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :term)
  end

end
