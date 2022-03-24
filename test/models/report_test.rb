# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable? should return true if someone is who write the report' do
    me = User.create!(email: 'aaa@example.com', password: 'password')
    my_report = me.reports.create!(title: '日報', content: 'テストです')
    she = User.create!(email: 'bbb@example.com', password: 'password')

    assert_not my_report.editable?(she)
    assert my_report.editable?(me)
  end

  test 'created_on should return date class' do
    me = User.create!(email: 'aaa@example.com', password: 'password')
    my_report = me.reports.create!(title: '日報', content: 'テストです')

    assert_not_instance_of Date, my_report.created_at
    assert_instance_of Date, my_report.created_on
  end
end
