# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can edit a car model' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'successfully' do
    honda = Manufacturer.create! name: 'Honda'
    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    car_model_one = CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                                     fuel_type: 'gasolina', metric_city_milage: 12,
                                     metric_highway_milage: 16, engine: '1.6 L R16A1 I4'

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    within "tr#car-model-#{car_model_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Fit'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content('Fit')
    expect(page).to have_content I18n.t('views.messages.successfully.updated',
                                        resource: I18n.t('activerecord.models.car_model.one'))
  end

  scenario 'and name can not be blank' do
    honda = Manufacturer.create! name: 'Honda'
    sedan = CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                                third_party_insurance: 5.0

    car_model_one = CarModel.create! name: 'Civic', year: '2010', manufacturer: honda,
                                     metric_horsepower: '135 @ 6500 rpm', car_category: sedan,
                                     fuel_type: 'gasolina', metric_city_milage: 12,
                                     metric_highway_milage: 16, engine: '1.6 L R16A1 I4'

    visit root_path
    click_on I18n.t('activerecord.models.car_model.other')
    within "tr#car-model-#{car_model_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end
end
