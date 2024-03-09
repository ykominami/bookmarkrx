# frozen_string_literal: true

class BookmarklistComponent < ViewComponent::Base
  def initialize(proxy:, proxy_klass:)
    @proxy = proxy
    @proxy_klass = proxy_klass
  end
end
