require 'test_helper'

class CardSortsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card_sort = card_sorts(:one)
  end

  test "should get index" do
    get card_sorts_url
    assert_response :success
  end

  test "should get new" do
    get new_card_sort_url
    assert_response :success
  end

  test "should create card_sort" do
    assert_difference('CardSort.count') do
      post card_sorts_url, params: { card_sort: { code: @card_sort.code, description: @card_sort.description, name: @card_sort.name } }
    end

    assert_redirected_to card_sort_url(CardSort.last)
  end

  test "should show card_sort" do
    get card_sort_url(@card_sort)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_sort_url(@card_sort)
    assert_response :success
  end

  test "should update card_sort" do
    patch card_sort_url(@card_sort), params: { card_sort: { code: @card_sort.code, description: @card_sort.description, name: @card_sort.name } }
    assert_redirected_to card_sort_url(@card_sort)
  end

  test "should destroy card_sort" do
    assert_difference('CardSort.count', -1) do
      delete card_sort_url(@card_sort)
    end

    assert_redirected_to card_sorts_url
  end
end
