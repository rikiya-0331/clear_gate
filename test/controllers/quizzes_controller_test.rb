require "test_helper"

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  test "should get start" do
    get quizzes_start_url
    assert_response :success
  end

  test "should get create" do
    get quizzes_create_url
    assert_response :success
  end

  test "should get show" do
    get quizzes_show_url
    assert_response :success
  end

  test "should get answer" do
    get quizzes_answer_url
    assert_response :success
  end

  test "should get results" do
    get quizzes_results_url
    assert_response :success
  end
end
