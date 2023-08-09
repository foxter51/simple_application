# Represents controller for search ability
class SearchController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    @pagy, @search_results = pagy(PgSearch.multisearch(params[:query]))
  end
end
