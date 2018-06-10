require "keyword_argnize/version"

module KeywordArgnize
  NOT_GIVEN = Object.new

  def keyword_argnize(method_id)
    m = instance_method(method_id)
    mod = Module.new do
      names = m.parameters.map(&:last)
      keys = names.map {|n| "#{n}: KeywordArgnize::NOT_GIVEN" }
      params = (["*args"] + keys).join(", ")
      module_eval(<<~RUBY)
      def #{method_id}(#{params})
        if args.empty?
          super(*[#{names.join(",")}].reject {|param| param == KeywordArgnize::NOT_GIVEN })
        else
          super(*args)
        end
      end
      RUBY
    end
    prepend(mod)
  end
end
