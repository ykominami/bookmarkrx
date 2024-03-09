# frozen_string_literal: true

class PathxComponent < ViewComponent::Base
  def initialize(proxy:, proxy_klass:)
    @proxy = proxy
    @proxy_klass = proxy_klass
  end
end
