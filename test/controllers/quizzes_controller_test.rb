require "test_helper"

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    # Start a quiz session to set the necessary session variables
    post start_quizzes_url, params: { category_id: categories(:one).id }
    @first_question = Question.find(session[:quiz_question_ids].first)
  end

  test "should get start" do
    get start_quizzes_url
    assert_response :success
  end

  test "should create another quiz" do
    # Test creation with a different category to ensure independence from setup
    assert_difference('QuizHistory.count', 1) do
      post start_quizzes_url, params: { category_id: categories(:two).id }
    end
    assert_response :redirect
  end

  test "should get show" do
    get quiz_url(@first_question)
    assert_response :success
  end

  test "should post answer" do
    assert_difference('QuizResult.count', 1) do
      post answer_quiz_url(@first_question), params: { choice_id: answer_choices(:one).id }
    end
    assert_response :success # Expects a JSON response
  end

  test "should get results" do
    get results_quizzes_url
    assert_response :success
  end
end
