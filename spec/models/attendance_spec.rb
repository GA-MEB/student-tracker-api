require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe 'associations: Attendance' do
    def students_association
      Attendance.reflect_on_association(:student)
    end

    it 'is associated with a Student' do
      expect(students_association).not_to be_nil
      expect(students_association.macro).to be(:belongs_to)
      expect(students_association.options[:inverse_of]).not_to be_nil
    end
  end
end
