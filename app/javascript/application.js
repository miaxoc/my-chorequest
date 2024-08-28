// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"


// accordion stuff

document.addEventListener("turbo:load", function() {
  bindAccordionEvents();
  restoreAccordionState();
});

document.addEventListener("turbo:frame-load", function(event) {
  if (event.target.id === "tasks-frame") {  // Check if the loaded frame is the tasks frame
    bindAccordionEvents();
    restoreAccordionState();
  }
});

function bindAccordionEvents() {
  var acc = document.getElementsByClassName("accordion");
  for (var i = 0; i < acc.length; i++) {
    acc[i].removeEventListener("click", toggleAccordion);
    acc[i].addEventListener("click", toggleAccordion);
  }
}

function toggleAccordion() {
  this.classList.toggle("active");
  var panel = this.nextElementSibling;
  if (panel.style.display === "block") {
    panel.style.display = "none";
  } else {
    panel.style.display = "block";
  }
  saveAccordionState();
}

function saveAccordionState() {
  var acc = document.getElementsByClassName("accordion");
  var state = [];
  for (var i = 0; i < acc.length; i++) {
    state.push(acc[i].classList.contains("active"));
  }
  localStorage.setItem("accordionState", JSON.stringify(state));
}

function restoreAccordionState() {
  var acc = document.getElementsByClassName("accordion");
  var state = JSON.parse(localStorage.getItem("accordionState"));
  if (state) {
    for (var i = 0; i < acc.length; i++) {
      if (state[i]) {
        acc[i].classList.add("active");
        acc[i].nextElementSibling.style.display = "block";
      } else {
        acc[i].classList.remove("active");
        acc[i].nextElementSibling.style.display = "none";
      }
    }
  }
}

// user show page scroll stuff

let savedScrollPosition = 0;

// Save the scroll position before the Turbo Frame updates
document.addEventListener("turbo:before-fetch-request", function() {
  savedScrollPosition = window.scrollY || document.documentElement.scrollTop;
  localStorage.setItem('scrollPosition', savedScrollPosition);
});

// Restore the scroll position after the Turbo Frame loads
document.addEventListener("turbo:frame-load", function(event) {
  if (event.target.id === "tasks-frame") {  // Ensure it’s the correct frame
    const scrollPosition = localStorage.getItem('scrollPosition');
    if (scrollPosition) {
      window.scrollTo(0, scrollPosition);
    }
    // Re-bind accordion events and restore state
    bindAccordionEvents();
    restoreAccordionState();
  }
});


// user search stuff

document.addEventListener("turbo:load", function() {
  // Check if the current page is households/new
  if (window.location.pathname === '/households/new') {
    const userSearch = document.getElementById('user-search');
    const userResults = document.getElementById('user-results');
    const selectedUsers = document.getElementById('selected-users');
    const userIdsField = document.getElementById('user-ids-field');

    if (!userSearch) {
      console.error('Search bar element not found!');
      return;
    }

    userSearch.addEventListener('input', function() {
      const query = userSearch.value.trim();

      if (query.length === 0) {
        userResults.innerHTML = ''; // Clear the results if the input is empty
        userResults.classList.remove('show');
        return;
      }

      fetch(`/households/search_users?query=${encodeURIComponent(query)}`, {
        headers: {
          'Accept': 'application/json'
        }
      })
      .then(response => response.json())
      .then(users => {
        userResults.innerHTML = ''; // Clear previous results
        userResults.classList.add('show'); // Show the dropdown

        users.forEach(user => {
          const userElement = document.createElement('li');
          userElement.textContent = user[1]; // user[1] is the username
          userElement.classList.add('dropdown-item');
          userElement.dataset.userId = user[0]; // user[0] is the ID

          userElement.addEventListener('click', function() {
            addUser(user);
            userResults.classList.remove('show'); // Hide dropdown after selection
          });

          userResults.appendChild(userElement);
        });
      })
      .catch(error => {
        console.error('Error fetching users:', error);
      });
    });

    function addUser(user) {
      // Avoid adding the same user twice
      if (document.querySelector(`input[value="${user[0]}"]`)) {
        return;
      }

      // Add user to selected users list
      const userElement = document.createElement('div');
      userElement.textContent = user[1];
      userElement.classList.add('selected-user', 'badge', 'bg-primary', 'me-2');
      selectedUsers.appendChild(userElement);

      // Add user ID to hidden input field for form submission
      const hiddenInput = document.createElement('input');
      hiddenInput.type = 'hidden';
      hiddenInput.name = 'household[user_ids][]';
      hiddenInput.value = user[0];
      selectedUsers.appendChild(hiddenInput);

      // Append the new user ID to the existing hidden field's value
      let currentUserIds = userIdsField.value ? userIdsField.value.split(',') : [];
      currentUserIds.push(user[0]);
      userIdsField.value = currentUserIds.join(',');
    }
  }
});
