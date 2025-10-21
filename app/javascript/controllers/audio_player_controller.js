import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio-player"
export default class extends Controller {
  static values = { url: String }
  static targets = [ "playIcon", "playingIcon" ]

  connect() {
    this.isPlaying = false;
  }

  play() {
    if (this.isPlaying) {
      return;
    }

    const audio = new Audio(this.urlValue);
    this.isPlaying = true;
    this.updateUI(true);

    audio.addEventListener("ended", () => {
      this.isPlaying = false;
      this.updateUI(false);
    });

    audio.addEventListener("error", () => {
      this.isPlaying = false;
      this.updateUI(false);
      console.error("Audio playback failed.");
    });

    audio.play();
  }

  updateUI(playing) {
    if (playing) {
      this.playIconTarget.classList.add("hidden");
      this.playingIconTarget.classList.remove("hidden");
    } else {
      this.playIconTarget.classList.remove("hidden");
      this.playingIconTarget.classList.add("hidden");
    }
  }
}
