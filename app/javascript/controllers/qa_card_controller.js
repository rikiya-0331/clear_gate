import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="qa-card"
export default class extends Controller {
  static values = { 
    questionId: Number,
    answerUrl: String
  }

  checkAnswer(event) {
    const answerChoiceId = event.currentTarget.dataset.answerChoiceId;
    const url = this.answerUrlValue;

    // CSRFトークンを取得
    const csrfToken = document.querySelector("meta[name='csrf-token']").content;

    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ answer_choice_id: answerChoiceId })
    })
    .then(response => response.json())
    .then(data => {
      const feedbackText = document.getElementById("feedback-text");
      const nextQuestionLink = document.getElementById("next-question-link");
      const resultsLink = document.getElementById("results-link");
      const feedbackContainer = document.getElementById("feedback");
      const answerButtons = document.querySelectorAll(".answer-button");

      // ボタンを無効化
      answerButtons.forEach(button => button.disabled = true);

      // 正解・不正解のフィードバックを表示
      feedbackText.textContent = data.correct ? "正解です！" : "不正解です。";
      feedbackContainer.style.display = "block";

      if (data.next_question_url) {
        nextQuestionLink.href = data.next_question_url;
        nextQuestionLink.style.display = "block";
        resultsLink.style.display = "none";
      } else if (data.results_url) {
        resultsLink.href = data.results_url;
        resultsLink.style.display = "block";
        nextQuestionLink.style.display = "none";
      }
    })
    .catch(error => {
      console.error("Error:", error);
    });
  }
}
