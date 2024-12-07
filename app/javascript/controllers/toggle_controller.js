import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["accordion"]

  //connect() {
  //  this.element.textContent = "Hello World!"
  //}
  toggle(event) {
    const show = event.target.checked
    this.accordionTargets.forEach(accordion => {
      if (show) {
        accordion.classList.remove("d-none")
      } else {
        accordion.classList.add("d-none")
      }
    })
  }
}