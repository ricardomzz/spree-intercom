class Spree::Intercom::Events::CustomerReturn::ReturnService < Spree::Intercom::BaseService

  def initialize(options)
    @user = Spree::User.find_by(id: options[:user_id])
    @order = Spree::Order.find_by(id: options[:order_id])
    @return = Spree::CustomerReturn.find_by(id: options[:customer_return_id])
    super()
  end

  def register
    send_request
  end

  def perform
    @intercom.events.create(event_data)
  end

  def event_data
    {
      event_name: 'order-return',
      created_at: @return.updated_at,
      user_id: @user.intercom_user_id,
      metadata: {
        order_number: @order.number,
        return_number: @return.number
      }
    }
  end

end
