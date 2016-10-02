require 'test_helper'

class QaQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qa_question = qa_questions(:one)
  end

  test "should get index" do
    get qa_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_qa_question_url
    assert_response :success
  end

  test "should create qa_question" do
    assert_difference('QaQuestion.count') do
      post qa_questions_url, params: { qa_question: { qa_game_id: @qa_question.qa_game_id, question: @qa_question.question, state: @qa_question.state } }
    end

    assert_redirected_to qa_question_url(QaQuestion.last)
  end

  test "should show qa_question" do
    get qa_question_url(@qa_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_qa_question_url(@qa_question)
    assert_response :success
  end

  test "should update qa_question" do
    patch qa_question_url(@qa_question), params: { qa_question: { qa_game_id: @qa_question.qa_game_id, question: @qa_question.question, state: @qa_question.state } }
    assert_redirected_to qa_question_url(@qa_question)
  end

  test "should destroy qa_question" do
    assert_difference('QaQuestion.count', -1) do
      delete qa_question_url(@qa_question)
    end

    assert_redirected_to qa_questions_url
  end
end
