import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-turbo-links"
export default class extends Controller {
  static targets = ["checkbox", "link"]
  connect() {
    this.updateLinks();
  }

  updateLinks() {
    const isChecked = this.checkboxTarget.checked;
    this.linkTargets.forEach(link => {
      const url = new URL(link.href);
      url.searchParams.set("wrong_translations", isChecked);
      link.href = url.toString();
    });
  }
}
