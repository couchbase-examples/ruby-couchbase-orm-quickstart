# frozen_string_literal: true

# Parses the `limit` and `offset` query parameters for list endpoints.
#
# The models' N1QL `query_fn`s interpolate these values directly into
# `LIMIT ... OFFSET ...`, so they must reach the model as non-negative
# Integers. Invalid values raise ArgumentError, which the actions already
# render as 400 Bad Request.
module Pagination
  extend ActiveSupport::Concern

  DEFAULT_LIMIT = 10
  DEFAULT_OFFSET = 0

  private

  # Returns [limit, offset] as non-negative Integers.
  def pagination_params
    [pagination_integer(:limit, DEFAULT_LIMIT), pagination_integer(:offset, DEFAULT_OFFSET)]
  end

  def pagination_integer(name, default)
    raw = params[name]
    return default if raw.blank?

    value = Integer(raw.to_s, 10, exception: false)
    raise ArgumentError, "#{name} must be a non-negative integer" if value.nil? || value.negative?

    value
  end
end
