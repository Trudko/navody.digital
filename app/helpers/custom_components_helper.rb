module CustomComponentsHelper
  def raw_with_custom_components(stringish)
    fragment = Nokogiri::HTML.fragment(stringish)

    fragment.css('embedded-app').each do |f|
      f.replace render_embedded_app(f)
    end

    fragment.css('notification-subscription').each do |f|
      f.replace render_notification_subscription(f)
    end

    raw(fragment.to_s)
  end

  private

  def render_embedded_app(fragment)
    @app_id = fragment['app-id']

    if @app_id == 'narodenie-rodny-list'
      @extra_attributes = fragment.attributes.except("app-id").map { |k,v| [k.to_sym, v.value] }.to_h
      render template: 'apps/child_birth_app/picking_up_protocol/start', layout: 'layouts/embedded_app'
    end
  end

  def render_notification_subscription(fragment)
    subscription_types = fragment[:types].split(',')
    extra_attributes = fragment.attributes.except('types').map { |k,v| [k.to_sym, v.value] }.to_h
    render_notification_subscription_component(subscription_types, nil, extra_attributes)
  end
end
