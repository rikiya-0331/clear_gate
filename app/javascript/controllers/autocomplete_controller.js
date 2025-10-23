// app/javascript/controllers/autocomplete_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = { url: String, debounce: { type: Number, default: 300 } }

  connect() {
    this.timeout = null
    console.log("Autocomplete controller connected!")
    console.log("URL value:", this.urlValue)
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const keyword = this.inputTarget.value.trim()
      console.log("Searching for:", keyword)

      if (keyword.length === 0) {
        this.resultsTarget.innerHTML = ""
        return
      }

      this.fetchResults(keyword)
    }, this.debounceValue)
  }

  async fetchResults(keyword) {
    const timestamp = new Date().getTime() // キャッシュ回避用のタイムスタンプ
    const url = `${this.urlValue}?keyword=${encodeURIComponent(keyword)}&_=${timestamp}`
    console.log("Fetching from:", url)

    try {
      const response = await fetch(url, {
        headers: {
          "Accept": "application/json",
          "Cache-Control": "no-cache", // フロントエンドでのキャッシュ無効化
          "Pragma": "no-cache"
        }
      })
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }

      const data = await response.json()
      console.log("Received data:", data)
      this.displayResults(data)
    } catch (error) {
      console.error("Error fetching autocomplete results:", error)
      this.resultsTarget.innerHTML = `<div class="p-2 text-red-500">検索中にエラーが発生しました。</div>`
    }
  }

  displayResults(data) {
    this.resultsTarget.innerHTML = ""
    if (data.length === 0) {
      this.resultsTarget.innerHTML = `<div class="p-2 text-red-500 font-bold">該当する質問は見つかりませんでした。</div>`
      return
    }

    const ul = document.createElement("ul")
    ul.className = "bg-white border border-gray-300 rounded-md shadow-lg mt-1 max-h-60 overflow-y-auto"

    data.forEach(question => {
      const li = document.createElement("li")
      li.className = "p-2 hover:bg-gray-100 cursor-pointer"
      li.innerHTML = `<div>${question.title_en}</div><div class="text-xs text-gray-500">${question.title_jp}</div>` // 英文と日本語訳を表示
      li.addEventListener("click", () => {
        this.inputTarget.value = question.title_en // 選択した英文タイトルを検索ボックスにセット
        this.resultsTarget.innerHTML = "" // 候補リストをクリア
        // 必要であれば、ここでフォームを再送信するか、ページをリロードするなどの処理を追加
        // 例: this.element.requestSubmit(); // フォーム全体を送信
      })
      ul.appendChild(li)
    })
    this.resultsTarget.appendChild(ul)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
