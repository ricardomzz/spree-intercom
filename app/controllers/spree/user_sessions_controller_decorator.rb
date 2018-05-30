Spree::UserSessionsController.class_eval do

  include Spree::ControllerEventTracker

  before_action :destroy_data, only: :destroy  # done becuase spree_current_user wont be available after log out
  after_action :create_event_on_intercom, only: [:create, :destroy]

  private

    def create_data
      {
        time: Time.current.to_i,
        user_id: spree_current_user.id
      }
    end

    def destroy_data
      @data ||= create_data
    end

end
