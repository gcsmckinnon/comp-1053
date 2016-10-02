require 'test_helper'

class QaOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qa_option = qa_options(:one)
  end

  test "should get index" do
    get qa_options_url
    assert_response :success
  end

  test "should get new" do
    get new_qa_option_url
    assert_response :success
  end

  test "should create qa_option" do
    assert_difference('QaOption.count') do
      post qa_options_url, params: { qa_option: { option: @qa_option.option, qa_game_id: @qa_option.qa_game_id } }
    end

    assert_redirected_to qa_option_url(QaOption.last)
  end

  test "should show qa_option" do
    get qa_option_url(@qa_option)
    assert_response :success
  end

  test "should get edit" do
    get edit_qa_option_url(@qa_option)
    assert_response :success
  end

  test "should update qa_option" do
    patch qa_option_url(@qa_option), params: { qa_option: { option: @qa_option.option, qa_game_id: @qa_option.qa_game_id } }
    assert_redirected_to qa_option_url(@qa_option)
  end

  test "should destroy qa_option" do
    assert_difference('QaOption.count', -1) do
      delete qa_option_url(@qa_option)
    end

    assert_redirected_to qa_options_url
  end
end
