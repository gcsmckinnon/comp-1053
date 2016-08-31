require 'test_helper'

class CardSortResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card_sort_result = card_sort_results(:one)
  end

  test "should get index" do
    get card_sort_results_url
    assert_response :success
  end

  test "should get new" do
    get new_card_sort_result_url
    assert_response :success
  end

  test "should create card_sort_result" do
    assert_difference('CardSortResult.count') do
      post card_sort_results_url, params: { card_sort_result: { card_sort_id_id: @card_sort_result.card_sort_id_id, result: @card_sort_result.result } }
    end

    assert_redirected_to card_sort_result_url(CardSortResult.last)
  end

  test "should show card_sort_result" do
    get card_sort_result_url(@card_sort_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_sort_result_url(@card_sort_result)
    assert_response :success
  end

  test "should update card_sort_result" do
    patch card_sort_result_url(@card_sort_result), params: { card_sort_result: { card_sort_id_id: @card_sort_result.card_sort_id_id, result: @card_sort_result.result } }
    assert_redirected_to card_sort_result_url(@card_sort_result)
  end

  test "should destroy card_sort_result" do
    assert_difference('CardSortResult.count', -1) do
      delete card_sort_result_url(@card_sort_result)
    end

    assert_redirected_to card_sort_results_url
  end
end
