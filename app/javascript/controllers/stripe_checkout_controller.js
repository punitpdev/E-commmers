// app/javascript/controllers/stripe_checkout_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String,
  }

  async redirectToCheckout(event) {
    event.preventDefault()

    try {
      const response = await fetch('/payments', {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content")
        },
      })

      if (!response.ok) throw new Error("Failed to create checkout session")

      const data = await response.json()
      window.location.href = data.url
    } catch (error) {
      console.error("Checkout error:", error)
      alert("Something went wrong with checkout. Please try again.")
    }
  }
}
