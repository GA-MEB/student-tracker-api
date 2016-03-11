require 'rails_helper'

RSpec.describe Cohort, type: :model do
  describe 'validations: Cohort' do
    it "is valid with cohort number, start date, and end date" do
      cohort = Cohort.new(
        cohort_number: 10,
        start_date: '2016-01-19',
        end_date: '2016-04-08'
      )
      expect(cohort).to be_valid
    end
    it "is invalid without a cohort number" do
      no_cohort_num = Cohort.new(cohort_number: nil)
      no_cohort_num.valid?
      expect(no_cohort_num.errors[:cohort_number]).to include("can't be blank")
    end
    it "is invalid without a start date" do
      no_start_date = Cohort.new(start_date: nil)
      no_start_date.valid?
      expect(no_start_date.errors[:start_date]).to include("can't be blank")
    end
    it "is invalid without an end date" do
      no_end_date = Cohort.new(end_date: nil)
      no_end_date.valid?
      expect(no_end_date.errors[:end_date]).to include("can't be blank")
    end
    it "is invalid with a non-integer cohort number" do
      string_cohort_number = Cohort.new(cohort_number: "A string")
      string_cohort_number.valid?
      expect(string_cohort_number.errors[:cohort_number]).to include(
        "must be an integer greater than zero"
      )
      float_cohort_number = Cohort.new(cohort_number: 3.3)
      float_cohort_number.valid?
      expect(float_cohort_number.errors[:cohort_number]).to include(
        "must be an integer greater than zero"
      )
    end
    it "is invalid with a cohort number less than 1" do
      cohort_number_zero = Cohort.new(cohort_number: 0)
      cohort_number_zero.valid?
      expect(cohort_number_zero.errors[:cohort_number]).to include(
        "must be an integer greater than zero"
      )
      negative_cohort_number = Cohort.new(cohort_number: -1)
      negative_cohort_number.valid?
      expect(negative_cohort_number.errors[:cohort_number]).to include(
        "must be an integer greater than zero"
      )
    end
    it "is invalid with a non-unique cohort number" do
      original_cohort = Cohort.create(
        cohort_number: 3000,
        start_date: '2014-04-28',
        end_date: '2014-07-30'
      )
      duplicate_cohort_number = Cohort.new(
        cohort_number: 3000,
        start_date: '2014-04-28',
        end_date: '2014-07-30'
      )
      duplicate_cohort_number.valid?
      expect(duplicate_cohort_number.errors[:cohort_number]).to include(
        "must be unique"
      )
      original_cohort.destroy
    end
    it "is invalid with an invalid start date or end date" do
      invalid_start_date = Cohort.new(start_date: "banana")
      invalid_start_date.valid?
      expect(invalid_start_date.errors[:start_date]).to include(
        "must be a date"
      )
      invalid_end_date = Cohort.new(end_date: "banana")
      invalid_end_date.valid?
      expect(invalid_end_date.errors[:start_date]).to include(
        "must be a date"
      )
    end
    it "is invalid with a start date before 2012" do
      too_early_start = Cohort.new(start_date: '2010-01-01')
      too_early_start.valid?
      expect(too_early_start.errors[:start_date]).to include(
        "must not start before 2012"
      )
    end
    it "is invalid with a weekend start date or end date" do
      saturday_start = Cohort.new(start_date: '2016-01-30')
      saturday_start.valid?
      expect(saturday_start.errors[:start_date]).to include(
        "must not start on a weekend"
      )
      sunday_start = Cohort.new(start_date: '2016-01-31')
      sunday_start.valid?
      expect(sunday_start.errors[:start_date]).to include(
        "must not start on a weekend"
      )
      saturday_end = Cohort.new(end_date: '2016-01-30')
      saturday_end.valid?
      expect(saturday_end.errors[:end_date]).to include(
        "must not end on a weekend"
      )
      sunday_end = Cohort.new(end_date: '2016-01-31')
      sunday_end.valid?
      expect(sunday_end.errors[:end_date]).to include(
        "must not end on a weekend"
      )
    end
    it "is invalid with an end date on or before the start date" do
      same_start_end_dates = Cohort.new(
        start_date: '2015-01-01',
        end_date: '2015-01-01'
      )
      same_start_end_dates.valid?
      expect(same_start_end_dates.errors[:end_date]).to include(
        "can't be on or before the start date"
      )
      ends_before_start_date = Cohort.new(
        start_date: '2015-01-01',
        end_date: '2014-12-31'
      )
      ends_before_start_date.valid?
      expect(ends_before_start_date.errors[:end_date]).to include(
        "can't be on or before the start date"
      )
    end
    it "is invalid with an end date more than 120 days after the start date" do
      overlong_cohort = Cohort.new(
        start_date: '2016-01-01',
        end_date: '2016-05-01'
      )
      overlong_cohort.valid?
      expect(overlong_cohort.errors[:end_date]).to include(
        "can't be more than 120 days after the start date"
      )
    end
  end
  describe 'associations: Cohort' do
    def students_association
      Cohort.reflect_on_association(:students)
    end

    it 'is associated with Students' do
      expect(students_association).not_to be_nil
      expect(students_association.macro).to be(:has_many)
      expect(students_association.options[:inverse_of]).not_to be_nil
    end
  end
end
