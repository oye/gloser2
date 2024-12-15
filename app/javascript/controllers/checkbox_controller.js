import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["option"];
  check() {
    console.log("checked", this.optionTargets);
    const checkedOptions = this.optionTargets.filter(input => input.checked);

    // If no checkbox is checked, re-check the last unchecked checkbox
    if (checkedOptions.length === 0) {
      const lastUnchecked = event.currentTarget;
      lastUnchecked.checked = true;
    }
  }
}