# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:alice_report)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
    assert_text 'タイトル'
    assert_text 'テスト日報1'
    assert_text '作成者'
    assert_text 'alice'
    assert_text '作成日'
    assert_instance_of Date, @report.created_on
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規作成'

    assert_selector 'h1', text: '日報の新規作成'
    fill_in 'タイトル', with: 'テスト日報2'
    fill_in '内容', with: '日報を新規作成するテストです'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'テスト日報2'
    assert_text '日報を新規作成するテストです'
  end

  test 'updating a Report' do
    visit reports_url
    click_on '編集', match: :prefer_exact

    assert_selector 'h1', text: '日報の編集'
    fill_in 'タイトル', with: 'テスト日報3'
    fill_in '内容', with: '日報を編集するテストです'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text 'テスト日報3'
    assert_text '日報を編集するテストです'
  end

  test 'destroying a Report' do
    visit reports_url
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '日報が削除されました。'
  end
end
