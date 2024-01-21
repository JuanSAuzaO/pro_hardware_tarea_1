module RackSessionsFix
  extend ActiveSupport::Concern
  # We create a fake session hash for Devise to write into, because Rails 7 Apis
  # don't allow to manage ActionDispatch::Session objects
  class FakeRackSession < Hash
    def enabled?
      false
    end

    def destroy; end
  end

  included do
    before_action :set_fake_session

    private

    def set_fake_session
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end