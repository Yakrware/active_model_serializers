module ActiveModel
  class Serializer
    class Adapter
      extend ActiveSupport::Autoload
      autoload :Json
      autoload :Null
      autoload :JsonApi

      attr_reader :serializer

      def initialize(serializer, options = {})
        @serializer = serializer
      end

      def serializable_hash(options = {})
        raise NotImplementedError, 'This is an abstract method. Should be implemented at the concrete adapter.'
      end

      def to_json(options = {})
        result = serializable_hash(options)

        if root = options.fetch(:root, serializer.json_key)
          result = { root => result }
        end

        result.to_json
      end
    end
  end
end
