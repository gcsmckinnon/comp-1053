require 'test_helper'

class QaGamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qa_game = qa_games(:one)
  end

  test "should get index" do
    get qa_games_url
    assert_response :success
  end

  test "should get new" do
    get new_qa_game_url
    assert_response :success
  end

  test "should create qa_game" do
    assert_difference('QaGame.count') do
      post qa_games_url, params: { qa_game: { name: @qa_game.name } }
    end

    assert_redirected_to qa_game_url(QaGame.last)
  end

  test "should show qa_game" do
    get qa_game_url(@qa_game)
    assert_response :success
  end

  test "should get edit" do
    get edit_qa_game_url(@qa_game)
    assert_response :success
  end

  test "should update qa_game" do
    patch qa_game_url(@qa_game), params: { qa_game: { name: @qa_game.name } }
    assert_redirected_to qa_game_url(@qa_game)
  end

  test "should destroy qa_game" do
    assert_difference('QaGame.count', -1) do
      delete qa_game_url(@qa_game)
    end

    assert_redirected_to qa_games_url
  end
end
