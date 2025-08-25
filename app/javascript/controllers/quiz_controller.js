import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {
  static targets = [
    "progressBar",
    "questionCounter",
    "totalQuestions",
    "questionTitle",
    "choices",
    "choice",
    "submitButton",
    "showAnswerButton",
    "nextButton",
    "feedback",
    "explanation"
  ]

  static values = {
    questionId: Number,
    answerUrl: String,
    nextUrl: String,
    currentQuestionNumber: Number,
    totalQuestions: Number
  }

  connect() {
    this.submitButtonTarget.disabled = true
    this.updateProgressBar()
  }

  updateProgressBar() {
    const percentage = (this.currentQuestionNumberValue / this.totalQuestionsValue) * 100;
    this.progressBarTarget.style.width = `${percentage}%`;
  }

  selectChoice(event) {
    this.choiceTargets.forEach(choiceRadio => {
      const label = choiceRadio.closest('label');
      label.classList.remove('ring-2', 'ring-indigo-500', 'bg-indigo-50');
    });

    const selectedLabel = event.currentTarget;
    selectedLabel.classList.add('ring-2', 'ring-indigo-500', 'bg-indigo-50');
    const radio = selectedLabel.querySelector('input[type="radio"]');
    radio.checked = true;

    this.submitButtonTarget.disabled = false;
  }

  async submitAnswer(event) {
    event.preventDefault();
    const selectedChoice = this.choiceTargets.find(radio => radio.checked);
    if (!selectedChoice) return;

    const choiceId = selectedChoice.value;

    const response = await post(this.answerUrlValue, {
      body: { choice_id: choiceId },
      responseKind: "json"
    });

    if (response.ok) {
      const data = await response.json;
      this.renderFeedback(data);
      this.updateChoiceStyles(data.correct_choice_id, data.selected_choice_id);
      this.disableChoices();

      this.submitButtonTarget.classList.add('hidden');
      this.showAnswerButtonTarget.classList.remove('hidden');
      this.nextButtonTarget.classList.remove('hidden');
    } else {
      console.error("An error occurred.");
      this.feedbackTarget.textContent = "エラーが発生しました。";
      this.feedbackTarget.classList.remove('hidden', 'bg-green-100', 'text-green-800', 'bg-red-100', 'text-red-800');
      this.feedbackTarget.classList.add('bg-red-100', 'text-red-800');
    }
  }

  renderFeedback({ correct, question_answer_jp }) {
    this.feedbackTarget.classList.remove('hidden');
    if (correct) {
      this.feedbackTarget.textContent = "正解！";
      this.feedbackTarget.classList.add('bg-green-100', 'text-green-800');
    } else {
      this.feedbackTarget.textContent = `不正解！正解は「${question_answer_jp}」`;
      this.feedbackTarget.classList.add('bg-red-100', 'text-red-800');
    }
  }

  updateChoiceStyles(correctChoiceId, selectedChoiceId) {
    this.choiceTargets.forEach(radio => {
      const label = radio.closest('label');
      label.classList.remove('ring-2', 'ring-indigo-500', 'bg-indigo-50', 'hover:bg-gray-100');
      label.classList.add('cursor-default');

      if (radio.value == correctChoiceId) {
        label.classList.add('bg-green-100', 'border-green-400');
      } else if (radio.value == selectedChoiceId) {
        label.classList.add('bg-red-100', 'border-red-400');
      } else {
        label.classList.add('opacity-50');
      }
    });
  }

  disableChoices() {
    this.choiceTargets.forEach(radio => {
      radio.disabled = true;
      radio.closest('label').dataset.action = ''; // remove click action
    });
  }

  toggleExplanation() {
    this.explanationTarget.classList.toggle('hidden');
  }

  nextQuestion() {
    Turbo.visit(this.nextUrlValue);
  }
}
