Spree::ProductsController.class_eval do

  include Spree::EventTrackerController

  after_action :create_event_on_intercom, only: [:show, :index], if: :product_search_conditions_satisfied?

  private

    def show_data
      {
        product_id: @product.id,
        time: Time.current.to_i,
        user_id: spree_current_user.id
      }
    end

    def index_data
      {
        filter: @searcher.search.to_s,
        keyword: params[:keywords],
        taxon_id: params[:taxon],
        time: Time.current.to_i,
        user_id: spree_current_user.id
      }
    end

    def product_search_conditions_satisfied?
      return true unless action_name == 'index'
      params[:keywords].present? || @searcher.search.present?
    end

end
