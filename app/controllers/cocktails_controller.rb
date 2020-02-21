require 'open-uri'
require 'nokogiri'

class CocktailsController < ApplicationController
  # resources :cocktails [:index, :show, :new, :create]
  before_action :set_cocktail, only: [:show]

  def index
    @cocktails = Cocktail.all
    @cocktail = Cocktail.new
  end

  def show
    id = @cocktail.id
    @dose = Dose.new(cocktail_id: id)
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    scraper(@cocktail)
    if @cocktail.save
      redirect_to cocktails_path
    else
      @cocktail.picture_url = "https://images.unsplash.com/photo-1470337458703-46ad1756a187?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1649&q=80"
      @cocktail.save
      redirect_to cocktails_path
    end
  end

  def destroy
    set_cocktail
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :picture_url)
  end

  def scraper(cocktail)
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{@cocktail.name}"
    html_doc = Nokogiri::HTML(open(url).read)
    html_doc.search('.teaser-item__image img').each do |element|
      image_tag = element.attributes
      cocktail.picture_url = "https://#{image_tag["src"].value}"
    end
  end
end
