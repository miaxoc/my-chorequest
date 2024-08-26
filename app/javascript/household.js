document.addEventListener("turbo:load", function() {
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
      users.forEach(user => {
        const userElement = document.createElement('div');
        userElement.textContent = user[1]; // user[1] is the username
        userElement.classList.add('user-result');
        userElement.dataset.userId = user[0]; // user[0] is the ID
        userElement.addEventListener('click', function() {
          addUser(user);
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
    userElement.classList.add('selected-user');
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
});
