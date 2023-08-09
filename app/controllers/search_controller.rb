require_relative '../exceptions/searchable_not_found_exception'

# Represents controller for search ability
class SearchController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    @pagy, @search_results = pagy(PgSearch.multisearch(params[:query]))
    raise SearchableNotFoundException, 'Nothing found' if @search_results.empty?
  rescue SearchableNotFoundException => e
    Rails.logger.error "Search results are empty: #{e.message}"
    redirect_to posts_path, notice: e.message
  end
end
