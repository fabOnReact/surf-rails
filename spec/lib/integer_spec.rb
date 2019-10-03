require 'rails_helper'
require 'core_ext/integer'

describe Integer do
  Integer.include(Integer::Transformations)
  describe '#next_day' do 
    it 'returns the next day of the week' do
      expect(1.next_day).to be 3
      expect(6.next_day).to be 2
    end
  end
end
