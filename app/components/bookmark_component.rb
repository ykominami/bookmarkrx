# frozen_string_literal: true

class BookmarkComponent < ViewComponent::Base
  def initialize(proxy:)
    @proxy = proxy
    @href = @proxy.href
    @desc = @proxy.desc
  end
end
