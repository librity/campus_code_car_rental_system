# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can edit a manufacturer' do
  before :each do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user
  end

  scenario 'successfully' do
    manufacturer_one = Manufacturer.create name: 'Fiat'

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    within "tr#manufacturer-#{manufacturer_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Honda'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content('Honda')
    expect(page).to have_content I18n.t('views.messages.successfully.updated',
                                        resource: I18n.t('activerecord.models.manufacturer.one'))
  end

  scenario 'and name can not be blank' do
    manufacturer_one = Manufacturer.create name: 'Fiat'

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    within "tr#manufacturer-#{manufacturer_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'and name must be unique' do
    manufacturer_one = Manufacturer.create name: 'Fiat'
    Manufacturer.create name: 'Honda'

    visit root_path
    click_on I18n.t('activerecord.models.manufacturer.other')
    within "tr#manufacturer-#{manufacturer_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Honda'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.taken'))
  end
end
