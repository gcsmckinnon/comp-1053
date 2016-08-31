require 'test_helper'

class CardSortCandidatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card_sort_candidate = card_sort_candidates(:one)
  end

  test "should get index" do
    get card_sort_candidates_url
    assert_response :success
  end

  test "should get new" do
    get new_card_sort_candidate_url
    assert_response :success
  end

  test "should create card_sort_candidate" do
    assert_difference('CardSortCandidate.count') do
      post card_sort_candidates_url, params: { card_sort_candidate: { age: @card_sort_candidate.age, describing_tags: @card_sort_candidate.describing_tags, first_name: @card_sort_candidate.first_name, last_name: @card_sort_candidate.last_name } }
    end

    assert_redirected_to card_sort_candidate_url(CardSortCandidate.last)
  end

  test "should show card_sort_candidate" do
    get card_sort_candidate_url(@card_sort_candidate)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_sort_candidate_url(@card_sort_candidate)
    assert_response :success
  end

  test "should update card_sort_candidate" do
    patch card_sort_candidate_url(@card_sort_candidate), params: { card_sort_candidate: { age: @card_sort_candidate.age, describing_tags: @card_sort_candidate.describing_tags, first_name: @card_sort_candidate.first_name, last_name: @card_sort_candidate.last_name } }
    assert_redirected_to card_sort_candidate_url(@card_sort_candidate)
  end

  test "should destroy card_sort_candidate" do
    assert_difference('CardSortCandidate.count', -1) do
      delete card_sort_candidate_url(@card_sort_candidate)
    end

    assert_redirected_to card_sort_candidates_url
  end
end
