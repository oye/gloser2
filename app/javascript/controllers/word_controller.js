import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  remove(event) {
    event.preventDefault(); // Prevent link default behavior

    // Remove the closest `.nested-fields` container
    const wordElement = event.target.closest(".nested-fields");
    if (wordElement) {
      wordElement.remove();
    }
  }
}
