import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calendar"
export default class extends Controller {
  static targets = ["date", "modalBody"]

  showDate(event) {
    const clickedElement = event.currentTarget;
    const clickedDate = clickedElement.getAttribute("data-date");
    console.log("Clicked Date:", clickedDate);
    console.log("Modal Title Target:", this.dateTarget);

    this.dateTarget.innerText = `Tasks for ${clickedDate}`;
  }
}
















  // async fetchTasksForDate(date) {
  //   try {
  //     const response = await fetch(`/households/tasks_for_date?date=${encodeURIComponent(date)}`, {
  //       headers: {
  //         "Accept": "text/html" // Expect HTML response
  //       }
  //     });

  //     if (response.ok) {
  //       this.modalBodyTarget.innerHTML = await response.text();
  //     } else {
  //       console.error("Failed to fetch tasks:", response.statusText);
  //     }
  //   } catch (error) {
  //     console.error("Error fetching tasks:", error);
  //   }
  // }
