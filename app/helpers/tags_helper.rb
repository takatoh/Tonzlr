module TagsHelper

  def odd_or_even(i)
    ["even", "odd"][i % 2]
  end

end
