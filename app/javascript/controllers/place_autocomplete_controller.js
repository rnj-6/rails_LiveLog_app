import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "address"]

  static values = {
    apiKey: String
  }

  search() {
    const query = this.inputTarget.value.trim()

    if (query === "") {
      this.resultsTarget.innerHTML = ""
      this.addressTarget.value = ""
      return
    }

    this.fetchResults(query)
  }

  async fetchResults(query) {
    try {
      const response = await fetch(
        "https://places.googleapis.com/v1/places:autocomplete",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": this.apiKeyValue
          },
          body: JSON.stringify({
            input: query,
            includedRegionCodes: ["jp"],
            languageCode: "ja"
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

      const button = document.createElement("button")
      button.type = "button"

      const mainText = document.createElement("div")
      mainText.textContent = place.structuredFormat.mainText.text

      const secondaryText = document.createElement("div")
      secondaryText.textContent =
        place.structuredFormat.secondaryText?.text || ""

      button.appendChild(mainText)
      button.appendChild(secondaryText)

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