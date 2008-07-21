module Hervalicious
  module DoubleSubmitProtection

    TOKEN_FIELD_NAME = "submit_token"
    SESSION_TOKEN_KEY = "submit_token"

    module View
      def double_submit_token
        session[SESSION_TOKEN_KEY] = Digest::MD5.hexdigest(rand.to_s)
        hidden_field_tag(TOKEN_FIELD_NAME, session[SESSION_TOKEN_KEY])
      end
    end

    module Controller
      def double_submit?
        request.post? && (session[SESSION_TOKEN_KEY] != params[TOKEN_FIELD_NAME])
      end
    end
  end
end

