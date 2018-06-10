class C
  extend KeywordArgnize

  keyword_argnize \
  def func(a)
    a + 1
  end
end

c = C.new
p c.func(1)
p c.func(a: 3)
