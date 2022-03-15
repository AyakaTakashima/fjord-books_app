# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:momotaro)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本'
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'

    fill_in 'タイトル', with: '３匹の子ぶた'
    fill_in 'メモ', with: '３匹の子ぶたの生き様を描いた話'
    fill_in '著者', with: 'オオカミさん'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text '３匹の子ぶた'
    assert_text '３匹の子ぶたの生き様を描いた話'
    assert_text 'オオカミさん'
  end

  test 'updating a Book' do
    visit books_url
    click_on '編集', match: :prefer_exact

    fill_in 'タイトル', with: 'となりのトトロ'
    fill_in 'メモ', with: 'トトロっていいよね'
    fill_in '著者', with: 'さつきとメイ'
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text 'となりのトトロ'
    assert_text 'トトロっていいよね'
    assert_text 'さつきとメイ'
  end

  test 'destroying a Book' do
    visit books_url
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '本が削除されました。'
  end
end
