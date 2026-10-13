import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  // HTMLで操作する要素を登録
  static targets = ["input", "results", "address"]
  
  // APIキーを受け取る
  static values = {
    apiKey: String
  }

  // 検索処理
  search() {
    const query = this.inputTarget.value.trim()

    // 入力欄が空の場合は検索候補も空
    if (query === "") {
      this.resultsTarget.innerHTML = ""
      this.addressTarget.value = ""
      return
    }

    this.fetchResults(query)
  }
  
  // Google Places APIから候補を取得
  async fetchResults(query) {
    try {

      // Autocompleteにリクエスト
      const response = await fetch(
        "https://places.googleapis.com/v1/places:autocomplete",
        {
          method: "POST",

          // APIに送信する形式とAPIキーを指定
          headers: {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": this.apiKeyValue
          },
          body: JSON.stringify({
            input: query,                // 入力された検索文字
            includedRegionCodes: ["jp"], // 検索対象のエリア
            languageCode: "ja"           // 検索結果の言語
          })
        }
      )

      const data = await response.json()

      console.log(data)

      this.displayResults(data.suggestions)

    } catch (error) {
      console.error("会場検索エラー:", error)
    }
  }

  displayResults(suggestions) {
    this.resultsTarget.innerHTML = ""

    suggestions.forEach((suggestion) => {
      const place = suggestion.placePrediction

      if (!place) return

      // 候補1件分のボタン
      const button = document.createElement("button")
      button.type = "button"
      button.className = "venue-suggestion"

      // 会場名の要素
      const mainText = document.createElement("div")
      mainText.textContent = place.structuredFormat.mainText.text
      mainText.className = "venue-suggestion-name"

      // 住所の要素
      const secondaryText = document.createElement("div")
      secondaryText.textContent =
        place.structuredFormat.secondaryText?.text || ""
      secondaryText.className = "venue-suggestion-address"
      
      button.appendChild(mainText)
      button.appendChild(secondaryText)

      // 候補ボタンがクリックされたときの処理
      button.addEventListener("click", () => {
        this.inputTarget.value =
          place.structuredFormat.mainText.text

        this.addressTarget.value =
          place.structuredFormat.secondaryText?.text || ""

        this.resultsTarget.innerHTML = ""
      })

      this.resultsTarget.appendChild(button)
    })
  }
}