def count_2s_answer(n)
  (0..n).inject(0) { |sum, num| sum + num.to_s.count('2') }
end

def count_2s(n)
  digits = Math.log(n, 10).floor + 1
  num_2s = (0...digits).inject(0) do |sum, i|
    sum + ((n + 7 * (10**i) + 1) / (10**(i+1)) * (10**i))
  end
  n_str = n.to_s
  n_str.each_char.with_index do |c, i|
    break if i == n_str.length - 1
    if c == '2'
      the_rest = n_str.slice((i+1)..-1)
      unless the_rest =~ /^9*$/
        num_2s += the_rest.to_i
        num_2s += 1
      end
    end
  end
  num_2s
end




require 'minitest/autorun'

NUMS = (1..100000).to_a
SAFE_NUMS = NUMS.reject { |num| num.to_s.include?('2') }

describe 'counter' do
  it 'works for numbers without a 2' do
    10.times do
      num = SAFE_NUMS.sample
      count_2s(num).must_equal count_2s_answer(num)
    end
  end

  it 'works for all numbers' do
    100.times do
      num = NUMS.sample
      count_2s(num).must_equal count_2s_answer(num)
    end
  end
end
