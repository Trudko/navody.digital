module NotificationSubscriptionsHelper
  def render_notification_subscription_component(subscription_types, journey = nil, extra_attributes = {})
    group = NotificationSubscriptionGroup.new(subscription_types: subscription_types)
    group.user = current_user
    group.journey = journey
    render partial: 'notification_subscriptions/form', object: group, locals: { extra_attributes: extra_attributes }
  end
end
