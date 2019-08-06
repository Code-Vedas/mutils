module Mutils

  # Paginate Module
  module Paginate
    extend ActiveSupport::Concern

    def page(page, page_size)
      limit(page_size).offset((page - 1) * page_size)
    end
  end
end