class Array
  def my_each(&prc)
    i = 0
    until i == self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    selected = []
    self.my_each do |element|
      if prc.call(element)
        selected << element
      end
    end
    selected
  end

  def my_reject(&prc)
    selected = []
    self.my_each do |element|
      unless prc.call(element)
        selected << element
      end
    end
    selected
  end

  def my_any?(&prc)
    return true unless self.my_select(&prc) == []
    false
  end

  def my_all?(&prc)
    return true if self.my_select(&prc) == self
    false
  end

  def my_flatten
    flattened_array = []

    self.my_each do |el|
      if el.is_a?(Array)
        el.my_flatten.my_each do |el2|
          flattened_array << el2
        end
      else
        flattened_array << el
      end
    end

    flattened_array
  end

  def my_zip(*args)
    zipped_array = []
    (0...self.length).each do |index|
      inner_array = []
      inner_array << self[index]
      args.each { |arg| inner_array << arg[index] }

      zipped_array << inner_array
    end
    zipped_array
  end

  def my_rotate(shift = 1)
    rotated_array = self.dup
    shift %= self.length
    shift.times do
      rotated_array.push(rotated_array.shift)
    end
    rotated_array
  end

  def my_join(separator = "")
    joined_str = ""
    self.each_with_index do |char, i|
      if i == self.length - 1
        joined_str << char
      else
        joined_str << char << separator
      end
    end

    joined_str
  end

  def my_reverse
    reversed_array = []

    self.each do |el|
      reversed_array.unshift(el)
    end

    reversed_array
  end

  def bubble_sort!(&prc)
    prc ||= Proc.new { |num1, num2| num1 <=> num2 }

    sort = false
    until sort == true
      sort = true

      self.each_with_index do |el, i|
        if i != self.length - 1 && prc.call(el, self[i + 1]) == 1
          self[i], self[i + 1] = self[i + 1], self[i]
          sort = false
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end
end

def factors(num)
  (1..num).to_a.select { |el| num % el == 0 }
end

def substrings(str)
  all_substrings = []
  (0...str.length).each do |i|
    (0...str.length).each do |i2|
      all_substrings << str[i..i2]
    end
  end

  all_substrings
end

def subwords(word, dictionary)
  substrings(word).select { |substr| dictionary.include?(substr) }.uniq
end
