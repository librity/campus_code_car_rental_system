# frozen_string_literal: true

require 'rails_helper'

describe CarCategory, type: :model do
  subject do
    described_class.new(name: 'SUV', daily_rate: 1.23, insurance: 4.52,
                        third_party_insurance: 16.61)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: name' do
    it 'cannot be blank' do
      subject.name = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include(I18n.t('models.validations.not_empty', attribute: I18n.t('views.labels.name')))
    end

    it 'must be unique' do
      subject.save!

      car_category = CarCategory.new(name: 'SUV')

      expect(car_category).to_not be_valid
      expect(car_category.errors[:name]).to include(I18n.t('models.validations.unique', attribute: I18n.t('views.labels.name')))
    end
  end
end
