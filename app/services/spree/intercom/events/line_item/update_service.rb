class Spree::Intercom::Events::LineItem::UpdateService < Spree::Intercom::BaseService

  def initialize(options)
    @user = Spree::User.find_by(id: options[:user_id])
    @line_item = Spree::LineItem.find_by(id: options[:line_item_id])
    @options = options
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
      event_name: 'changed-product-quantity',
      created_at: @line_item.updated_at,
      user_id: @user.intercom_user_id,
      metadata: {
        order_number: @options[:order_number],
        product: @line_item.name,
        sku: @options[:sku],
        quantity: @line_item.quantity
      }
    }
  end

end
